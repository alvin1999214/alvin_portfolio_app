package com.portfolio.nativeandroidapp.ui.dialog

import android.app.Dialog
import android.content.DialogInterface
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import com.portfolio.nativeandroidapp.R
import com.portfolio.nativeandroidapp.databinding.FragmentNetworkErrorDialogBinding
import com.portfolio.nativeandroidapp.util.DialogUtil

class NetworkErrorDialog : DialogFragment() {
    private lateinit var mBinding: FragmentNetworkErrorDialogBinding
    private var mConfig: Config? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        return super.onCreateDialog(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        mBinding = DataBindingUtil.inflate(
            inflater,
            R.layout.fragment_network_error_dialog,
            container,
            false
        )
        isCancelable = false
        return mBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        mBinding.ivNetworkErrorDismissBtn.setOnClickListener {
            requireDialog().dismiss()
            mConfig?.dismissButtonListener?.onClick(requireDialog(), BUTTON_DISMISS)
        }
    }

    fun setConfig(config: Config) {
        mConfig = config
    }

    class Config {
        var dismissButtonListener: DialogInterface.OnClickListener? = null
    }

    class Builder {
        private var mConfig: Config = Config()
        fun setDismissButtonAction (dismissButtonListener: DialogInterface.OnClickListener) = apply {
            mConfig.dismissButtonListener = dismissButtonListener
        }

        fun create(): NetworkErrorDialog {
            val dialog = NetworkErrorDialog()
            dialog.setConfig(mConfig)
            return dialog
        }

        fun show(fragmentManager: FragmentManager?): NetworkErrorDialog {
            val dialog = create()
            if (fragmentManager != null) {
                DialogUtil.show(dialog, fragmentManager)
            }
            return dialog
        }
    }

    companion object {
        const val BUTTON_DISMISS = 0
        @JvmStatic
        fun builder(): Builder {
            return Builder()
        }
    }
}