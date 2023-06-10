package com.portfolio.nativeandroidapp.model.response


import com.google.gson.annotations.SerializedName
import kotlinx.parcelize.Parcelize
import android.os.Parcelable


@Parcelize
data class DisneyCharacterResponse(
    @SerializedName("info")
    val info: Info?,
    @SerializedName("data")
    val `data`: List<Data?>?
) : Parcelable {

    @Parcelize
    data class Info(
        @SerializedName("count")
        val count: Int?,
        @SerializedName("totalPages")
        val totalPages: Int?,
        @SerializedName("previousPage")
        val previousPage: String?,
        @SerializedName("nextPage")
        val nextPage: String?
    ) : Parcelable


    @Parcelize
    data class Data(
        @SerializedName("_id")
        val id: Int?,
        @SerializedName("films")
        val films: List<String?>?,
        @SerializedName("shortFilms")
        val shortFilms: List<String?>?,
        @SerializedName("tvShows")
        val tvShows: List<String?>?,
        @SerializedName("videoGames")
        val videoGames: List<String?>?,
        @SerializedName("parkAttractions")
        val parkAttractions: List<String?>?,
        @SerializedName("allies")
        val allies: List<String?>?,
        @SerializedName("enemies")
        val enemies: List<String?>?,
        @SerializedName("sourceUrl")
        val sourceUrl: String?,
        @SerializedName("name")
        val name: String?,
        @SerializedName("imageUrl")
        val imageUrl: String?,
        @SerializedName("createdAt")
        val createdAt: String?,
        @SerializedName("updatedAt")
        val updatedAt: String?,
        @SerializedName("url")
        val url: String?,
        @SerializedName("__v")
        val v: Int?
    ) : Parcelable
}