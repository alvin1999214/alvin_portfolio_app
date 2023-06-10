package com.portfolio.nativeandroidapp

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.provider.Settings
import android.view.View
import android.widget.Toast
import androidx.databinding.DataBindingUtil
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
//            R.id.btn_scan_and_pay -> launchBillPaymentMfe(BillPaymentMfeLaunchAction.SCAN_AND_PAY)
//            R.id.btn_p2p_dashboard -> launchBillPaymentMfe(BillPaymentMfeLaunchAction.P2P_PAYMENT)
//            R.id.btn_manage_limit -> launchBillPaymentMfe(BillPaymentMfeLaunchAction.MANAGE_LIMIT)
//            R.id.btn_security_option_setting -> launchBillPaymentMfe(BillPaymentMfeLaunchAction.SECURITY_OPTION_SETTING)
//            R.id.btn_reset -> resetSharePreference()
//            R.id.btn_setting -> launchSetting()
        }
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