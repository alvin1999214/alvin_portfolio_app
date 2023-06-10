package com.portfolio.nativeandroidapp.network.security

import android.Manifest
import android.annotation.SuppressLint
import android.app.ActivityManager
import android.app.Application
import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.os.Build
import android.os.Debug
import android.os.Process
import androidx.annotation.RequiresApi
import com.portfolio.nativeandroidapp.R
import com.portfolio.nativeandroidapp.util.PermissionUtil
import com.portfolio.nativeandroidapp.util.RandomString
import io.reactivex.Observable
import io.reactivex.schedulers.Schedulers
import java.io.*
import java.lang.ref.WeakReference
import java.util.*

class AppSecurityManager private constructor(application: Application) {
    private val mApplication: WeakReference<Application>
    fun onRequestPermissionsResult(
        permissions: Array<String?>,
        grantResults: IntArray
    ) {
        if (permissions.size > 0) {
            if (PermissionUtil.isResultAllGranted(grantResults)) {
                if (isSecuredDevice) {
                    resumeAllProcess()
                } else {
                    AppSecurityRepository.instance?.securityStatus =
                        AppSecurityStatus.UNSECURED_DEVICE
                }
            } else {
                AppSecurityRepository.instance?.securityStatus = AppSecurityStatus.PERMISSION_DENIED
            }
        }
    }

    @SuppressLint("CheckResult")
    private fun resumeAllProcess() {
        val processes: Queue<Runnable>? =
            AppSecurityRepository.instance?.pendingResumeProcessQueue
        val runnableArray =
            arrayOfNulls<Runnable>(processes?.size?:0)
        var index = 0
        while (processes?.isEmpty()==false) {
            runnableArray[index++] = processes?.poll()
        }
        Observable.fromArray<Runnable>(*runnableArray)
            .subscribeOn(Schedulers.io())
            .subscribe { obj: Runnable -> obj.run() }
    }

    val securityErrorCodes: List<String>
        get() = AppSecurityRepository.instance?.securityErrorCodes ?: mutableListOf()

    val isSecuredDevice: Boolean
        @RequiresApi(Build.VERSION_CODES.M)
        get() {
            val application = mApplication.get() ?: return false
            if (!PermissionUtil.isPermissionAllGranted(
                    application,
                    *REQUIRED_PERMISSIONS
                )
            ) {
                AppSecurityRepository.instance?.securityStatus =
                    AppSecurityStatus.MISSING_PERMISSION
                return false
            }
            var secured = true
            var su = false
            if (isRootFileExist(application)) {
                secured = false
                su = true
            }
            if (isSuperUserInPathEnv(application)) {
                secured = false
                su = true
            }
            if (isRootServiceRunning(application)) {
                secured = false
                su = true
            }
            if (isRootToolInstalled(application)) {
                secured = false
                su = true
            }
            if (isDirectoryPermissionGrantedForRoot(application)) {
                secured = false
                su = true
            }
            if (isBusyBoxExist(application) && su) {
                secured = false
            }
            if (isTestKeyBuild(application)) {
                secured = false
            }
//            if (!BuildConfig.DEBUG && isDebuggable(application)) {
//                secured = false
//            }
//            if (!BuildConfig.DEBUG && isDebuggerActive(application)) {
//                secured = false
//            }
            if (isPtraceActive(application)) {
                secured = false
            }
            if (isRuntimeIntegrityCheckFail(application)) {
                secured = false
            }
            if (isEmulatorChecking(application) && su) {
                secured = false
            }
            if (isSuspiciousPathExistInMemory(application)) {
                secured = false
            }
            AppSecurityRepository.instance?.securityStatus = (if (secured) AppSecurityStatus.SECURED_DEVICE else AppSecurityStatus.UNSECURED_DEVICE)
            return secured
        }

    private fun isRootFileExist(context: Context): Boolean {
        var testNumber = 1
        var exist = false
        for (path in context.resources.getStringArray(R.array.root_files)) {
            if (File(path).exists()) {
                addErrorCodeToRepo(context, testNumber)
                exist = true
            }
            testNumber++
        }
        return exist
    }

    private fun isSuperUserInPathEnv(context: Context): Boolean {
        for (pathDir in System.getenv("PATH").split(":".toRegex())
            .toTypedArray()) {
            if (File(pathDir, "su").exists()) {
                addErrorCodeToRepo(context, 14)
                return true
            }
        }
        return false
    }

    private fun isRootServiceRunning(context: Context): Boolean {
        var exist = false
        val manager =
            context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        if (manager == null) {
            addErrorCodeToRepo(context, 15)
            return true
        }
        var testNumber = 16
        val list =
            manager.getRunningServices(300)
        if (list != null) {
            var tempName: String
            for (i in list.indices) {
                tempName = list[i].process
                for (rootService in context.resources
                    .getStringArray(R.array.root_services)) {
                    if (tempName.contains(rootService)) {
                        addErrorCodeToRepo(context, testNumber)
                        exist = true
                        break
                    }
                }
                testNumber++
            }
        }
        return exist
    }

    private fun isRootToolInstalled(context: Context): Boolean {
        var installed = false
        val packageManager = context.packageManager
        var testNumber = 20
        for (packageName in context.resources
            .getStringArray(R.array.root_tools)) {
            try {
                packageManager.getPackageInfo(packageName, 0)
                addErrorCodeToRepo(context, testNumber)
                installed = true
                break
            } catch (e: PackageManager.NameNotFoundException) {
                // not found
            }
            testNumber++
        }
        return installed
    }

    private fun isDirectoryPermissionGrantedForRoot(context: Context): Boolean {
        var testNumber = 34
        var granted = false
        val randomString = RandomString(16)
        for (directory in context.resources
            .getStringArray(R.array.root_dir_permission)) {
            try {
                File(directory, randomString.nextString()).createNewFile()
                addErrorCodeToRepo(context, testNumber)
                granted = true
            } catch (e: IOException) {
            }
            testNumber++
        }
        return granted
    }

    private fun isBusyBoxExist(context: Context): Boolean {
        if (File(context.getString(R.string.busybox_path)).exists()) {
            addErrorCodeToRepo(context, 46)
            return true
        }
        return false
    }

    private fun isTestKeyBuild(context: Context): Boolean {
        val tags = Build.TAGS
        if (tags != null && tags.contains("test-keys")) {
            addErrorCodeToRepo(context, 47)
            return true
        }
        return false
    }

    private fun isDebuggable(context: Context): Boolean {
        if (context.applicationContext
                .applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE != 0
        ) {
            addErrorCodeToRepo(context, 48)
            return true
        }
        return false
    }

    private fun isDebuggerActive(context: Context): Boolean {
        if (Debug.isDebuggerConnected()) {
            addErrorCodeToRepo(context, 49)
            return true
        }
        return false
    }

    private fun isPtraceActive(context: Context): Boolean {
        var reader: BufferedReader? = null
        try {
            reader = BufferedReader(
                InputStreamReader(FileInputStream("/proc/self/status")),
                1000
            )
            var line: String
            while (reader.readLine().also { line = it } != null) {
                if (line.length > TRACER_PID.length) {
                    if (line.substring(0, TRACER_PID.length)
                            .equals(TRACER_PID, ignoreCase = true)
                    ) {
                        if (Integer.decode(
                                line.substring(TRACER_PID.length + 1)
                                    .trim { it <= ' ' }
                            ) > 0
                        ) {
                            addErrorCodeToRepo(context, 50)
                            return true
                        }
                        break
                    }
                }
            }
        } catch (e: Exception) {
        } finally {
            if (reader != null) {
                try {
                    reader.close()
                } catch (e: IOException) {
                }
            }
        }
        return false
    }

    private fun isRuntimeIntegrityCheckFail(context: Context): Boolean {
        var fail = false
        return try {
            throw Exception()
        } catch (e: Exception) {
            var zygoteInitCallCount = 0
            for (stackTraceElement in e.stackTrace) {
                if (stackTraceElement.className == "com.android.internal.os.ZygoteInit") {
                    zygoteInitCallCount++
                    if (zygoteInitCallCount == 2) {
                        addErrorCodeToRepo(context, 51)
                        fail = true
                    }
                }
                if (stackTraceElement.className == "com.saurik.substrate.MS$2" && stackTraceElement.methodName == "invoked") {
                    addErrorCodeToRepo(context, 52)
                    fail = true
                }
                if (stackTraceElement.className == "de.robv.android.xposed.XposedBridge" && stackTraceElement.methodName == "main") {
                    addErrorCodeToRepo(context, 53)
                    fail = true
                }
                if (stackTraceElement.className == "de.robv.android.xposed.XposedBridge" && stackTraceElement.methodName == "handleHookedMethod") {
                    addErrorCodeToRepo(context, 54)
                    fail = true
                }
            }
            fail
        }
    }

    private fun isEmulatorChecking(context: Context): Boolean {
        var emulator = false
        if ("unknown" == Build.BOARD) {
            addErrorCodeToRepo(context, 55)
            emulator = true
        }
        if ("generic" == Build.BRAND) {
            addErrorCodeToRepo(context, 56)
            emulator = true
        }
        if ("generic" == Build.DEVICE) {
            addErrorCodeToRepo(context, 57)
            emulator = true
        }
        if ("generic" == Build.FINGERPRINT) {
            addErrorCodeToRepo(context, 58)
            emulator = true
        }
        if ("goldfish" == Build.HARDWARE) {
            addErrorCodeToRepo(context, 59)
            emulator = true
        }
        if ("FRF91" == Build.ID) {
            addErrorCodeToRepo(context, 60)
            emulator = true
        }
        if ("unknown" == Build.MANUFACTURER) {
            addErrorCodeToRepo(context, 61)
            emulator = true
        }
        if ("sdk" == Build.MODEL) {
            addErrorCodeToRepo(context, 62)
            emulator = true
        }
        if ("sdk" == Build.PRODUCT) {
            addErrorCodeToRepo(context, 63)
            emulator = true
        }
        if (Build.SERIAL == null) {
            addErrorCodeToRepo(context, 64)
            emulator = true
        }
        if ("test-keys" == Build.TAGS) {
            addErrorCodeToRepo(context, 65)
            emulator = true
        }
        if (emulator) {
        }
        return emulator
    }

    private fun isSuspiciousPathExistInMemory(context: Context): Boolean {
        var exist = false
        try {
            val libraries: MutableSet<String> =
                HashSet()
            val mapsFilename = "/proc/" + Process.myPid() + "/maps"
            BufferedReader(FileReader(mapsFilename)).use { reader ->
                var line: String
                while (reader.readLine().also { line = it } != null) {
                    if (line.endsWith(".so") || line.endsWith(".jar")) {
                        val n = line.lastIndexOf(" ")
                        libraries.add(line.substring(n + 1))
                    }
                }
                for (library in libraries) {
                    if (library.contains("com.saurik.substrate")) {
                        addErrorCodeToRepo(context, 66)
                        exist = true
                    }
                    if (library.contains("XposedBridge.jar")) {
                        addErrorCodeToRepo(context, 67)
                        exist = true
                    }
                }
            }
        } catch (e: Exception) {
        }
        return exist
    }

    private fun addErrorCodeToRepo(context: Context, testId: Int) {
        val codeFormat =
            context.getString(R.string.protection_check_error_code_format)
        AppSecurityRepository.instance?.addSecurityErrorCode(String.format(codeFormat, testId))
    }

    companion object {
        val TAG = AppSecurityManager::class.java.simpleName
        val REQUIRED_PERMISSIONS = arrayOf(
            Manifest.permission.WRITE_EXTERNAL_STORAGE
        )
        private const val TRACER_PID = "TracerPid"
        private var sInstance: AppSecurityManager? = null
        fun init(application: Application) {
            sInstance = AppSecurityManager(application)
        }

        val instance: AppSecurityManager?
            get() {
                if (sInstance == null) {
                    throw RuntimeException("You need to call AppSecurityManager.init() before getting its instance")
                }
                return sInstance
            }
    }

    init {
        mApplication = WeakReference(application)
    }
}