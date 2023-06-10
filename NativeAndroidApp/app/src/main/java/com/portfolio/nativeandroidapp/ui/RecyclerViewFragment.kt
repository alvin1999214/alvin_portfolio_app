package com.portfolio.nativeandroidapp.ui

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import com.portfolio.nativeandroidapp.R
import com.portfolio.nativeandroidapp.databinding.FragmentRecyclerViewBinding

class RecyclerViewFragment : Fragment() {
    private lateinit var mBinding: FragmentRecyclerViewBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        mBinding = DataBindingUtil.inflate(inflater, R.layout.fragment_recycler_view, container, false)
        return mBinding.root
    }

    companion object {
        @JvmStatic
        fun newInstance(bundle: Bundle?): Fragment {
            val fragment: Fragment = RecyclerViewFragment()
            if (bundle != null)
                fragment.arguments = bundle
            return fragment
        }
    }
}