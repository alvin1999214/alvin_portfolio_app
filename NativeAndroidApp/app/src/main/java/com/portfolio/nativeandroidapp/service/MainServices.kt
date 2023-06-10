package com.portfolio.nativeandroidapp.service

import android.content.Context
import com.portfolio.nativeandroidapp.model.response.DisneyCharacterResponse
import com.portfolio.nativeandroidapp.network.RetrofitClient
import com.portfolio.nativeandroidapp.network.security.SecurityCheckOperator
import io.reactivex.Observable

class MainServices: BaseService<Endpoint>() {
//    override fun getEndpointClass(): Class<Endpoint> {
//        return Endpoint::class.java
//    }
    override val endpointClass: Class<Endpoint>
        protected get() = Endpoint::class.java

    fun getDisneyCharacter(context: Context): Observable<DisneyCharacterResponse>? {
        serviceInstance = RetrofitClient.getDefaultInstance()?.create(endpointClass)
        return serviceInstance?.getDisneyCharacter()?.lift(SecurityCheckOperator(context))
    }
}