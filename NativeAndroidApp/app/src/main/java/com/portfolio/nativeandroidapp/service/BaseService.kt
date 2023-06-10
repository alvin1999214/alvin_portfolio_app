package com.portfolio.nativeandroidapp.service
import com.portfolio.nativeandroidapp.network.RetrofitClient

abstract class BaseService<EndpointClass> {
    protected var serviceInstance: EndpointClass?
    protected abstract val endpointClass: Class<EndpointClass>?

    init {
        serviceInstance = RetrofitClient.getDefaultInstance()?.create(endpointClass)
    }
}