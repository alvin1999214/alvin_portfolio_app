package com.portfolio.nativeandroidapp.network.security

import androidx.lifecycle.MutableLiveData
import java.util.*

internal class AppSecurityRepository private constructor() {
    private var mSecurityStatus: MutableLiveData<AppSecurityStatus>? = null
    private var mPendingResumeProcesses: Queue<Runnable>? = null
    private var mSecurityErrorCodes: MutableList<String>? = null
    var securityStatus: AppSecurityStatus
        get() {
            if (mSecurityStatus == null) {
                mSecurityStatus = MutableLiveData<AppSecurityStatus>()
                mSecurityStatus!!.setValue(AppSecurityStatus.INITIALED)
            }
            return mSecurityStatus?.value!!
        }
        set(status) {
            if (mSecurityStatus == null) {
                mSecurityStatus = MutableLiveData<AppSecurityStatus>()
            }
            mSecurityStatus!!.postValue(status)
        }

    val pendingResumeProcessQueue: Queue<Runnable>
        get() {
            if (mPendingResumeProcesses == null) {
                mPendingResumeProcesses = LinkedList()
            }
            return mPendingResumeProcesses!!
        }

    fun addProcessToPendingResumeQueue(runnable: Runnable) {
        if (mPendingResumeProcesses == null) {
            mPendingResumeProcesses = LinkedList()
        }
        mPendingResumeProcesses!!.add(runnable)
    }

    val securityErrorCodes: List<String>
        get() {
            if (mSecurityErrorCodes == null) {
                mSecurityErrorCodes = ArrayList()
            }
            return if (mSecurityErrorCodes!!.isEmpty()) {
                mSecurityErrorCodes!!
            } else {
                val output: List<String> =
                    ArrayList(mSecurityErrorCodes)
                mSecurityErrorCodes!!.clear()
                output
            }
        }

    fun addSecurityErrorCode(code: String) {
        if (mSecurityErrorCodes == null) {
            mSecurityErrorCodes = ArrayList()
        }
        mSecurityErrorCodes!!.add(code)
    }

    companion object {
        private var sInstance: AppSecurityRepository? = null

        @get:Synchronized
        val instance: AppSecurityRepository?
            get() {
                if (sInstance == null) {
                    sInstance = AppSecurityRepository()
                }
                return sInstance
            }

        fun close() {
            sInstance = null
        }
    }
}