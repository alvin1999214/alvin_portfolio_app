package com.portfolio.nativeandroidapp.viewmodel

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.LiveDataReactiveStreams
import androidx.lifecycle.MutableLiveData
import com.portfolio.nativeandroidapp.model.AppError
import com.portfolio.nativeandroidapp.model.AppEvent
import com.portfolio.nativeandroidapp.model.LoadingState
import com.portfolio.nativeandroidapp.util.ExceptionDialogUtil
import io.reactivex.BackpressureStrategy
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.subjects.PublishSubject
import retrofit2.HttpException
import java.lang.IllegalStateException
import java.net.ConnectException
import java.net.SocketTimeoutException
import java.net.UnknownHostException

abstract class BaseViewModel(application: Application) : AndroidViewModel(application) {
    private var mLoadingState: MutableLiveData<LoadingState>? = null
    private val mEvent: PublishSubject<AppEvent> =
        PublishSubject.create<AppEvent>()
    private val mError: PublishSubject<AppError> =
        PublishSubject.create<AppError>()
    protected var mCompositeDisposable =
        CompositeDisposable()

    fun disposeCompositeDisposable() {
        mCompositeDisposable.dispose()
        mCompositeDisposable = CompositeDisposable()
    }

    fun clearCompositeDisposable() {
        mCompositeDisposable.clear()
    }

    override fun onCleared() {
        super.onCleared()
        mCompositeDisposable.dispose()
        mEvent.onComplete()
    }

    protected fun setLoadingState(loading: Boolean) {
        if (mLoadingState == null) {
            mLoadingState = MutableLiveData<LoadingState>()
        }
        mLoadingState!!.postValue(LoadingState(loading))
    }

    protected fun setLoadingState(state: LoadingState) {
        if (mLoadingState == null) {
            mLoadingState = MutableLiveData<LoadingState>()
        }
        mLoadingState!!.postValue(state)
    }

    protected fun setLoadingState(tag:String?, loading: Boolean) {
        if (mLoadingState == null) {
            mLoadingState = MutableLiveData<LoadingState>()
        }
        mLoadingState!!.postValue(LoadingState(tag,loading))
    }

    public val loadingState: LiveData<LoadingState>
        get() {
            if (mLoadingState == null) {
                mLoadingState = MutableLiveData<LoadingState>()
            }
            return mLoadingState!!
        }

    protected fun sendEvent(event: AppEvent) {
        mEvent.onNext(event)
    }

    val event: LiveData<AppEvent>
        get() = LiveDataReactiveStreams.fromPublisher(mEvent.toFlowable(BackpressureStrategy.LATEST))

    protected fun sendError(error: AppError) {
        mError.onNext(error)
    }

    val error: LiveData<AppError>
        get() = LiveDataReactiveStreams.fromPublisher(mError.toFlowable(BackpressureStrategy.BUFFER))

    protected fun handleApiError(e: Throwable) {
        when (e) {
            is HttpException,
            is IllegalStateException -> {
                // response received by NetworkErrorInterceptor in Card+
            }
            is ConnectException,
            is UnknownHostException -> {
                // network error
                sendError(AppError.Builder(ExceptionDialogUtil.ExceptionType.NETWORK_ERROR.value).build())
            }
            is SocketTimeoutException -> {
                sendError(AppError.Builder(ExceptionDialogUtil.ExceptionType.SOCKET_TIMEOUT.value).build())
            }
            else -> sendError(AppError.Builder(ExceptionDialogUtil.ExceptionType.OTHER_EXCEPTION.value).setThrowable(e).build())
        }
    }
}