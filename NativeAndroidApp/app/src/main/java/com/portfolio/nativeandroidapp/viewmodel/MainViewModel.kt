package com.portfolio.nativeandroidapp.viewmodel

import android.app.Application
import android.content.Context
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.portfolio.nativeandroidapp.model.response.DisneyCharacterResponse
import com.portfolio.nativeandroidapp.service.MainRepository
import com.portfolio.nativeandroidapp.service.MainServices
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.observers.DisposableObserver
import io.reactivex.schedulers.Schedulers

class MainViewModel(application: Application): BaseViewModel(application) {
    private val mMainServices = MainServices()
    private var _disneyCharacterGetResponse = MutableLiveData<DisneyCharacterResponse>()
    val disneyCharacterGetResponse: LiveData<DisneyCharacterResponse> = _disneyCharacterGetResponse


    // Call by Repository
    fun disneyCharacterGetRepository(context: Context) {
        mCompositeDisposable.add(
            MainRepository.instance.getDisneyCharacter(context)
                ?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                !!.subscribeWith(object : DisposableObserver<DisneyCharacterResponse>() {
                    override fun onStart() {
                        setLoadingState(true)
                    }

                    override fun onNext(data: DisneyCharacterResponse) {
                        setLoadingState(false)
                        _disneyCharacterGetResponse.postValue(data)
                    }

                    override fun onError(e: Throwable) {
                        setLoadingState(false)
                        handleApiError(e)
                    }

                    override fun onComplete() {}
                })
        )
    }

    // Call by Services
    fun disneyCharacterGetService(context: Context) {
        mCompositeDisposable.add(
            mMainServices.getDisneyCharacter(context)
                ?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                !!.subscribeWith(object : DisposableObserver<DisneyCharacterResponse>() {
                    override fun onStart() {
                        setLoadingState(true)
                    }

                    override fun onNext(data: DisneyCharacterResponse) {
                        setLoadingState(false)
                        _disneyCharacterGetResponse.postValue(data)
                    }

                    override fun onError(e: Throwable) {
                        setLoadingState(false)
                        handleApiError(e)
                    }

                    override fun onComplete() {}
                })
        )
    }
}