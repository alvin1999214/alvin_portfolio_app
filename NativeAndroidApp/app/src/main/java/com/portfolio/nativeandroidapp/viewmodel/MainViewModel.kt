package com.portfolio.nativeandroidapp.viewmodel

import android.app.Application
import android.content.Context
import android.os.Handler
import android.os.Looper
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.gson.reflect.TypeToken
import com.portfolio.nativeandroidapp.R
import com.portfolio.nativeandroidapp.model.response.BankListResponse
import com.portfolio.nativeandroidapp.model.response.DisneyCharacterResponse
import com.portfolio.nativeandroidapp.model.response.JsonPlaceHolderPostResponse
import com.portfolio.nativeandroidapp.service.Constants.Companion.isMock
import com.portfolio.nativeandroidapp.service.MainRepository
import com.portfolio.nativeandroidapp.service.MainServices
import com.portfolio.nativeandroidapp.util.JsonParser
import com.portfolio.nativeandroidapp.util.ResourcesUtil
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.observers.DisposableObserver
import io.reactivex.schedulers.Schedulers

class MainViewModel(application: Application): BaseViewModel(application) {
    private val mMainServices = MainServices()

    private var _bankListResponse = MutableLiveData<BankListResponse>()
    val bankListResponse: LiveData<BankListResponse> = _bankListResponse

    private var _postListResponse = MutableLiveData<JsonPlaceHolderPostResponse>()
    val postListResponse: LiveData<JsonPlaceHolderPostResponse> = _postListResponse

    private var _disneyCharacterGetResponse = MutableLiveData<DisneyCharacterResponse>()
    val disneyCharacterGetResponse: LiveData<DisneyCharacterResponse> = _disneyCharacterGetResponse

    var isGetBankListLoading = false
    var isApiError = false
    var mockApiDelay = 1000L

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

    fun getBankList(context: Context) {
        if (isMock){
            setLoadingState(true)
            val r: BankListResponse = JsonParser.instance!!.fromJson(
                ResourcesUtil.readStringForRawFile(
                    context.resources,
                    R.raw.mock_bank_list_response
                ),
                object : TypeToken<BankListResponse?>() {}.type
            )
            isGetBankListLoading = true
            // simulate loading
            Handler(Looper.getMainLooper()).postDelayed({
                _bankListResponse.postValue(r)
                isGetBankListLoading = false
                setLoadingState(false)
            }, mockApiDelay)
        } else {
            mCompositeDisposable.add(
                MainRepository.instance.getBankList(context)
                    ?.subscribeOn(Schedulers.io())
                    ?.observeOn(AndroidSchedulers.mainThread())
                !!.subscribeWith(object : DisposableObserver<BankListResponse>() {
                        override fun onStart() {
                            isGetBankListLoading = true
                            setLoadingState(true)
                        }

                        override fun onNext(data: BankListResponse) {
                            _bankListResponse.postValue(data)
                            isGetBankListLoading = false
                            setLoadingState(false)
                        }

                        override fun onError(e: Throwable) {
                            isGetBankListLoading = false
                            isApiError = true
                            setLoadingState(false)
                            handleApiError(e)
                        }

                        override fun onComplete() {}
                    })
            )
        }
    }

    fun getPostList(context: Context) {
        mCompositeDisposable.add(
            MainRepository.instance.getPostList(context)
                ?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
            !!.subscribeWith(object : DisposableObserver<JsonPlaceHolderPostResponse>() {
                    override fun onStart() {
                        isGetBankListLoading = true
                        setLoadingState(true)
                    }

                    override fun onNext(data: JsonPlaceHolderPostResponse) {
                        _postListResponse.postValue(data)
                        isGetBankListLoading = false
                        setLoadingState(false)
                    }

                    override fun onError(e: Throwable) {
                        isGetBankListLoading = false
                        isApiError = true
                        setLoadingState(false)
                        handleApiError(e)
                    }

                    override fun onComplete() {}
                })
        )
    }
}