package com.portfolio.nativeandroidapp

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.provider.Settings
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import com.portfolio.nativeandroidapp.activity.MainAppActivity
import com.portfolio.nativeandroidapp.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity(), View.OnClickListener {
    private lateinit var _binding : ActivityMainBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        _binding = DataBindingUtil.setContentView(this, R.layout.activity_main)
        setContentView(_binding.root)
        val content: View = _binding.root
        content.systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_STABLE or
                View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or
                View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
        _binding.btnQrScan.setOnClickListener(this)
        _binding.btnMain.setOnClickListener(this)
        _binding.btnReset.setOnClickListener(this)
        _binding.btnSetting.setOnClickListener(this)
    }

    override fun onClick(v: View) {
        when (v.id) {
            R.id.btn_main -> startMainApp()
            R.id.btn_reset -> resetSharePreference()
            R.id.btn_setting -> launchSetting()
        }
    }

    private fun startMainApp() {
        val intent = Intent(this, MainAppActivity::class.java)
        startActivity(intent)
    }

    private fun resetSharePreference() {
        val mSharedPreferences = this.getSharedPreferences(
            this.packageName, Context.MODE_PRIVATE
        )
        mSharedPreferences.edit().remove("").apply()
        Toast.makeText(this, "Reset ! ", Toast.LENGTH_SHORT).show()
    }

    private fun launchSetting() {
        val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
        val uri =
            Uri.fromParts("package", this.packageName, null)
        intent.data = uri
        startActivity(intent)
    }
}