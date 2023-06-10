package com.portfolio.nativeandroidapp.ui.dialog

import android.app.Dialog
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import com.portfolio.nativeandroidapp.R
import com.portfolio.nativeandroidapp.databinding.FragmentCommonLoadingDialogBinding

class CommonLoadingDialog : DialogFragment() {

    lateinit var binding: FragmentCommonLoadingDialogBinding

    var dialogMessage = ""

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        val dialog = super.onCreateDialog(savedInstanceState)
        isCancelable = false
        return dialog
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_common_loading_dialog, container, false);
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
//        message = resources.getString(R.string.ul_loading_processing)
        binding.tvLoadingMessage.text = dialogMessage
        if (dialog != null && dialog!!.window != null) {
            val window = dialog!!.window
            window!!.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
            window.setLayout(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
        }
    }

    override fun show(manager: FragmentManager, tag: String?) {
        val trans = manager.beginTransaction()
        trans.add(this, tag)
        trans.commitAllowingStateLoss()
    }

    companion object {
        val TAG = CommonLoadingDialog::class.java
    }

    fun setMessage(message: String) {
        dialogMessage = message
    }
}