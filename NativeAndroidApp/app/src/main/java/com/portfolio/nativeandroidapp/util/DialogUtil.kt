package com.portfolio.nativeandroidapp.util

import android.app.Dialog
import android.content.Context
import android.view.Gravity
import android.view.View
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import com.portfolio.nativeandroidapp.ui.dialog.CommonLoadingDialog

class DialogUtil {
    companion object {
        private val loadingDialog: CommonLoadingDialog = CommonLoadingDialog()

        fun show(
            dialog: DialogFragment?,
            fm: FragmentManager
        ) {
            if (dialog != null) {
                if (dialog.isAdded) {
                    dismiss(dialog)
                }
                try {
                    fm.beginTransaction().remove(dialog).commit()
                    dialog.show(fm, null)
                } catch (e: Exception) {
//                Logger.d(e.toString())
//                Logger.e(e.toString())
                }
            }
        }

        fun showLoadingDialog(
            fm: FragmentManager
        ) {
            if (loadingDialog.isAdded) {
                return
            }
            try {
                fm.beginTransaction().remove(loadingDialog).commit()
                loadingDialog.show(fm, null)
            } catch (e: Exception) {
//                Logger.d(e.toString())
//                Logger.e(e.toString())
            }
        }

        fun show(dialog: android.app.DialogFragment?, fm: android.app.FragmentManager) {
            if (dialog != null) {
                if (dialog.isAdded) {
                    dismiss(dialog)
                }
                try {
                    fm.beginTransaction().remove(dialog).commit()
                    dialog.show(fm, null)
                } catch (e: Exception) {
//                Logger.d(e.toString())
//                Logger.e(e.toString())
                }
            }
        }

        fun dismiss(dialog: Dialog?) {
            if (dialog != null && dialog.isShowing) {
                dialog.show()
            }
        }

        fun dismissLoadingDialog() {
            if (loadingDialog.fragmentManager != null) {
                loadingDialog.dismissAllowingStateLoss()
            }
        }

        fun dismiss(dialog: DialogFragment?) {
            if (dialog != null && dialog.fragmentManager != null) {
                dialog.dismissAllowingStateLoss()
            }
        }

        fun dismiss(dialog: android.app.DialogFragment?) {
            if (dialog != null && dialog.fragmentManager != null) {
                dialog.dismissAllowingStateLoss()
            }
        }

        fun isVisible(dialog: DialogFragment?): Boolean {
            return dialog != null && dialog.isVisible
        }

    }

}