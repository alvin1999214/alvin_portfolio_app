package com.portfolio.nativeandroidapp.util

import android.content.res.Resources
import java.io.ByteArrayOutputStream
import java.io.IOException

class ResourcesUtil {
    companion object {
        fun readStringForRawFile(
            resources: Resources,
            id: Int
        ): String? {
            val inputStream = resources.openRawResource(id)
            val outputStream = ByteArrayOutputStream()
            val buf = ByteArray(1024)
            var len: Int
            try {
                while (inputStream.read(buf).also { len = it } != -1) {
                    outputStream.write(buf, 0, len)
                }
                outputStream.close()
                inputStream.close()
            } catch (e: IOException) {

            } finally {
                try {
                    outputStream.close()
                    inputStream.close()
                } catch (e: Exception) {

                }
            }
            return outputStream.toString()
        }
    }
}