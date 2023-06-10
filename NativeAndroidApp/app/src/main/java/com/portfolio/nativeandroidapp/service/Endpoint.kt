package com.portfolio.nativeandroidapp.service

import com.portfolio.nativeandroidapp.model.response.DisneyCharacterResponse
import io.reactivex.Observable
import okhttp3.ResponseBody
import retrofit2.Response
import retrofit2.http.*

interface Endpoint {

    @GET
    fun getV2(
        @Url url: String?
    ): Observable<Response<ResponseBody?>?>?

    @GET(Constants.DISNEY_CHARACTER)
    fun getDisneyCharacter(): Observable<DisneyCharacterResponse?>?
}