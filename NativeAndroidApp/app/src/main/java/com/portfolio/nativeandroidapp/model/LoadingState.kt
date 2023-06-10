package com.portfolio.nativeandroidapp.model

class LoadingState {
    var tag: String? = null
    var isLoading: Boolean

    constructor(loading: Boolean) {
        isLoading = loading
    }

    constructor(tag: String?, loading: Boolean) {
        this.tag = tag
        isLoading = loading
    }

    override fun toString(): String {
        return "LoadingState{" +
                "tag='" + tag + '\'' +
                ", loading=" + isLoading +
                '}'
    }
}