package com.portfolio.nativeandroidapp.model

import java.io.Serializable

class AppError private constructor() : Serializable {
    interface OnRetryListener {
        fun onRetry()
    }

    interface OnCancelListener {
        fun onCancel()
    }

    var tag: String? = null
        private set
    var throwable: Throwable? = null
        private set
    var isRecoverable = false
        private set
    private var mOnRetryListener: OnRetryListener? = null
    private var mOnCancelListener: OnCancelListener? = null

    private fun setTag(tag: String) {
        this.tag = tag
    }

    private fun setOnRetryListener(onRetryListener: OnRetryListener?) {
        mOnRetryListener = onRetryListener
    }

    private fun setOnCancelListener(onCancelListener: OnCancelListener?) {
        mOnCancelListener = onCancelListener
    }

    fun retry() {
        if (mOnRetryListener != null) {
            mOnRetryListener!!.onRetry()
        }
    }

    override fun toString(): String {
        return "AppError{" +
                "mTag='" + tag + '\'' +
                ", mThrowable=" + throwable +
                ", mRecoverable=" + isRecoverable +
                ", mOnRetryListener=" + mOnRetryListener +
                ", mOnCancelListener=" + mOnCancelListener +
                '}'
    }

    class Builder(private val mTag: String) {
        private var mThrowable: Throwable? = null
        private var mRecoverable = false
        private var mOnRetryListener: OnRetryListener? = null
        private var mOnCancelListener: OnCancelListener? = null
        fun setThrowable(throwable: Throwable?): Builder {
            mThrowable = throwable
            return this
        }

        fun setRecoverable(recoverable: Boolean): Builder {
            mRecoverable = recoverable
            return this
        }

        fun setOnRetryListener(onRetryListener: OnRetryListener?): Builder {
            mOnRetryListener = onRetryListener
            return this
        }

        fun setOnCancelListener(onCancelListener: OnCancelListener?): Builder {
            mOnCancelListener = onCancelListener
            return this
        }

        fun build(): AppError {
            val error = AppError()
            error.setTag(mTag)
            error.throwable = mThrowable
            error.isRecoverable = mRecoverable
            error.setOnRetryListener(mOnRetryListener)
            error.setOnCancelListener(mOnCancelListener)
            return error
        }

    }

    companion object {
        fun builder(source: String): Builder {
            return Builder(source)
        }
    }
}