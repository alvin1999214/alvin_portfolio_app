package com.portfolio.nativeandroidapp.util;

import android.content.Context;

public class DimensionUtil {
    public static float dpToPx(Context context, float dp) {
        return dp * context.getResources().getDisplayMetrics().density;
    }

    public static float pxToDp(Context context, float px) {
        return px / context.getResources().getDisplayMetrics().density;
    }
}
