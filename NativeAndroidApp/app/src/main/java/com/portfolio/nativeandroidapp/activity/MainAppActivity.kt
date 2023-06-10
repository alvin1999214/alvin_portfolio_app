package com.portfolio.nativeandroidapp.activity

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.portfolio.nativeandroidapp.R
import com.portfolio.nativeandroidapp.ui.RecyclerViewFragment

class MainAppActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main_app)

        startFragment(RecyclerViewFragment.newInstance(null),"",true,true)
    }

    fun startFragment(
        fragment: Fragment, tag: String?,
        isAnimation: Boolean, addToBackStack: Boolean
    ) {
        val fm = supportFragmentManager.beginTransaction()

        if (isAnimation) {
            fm.setCustomAnimations(
                R.anim.slide_in_right,
                R.anim.slide_out_left, R.anim.slide_in_left,
                R.anim.slide_out_right
            )
        }
        if (fragment.isAdded) {
            fm.show(fragment)
        } else {
            fm.replace(R.id.fragment_container, fragment, tag)
            if (addToBackStack) {
                fm.addToBackStack(tag)
            }
            // Commit the transaction
        }
        fm.commit()
    }
}