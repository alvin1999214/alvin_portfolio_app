package com.portfolio.nativeandroidapp.util

import com.portfolio.nativeandroidapp.model.response.ErrorResponseBody
import io.reactivex.functions.Consumer
import retrofit2.HttpException
import java.nio.charset.StandardCharsets
import kotlin.jvm.Throws

class HttpExceptionConsumer<T : Throwable?> :
    Consumer<T> {
    @Throws(Exception::class)
    override fun accept(t: T) {
//        val crashlytics: FirebaseCrashlytics = FirebaseCrashlytics.getInstance()
        if (t is HttpException) {
            val response = (t as HttpException).response()
            try {
                if (response != null && response.code() == 400) {
                    if (response.errorBody() != null) {
                        val errorBody = response.errorBody()!!.string()
                        if (!errorBody.isEmpty()) {
                            //handle error
                        }
                    } else {
//                        crashlytics.recordException(t)
                    }
                } else {
                    if (response != null && response.errorBody() != null) {
                        val bs = response.errorBody()!!.source()
                        val buffer = bs.buffer.clone()
                        val errorBody: ErrorResponseBody? =
                            getErrorResponse(buffer.readString(StandardCharsets.UTF_8))
                        val apiPath = response.raw().request.url.toUrl().path
                        val httpsCode = response.code()
                        val messageId =
                            if (errorBody != null) errorBody.messageId else ""
                        val messageSuffix =
                            if (errorBody != null) errorBody.messageSuffix else ""
//                        crashlytics.setCustomKey("API", apiPath)
//                        crashlytics.setCustomKey("Http Code", httpsCode)
//                        crashlytics.setCustomKey("Message ID", messageId)
//                        crashlytics.setCustomKey("Message Suffix", messageSuffix)
//                        crashlytics.recordException(ApiException(apiPath, t))
                    } else {
//                        crashlytics.recordException(t)
                    }
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
            if (response != null && response.errorBody() != null) {
                val bs = response.errorBody()!!.source()
                val buffer = bs.buffer.clone()
                val errorBody: ErrorResponseBody? =
                    getErrorResponse(buffer.readString(StandardCharsets.UTF_8))
                val apiPath = response.raw().request.url.toUrl().path
                val httpsCode = response.code()
                val messageId =
                    if (errorBody != null) errorBody.messageId else ""
                val messageSuffix =
                    if (errorBody != null) errorBody.messageSuffix else ""
//                crashlytics.setCustomKey("API", apiPath)
//                crashlytics.setCustomKey("Http Code", httpsCode)
//                crashlytics.setCustomKey("Message ID", messageId)
//                crashlytics.setCustomKey("Message Suffix", messageSuffix)
//                crashlytics.recordException(ApiException(apiPath, t))
            }
        } else {
//            crashlytics.recordException(t)
        }
    }

    private fun getErrorResponse(errorBodyString: String): ErrorResponseBody? {
        return JsonParser.instance?.fromJson(errorBodyString, ErrorResponseBody::class.java)
    }

    companion object {
        val TAG = HttpExceptionConsumer::class.java.simpleName
    }
}