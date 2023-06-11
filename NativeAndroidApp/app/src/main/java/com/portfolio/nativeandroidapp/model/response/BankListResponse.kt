package com.portfolio.nativeandroidapp.model.response

import android.os.Parcelable
import com.google.gson.annotations.SerializedName
import kotlinx.parcelize.Parcelize

@Parcelize
class BankListResponse :
    ArrayList<BankListResponse.BankListResponseItem>(), Parcelable {
        @Parcelize
        data class BankListResponseItem(
            @SerializedName("code")
            val code: String?,
            @SerializedName("nameEn")
            val nameEn: String?,
            @SerializedName("nameZh")
            val nameZh: String?,
            @SerializedName("freqUsed")
            val freqUsed: String?
        ) : Parcelable
}