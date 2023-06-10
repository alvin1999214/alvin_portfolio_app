package com.portfolio.nativeandroidapp.ui.dialog

import android.content.DialogInterface
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import androidx.annotation.DrawableRes
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import com.portfolio.nativeandroidapp.R
import com.portfolio.nativeandroidapp.util.DialogUtil

class GeneralDialog : BaseDialogFragment() {

    private var mConfig: Config? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        setStyle(STYLE_NO_TITLE, R.style.Transparent)
    }

    override fun onCreateContentView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val layoutResId = R.layout.fragment_general_dialog
        val view = inflater.inflate(layoutResId, container, false)
        val iconImageView = view.findViewById<ImageView>(R.id.imageView_icon)
        val titleTextView = view.findViewById<TextView>(R.id.textView_title)
        val messageTextView = view.findViewById<TextView>(R.id.textView_message)
        val buttonContainer = view.findViewById<ViewGroup>(R.id.layout_button_container)
        val positiveButton = view.findViewById<Button>(R.id.btn_positive)
        val negativeButton = view.findViewById<Button>(R.id.btn_negative)
        val closeButton = view.findViewById<ImageView>(R.id.imageView_closeButton)


        mConfig?.run {
            when {
                drawableId != 0 -> {
                    iconImageView.visibility = View.VISIBLE
                    drawableId?.let { iconImageView.setImageResource(it)}
                }
                else -> { iconImageView.visibility = View.GONE }
            }
            when {
                titleId != null ->  titleTextView.setText(titleId!!)
                title != null ->  titleTextView.text = title
                else -> { titleTextView.visibility = View.GONE }
            }
            when {
                messageId != null ->  messageTextView.setText(messageId!!)
                message != null -> messageTextView.text = message
                else -> { messageTextView.visibility = View.GONE }
            }
            when {
                positiveButtonTextId != null -> { positiveButton.setText(positiveButtonTextId!!) }
                positiveButtonText != null -> { positiveButton.text = positiveButtonText }
                else -> { positiveButton.visibility = View.GONE }
            }
            positiveButtonListener?.let { listener ->
                positiveButton.setOnClickListener { listener.onClick(dialog, BUTTON_POSITIVE) }
            }
            when {
                negativeButtonTextId != null -> { negativeButton.setText(negativeButtonTextId!!) }
                negativeButtonText != null -> { negativeButton.text = negativeButtonText }
                else -> { negativeButton.visibility = View.GONE }
            }
            negativeButtonListener?.let { listener ->
                negativeButton.setOnClickListener { listener.onClick(dialog, BUTTON_NEGATIVE) }
            }
            if (positiveButton.visibility != View.VISIBLE && negativeButton.visibility != View.VISIBLE) {
                buttonContainer.visibility = View.GONE
            }
            closeButtonListener?.let { listener ->
                closeButton.visibility = View.VISIBLE
                closeButton.setOnClickListener { listener.onClick(dialog, BUTTON_NEGATIVE) }
            } ?:run {
                closeButton.visibility = View.GONE
            }
        }
        return view
    }

    fun setConfig(config: Config) {
        mConfig = config
    }

    class Config {
        var buttonOrientation = 0
        var drawableId = 0
        var titleId: Int? = null
        var title: CharSequence? = null
        var messageId: Int? = null
        var message: CharSequence? = null
        var positiveButtonTextId: Int? = null
        var positiveButtonText: CharSequence? = null
        var positiveButtonListener: DialogInterface.OnClickListener? = null
        var negativeButtonTextId: Int? = null
        var negativeButtonText: CharSequence? = null
        var negativeButtonListener: DialogInterface.OnClickListener? = null
        var closeButtonListener: DialogInterface.OnClickListener? = null
    }

    class Builder {
        private var mConfig: Config = Config()

        fun setButtonOrientation(orientation: Int) = apply { mConfig.buttonOrientation = orientation }

        fun setDrawable(@DrawableRes id: Int) = apply { mConfig.drawableId = id }

        fun setTitle(titleId: Int?) = apply { mConfig.titleId = titleId }
        fun setTitle(title: CharSequence?) = apply { mConfig.title = title }

        fun setMessage(messageId: Int?) = apply { mConfig.messageId = messageId }
        fun setMessage(message: CharSequence?) = apply { mConfig.message = message }

        fun setPositiveButton(textId: Int?, listener: DialogInterface.OnClickListener) = apply {
            mConfig.positiveButtonTextId = textId
            mConfig.positiveButtonListener = listener
        }
        fun setPositiveButton(text: CharSequence?, listener: DialogInterface.OnClickListener) = apply {
            mConfig.positiveButtonText = text
            mConfig.positiveButtonListener = listener
        }

        fun setNegativeButton(textId: Int?, listener: DialogInterface.OnClickListener) = apply {
            mConfig.negativeButtonTextId = textId
            mConfig.negativeButtonListener = listener
        }
        fun setNegativeButton(text: CharSequence?, listener: DialogInterface.OnClickListener) = apply {
            mConfig.negativeButtonText = text
            mConfig.negativeButtonListener = listener
        }

        fun setCloseButton(listener: DialogInterface.OnClickListener) = apply { mConfig.closeButtonListener = listener }

        fun create(): GeneralDialog {
            val dialog = GeneralDialog()
            dialog.setConfig(mConfig)
            return dialog
        }

        fun show(fragmentManager: FragmentManager?): GeneralDialog {
            val dialog = create()
            if (fragmentManager != null) {
                DialogUtil.show(dialog, fragmentManager)
            }
            return dialog
        }

    }

    companion object {
        const val VERTICAL = 0
        const val HORIZONTAL = 1
        const val BUTTON_POSITIVE = 0
        const val BUTTON_NEGATIVE = 1
        @JvmStatic
        fun builder(): Builder {
            return Builder()
        }
    }
}