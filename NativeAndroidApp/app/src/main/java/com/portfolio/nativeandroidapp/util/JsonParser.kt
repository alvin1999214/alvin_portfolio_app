package com.portfolio.nativeandroidapp.util

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import java.lang.reflect.ParameterizedType
import java.lang.reflect.Type

object JsonParser {
    private var parser: Gson? = null

    @get:Synchronized
    val instance: Gson?
        get() {
            if (parser == null) {
                parser = GsonBuilder().create()
            }
            return parser
        }

    fun getParametrizedType(
        mainClass: Class<*>,
        parameterClass: Class<*>
    ): Type {
        return object : ParameterizedType {
            override fun getActualTypeArguments(): Array<Type> {
                return arrayOf(parameterClass)
            }

            override fun getRawType(): Type {
                return mainClass
            }

            override fun getOwnerType(): Type? {
                return null
            }
        }
    }

    @JvmName("getInstance1")
    @Synchronized
    fun getInstance(): Gson? {
        if (parser == null) {
            parser = GsonBuilder().create()
        }
        return parser
    }
}