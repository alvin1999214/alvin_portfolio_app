package com.portfolio.nativeandroidapp.model.response

class ErrorResponseBody {
    var messageId: String? = null
    var messageSuffix: String? = null

    override fun toString(): String {
        return "ErrorResponseBody{" +
                "messageId='" + messageId + '\'' +
                ", messageSuffix='" + messageSuffix + '\'' +
                '}'
    }
}