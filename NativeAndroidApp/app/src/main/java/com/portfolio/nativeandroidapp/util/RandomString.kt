package com.portfolio.nativeandroidapp.util

import java.security.SecureRandom

class RandomString {
    private val mRandom: SecureRandom
    private val mSymbols: CharArray
    private val mBuffer: CharArray

    constructor(length: Int) {
        require(length >= 1)
        mRandom = SecureRandom()
        mSymbols = ALPHANUMERIC.toCharArray()
        mBuffer = CharArray(length)
    }

    constructor(length: Int, symbols: String) {
        require(!(length < 1 || symbols.length < 2))
        mRandom = SecureRandom()
        mSymbols = symbols.toCharArray()
        mBuffer = CharArray(length)
    }

    fun nextString(): String {
        for (i in mBuffer.indices) {
            mBuffer[i] = mSymbols[mRandom.nextInt(mSymbols.size)]
        }
        return String(mBuffer)
    }

    companion object {
        const val ALPHABETS_UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        val ALPHABETS_LOWER = ALPHABETS_UPPER.toLowerCase()
        const val DIGITS = "0123456789"
        val ALPHANUMERIC =
            ALPHABETS_UPPER + ALPHABETS_LOWER + DIGITS
    }
}