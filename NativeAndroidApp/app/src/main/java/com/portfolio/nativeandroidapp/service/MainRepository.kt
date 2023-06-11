package com.portfolio.nativeandroidapp.service

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.lifecycle.LiveDataReactiveStreams
import com.portfolio.nativeandroidapp.model.response.BankListResponse
import com.portfolio.nativeandroidapp.model.response.DisneyCharacterResponse
import com.portfolio.nativeandroidapp.model.response.JsonPlaceHolderPostResponse
import io.reactivex.BackpressureStrategy
import io.reactivex.subjects.PublishSubject
import io.reactivex.Observable

class MainRepository {

    var mMainServices = MainServices()
    private val mErrorResponse =
        PublishSubject.create<String>()
    var errorHttpException: LiveData<Map<String, String>>? = null

    val errorResponse: LiveData<String>
        get() = LiveDataReactiveStreams.fromPublisher(mErrorResponse.toFlowable(BackpressureStrategy.LATEST))

    fun setErrorResponse(response: String) {
        mErrorResponse.onNext(response)
    }

    companion object {
        val TAG = MainRepository::class.java.simpleName
        private lateinit var sInstance: MainRepository

        @get:Synchronized
        val instance: MainRepository
            get() {
                if (!this::sInstance.isInitialized) {
                    sInstance = MainRepository()
                }
                return sInstance
            }

//        fun close() {
//            if (sInstance != null && sInstance!!.mUuid != null && sInstance!!.mUuid!!.hasObservers()) {
//                Logger.w(
//                    TAG,
//                    "Unable to close $TAG because of the LiveData in $TAG has active observers"
//                )
//            } else {
//                sInstance = null
//            }
//        }
    }

    fun getDisneyCharacter(
        context: Context
    ):Observable<DisneyCharacterResponse>? {
        return mMainServices.getDisneyCharacter(context)
    }

    fun getBankList(
        context: Context,
    ) :Observable<BankListResponse>? {
        return mMainServices.getBankList(context)
    }

    fun getPostList(
        context: Context,
    ) :Observable<JsonPlaceHolderPostResponse>? {
        return mMainServices.getPostList(context) ?:Observable.empty()
    }
}