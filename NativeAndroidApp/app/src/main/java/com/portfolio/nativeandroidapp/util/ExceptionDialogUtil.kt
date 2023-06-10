package com.portfolio.nativeandroidapp.util

import android.content.Context
import android.content.DialogInterface
import androidx.fragment.app.FragmentManager
import com.portfolio.nativeandroidapp.R
import com.portfolio.nativeandroidapp.ui.dialog.GeneralDialog
import com.portfolio.nativeandroidapp.ui.dialog.NetworkErrorDialog

class ExceptionDialogUtil  {
    enum class ExceptionType(val value: String) {
        NETWORK_ERROR("network_error"),
        SOCKET_TIMEOUT("socket_timeout"),
        HTTP_EXCEPTION_UNKNOWN("http_exception_unknown"),
        OTHER_EXCEPTION("other_exception"),
    }

    companion object {
        var isDialogShowing = false
        fun showNetworkErrorDialog(
            fragmentManager: FragmentManager,
            dismissButtonAction:  DialogInterface.OnClickListener
        ) {
            NetworkErrorDialog.builder()
                .setDismissButtonAction(dismissButtonAction)
                .show(fragmentManager)
        }

        fun showOthersErrorDialog(
            context: Context,
            fragmentManager: FragmentManager,
            errorCode: String?,
            dismissButtonAction:  DialogInterface.OnClickListener
        ) {
            if (!isDialogShowing) {
                isDialogShowing = true
//                GeneralDialog.builder()
//                    .setButtonOrientation(GeneralDialog.VERTICAL)
//                    .setDrawable(R.drawable.ic_error_dialog_icon)
//                    .setTitle(context.getString(R.string.http_error_dialog_title))
//                    .setMessage(context.getString(R.string.http_error_dialog_message, errorCode?:""))
//                    .setPositiveButton(context.getString(R.string.dialog_got_it)) { dialog, which  ->
//                        dismissButtonAction.onClick(dialog, which)
//                        isDialogShowing = false
//                    }
//                    .show(fragmentManager)
            }
        }
    }
}