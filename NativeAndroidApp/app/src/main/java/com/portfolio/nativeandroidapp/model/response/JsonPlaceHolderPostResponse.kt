package com.portfolio.nativeandroidapp.model.response


import com.google.gson.annotations.SerializedName
import kotlinx.parcelize.Parcelize
import android.os.Parcelable

class JsonPlaceHolderPostResponse : ArrayList<JsonPlaceHolderPostResponse.JsonPlaceHolderPostResponseItem>(){
    
    @Parcelize
    data class JsonPlaceHolderPostResponseItem(
        @SerializedName("userId")
        val userId: Int?,
        @SerializedName("id")
        val id: Int?,
        @SerializedName("title")
        val title: String?,
        @SerializedName("body")
        val body: String?
    ) : Parcelable
}