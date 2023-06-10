package com.portfolio.nativeandroidapp.ui.dialog;

import android.app.Dialog;
import android.content.res.Configuration;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;

import androidx.annotation.CallSuper;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.databinding.DataBindingUtil;
import androidx.fragment.app.DialogFragment;

import com.portfolio.nativeandroidapp.R;
import com.portfolio.nativeandroidapp.databinding.FragmentBaseDialogBinding;
import com.portfolio.nativeandroidapp.util.DimensionUtil;

public abstract class BaseDialogFragment extends DialogFragment {

    public BaseDialogFragment(){

    }

    private FragmentBaseDialogBinding mBinding;

    protected abstract View onCreateContentView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState);

    @NonNull
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        Dialog dialog = super.onCreateDialog(savedInstanceState);
        if (dialog.getWindow() != null) {
            dialog.getWindow().requestFeature(Window.FEATURE_NO_TITLE);
        }
        dialog.setCanceledOnTouchOutside(false);
        dialog.setCancelable(false);

        return dialog;
    }

    @CallSuper
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        mBinding = DataBindingUtil.inflate(inflater, R.layout.fragment_base_dialog, container, false);

        DisplayMetrics dm = getResources().getDisplayMetrics();
        int marginX = getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE
                ? (int) ((dm.widthPixels - dm.widthPixels * getMaxWidthPercentageOnLandscapeMode()) / 2f)
                : (int) DimensionUtil.dpToPx(requireContext(), 16);
        int marginY = (int) ((dm.heightPixels - dm.heightPixels * getMaxHeightPercentageOnPortraitMode()) / 2f) ;
        mBinding.layoutRoot.setPadding(marginX, marginY, marginX, marginY);

        mBinding.layoutContainer.addView(onCreateContentView(inflater, mBinding.layoutContainer, savedInstanceState));

        return mBinding.layoutRoot;
    }

    @Override
    public void onStart() {
        super.onStart();
        setCancelable(false);
        if (getDialog() != null && getDialog().getWindow() != null) {
            Window window = getDialog().getWindow();
            window.setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
            window.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        }
    }

    protected float getMaxHeightPercentageOnPortraitMode() {
        return 4f / 5f;
    }

    protected float getMaxWidthPercentageOnLandscapeMode() {
        return 3f / 5f;
    }

    protected FragmentBaseDialogBinding getBinding() {
        return mBinding;
    }
}
