package com.portfolio.nativeandroidapp.network.security

import android.content.Context
import android.os.Build
import androidx.annotation.RequiresApi
import io.reactivex.ObservableOperator
import io.reactivex.Observer
import io.reactivex.disposables.Disposable
import java.lang.ref.WeakReference
import kotlin.jvm.Throws

class SecurityCheckOperator<T>(context: Context?) :
    ObservableOperator<T, T> {
    private val mContext: WeakReference<Context?>
    private var mPendingResume = false

    @Throws(Exception::class)
    override fun apply(observer: Observer<in T>): Observer<in T> {
        return object : Observer<T> {
            override fun onSubscribe(d: Disposable) {
                observer.onSubscribe(d)
            }

            @RequiresApi(Build.VERSION_CODES.M)
            override fun onNext(t: T) {
                if (mContext.get() != null) {
                    if (AppSecurityManager.instance?.isSecuredDevice == true) {
                        observer.onNext(t)
                    } else {
                        mPendingResume = true
                        AppSecurityRepository.instance?.addProcessToPendingResumeQueue(Runnable {
                            if (observer != null) {
                                observer.onNext(t)
                                observer.onComplete()
                            }
                        })
                    }
                } else {
                    observer.onError(NullPointerException("Context reference is null"))
                }
            }

            override fun onError(e: Throwable) {
                observer.onError(e)
            }

            override fun onComplete() {
                if (!mPendingResume) {
                    observer.onComplete()
                }
            }
        }
    }

    init {
        mContext = WeakReference(context)
    }
}