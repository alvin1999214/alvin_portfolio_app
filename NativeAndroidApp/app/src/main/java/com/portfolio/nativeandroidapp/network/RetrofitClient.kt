package com.portfolio.nativeandroidapp.network

import okhttp3.Interceptor
import retrofit2.Retrofit

object RetrofitClient {
    private var retrofit: Retrofit? = null

    fun setRetrofit(retrofit: Retrofit){
        RetrofitClient.retrofit = retrofit
    }

    fun getDefaultInstance(): Retrofit? {
        return retrofit
    }

}