package com.portfolio.nativeandroidapp.model

import android.os.Bundle
import java.io.Serializable

class AppEvent : Serializable {
    var name: String
        private set
    var data: Bundle? = null
        private set

    constructor(name: String) {
        this.name = name
    }

    constructor(name: String, data: Bundle?) {
        this.name = name
        this.data = data
    }

}