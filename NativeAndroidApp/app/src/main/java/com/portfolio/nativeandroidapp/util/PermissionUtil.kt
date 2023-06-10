package com.portfolio.nativeandroidapp.util

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.RequiresApi

object PermissionUtil {
    @RequiresApi(Build.VERSION_CODES.M)
    fun isPermissionAllGranted(
        context: Context,
        vararg permissions: String?
    ): Boolean {
        for (permission in permissions) {
            if (context.checkSelfPermission(permission!!) != PackageManager.PERMISSION_GRANTED) {
                return false
            }
        }
        return true
    }

    fun isResultAllGranted(grantResults: IntArray): Boolean {
        for (i in grantResults.indices) {
            if (grantResults[i] != PackageManager.PERMISSION_GRANTED) {
                return false
            }
        }
        return true
    }

    fun isPermissionGranted(
        context: Context,
        permissions: String?
    ): Boolean {
        return context.checkSelfPermission(permissions!!) == PackageManager.PERMISSION_GRANTED
    }
}