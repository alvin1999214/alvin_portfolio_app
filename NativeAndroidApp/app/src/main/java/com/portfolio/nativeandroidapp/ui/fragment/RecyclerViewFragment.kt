package com.portfolio.nativeandroidapp.ui.fragment

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.ViewModelProvider
import com.portfolio.nativeandroidapp.R
import com.portfolio.nativeandroidapp.databinding.FragmentRecyclerViewBinding
import com.portfolio.nativeandroidapp.model.response.BankListResponse
import com.portfolio.nativeandroidapp.model.response.DisneyCharacterResponse
import com.portfolio.nativeandroidapp.util.DialogUtil
import com.portfolio.nativeandroidapp.viewmodel.MainViewModel

class RecyclerViewFragment : Fragment() {
    private lateinit var mBinding: FragmentRecyclerViewBinding
    private var cacheView: View? = null
    private var mMainViewModel: MainViewModel? = null
    private var isInitialized = false
    private var mDisneyCharacterResponse: DisneyCharacterResponse? = null
    private var mBankListResponse: BankListResponse? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mMainViewModel = ViewModelProvider(requireActivity())[MainViewModel::class.java]
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        if (cacheView == null) {
            mBinding = DataBindingUtil.inflate(inflater, R.layout.fragment_recycler_view, container, false)
            cacheView = mBinding.root
        }
        return cacheView
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        observeLoading()
        observeDisneyCharacterList()
        observeBankList()
        initView()
    }

    private fun initView() {
        mBinding.btnClick.setOnClickListener {
//            mMainViewModel?.disneyCharacterGetService(requireContext())
            mMainViewModel?.getBankList(requireContext())
        }
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

    private fun observeDisneyCharacterList() {
        mMainViewModel?.disneyCharacterGetResponse?.observe(viewLifecycleOwner) { response ->
            if (view != null && viewLifecycleOwner.lifecycle.currentState == Lifecycle.State.RESUMED) {
                mDisneyCharacterResponse = response
            }
        }
    }

    private fun observeBankList() {
        mMainViewModel?.bankListResponse?.observe(viewLifecycleOwner) { response ->
            if (view != null && viewLifecycleOwner.lifecycle.currentState == Lifecycle.State.RESUMED) {
                mBankListResponse = response
            }
        }
    }

    private fun observeLoading() {
        mMainViewModel?.loadingState?.observe(viewLifecycleOwner) {
            if (it.isLoading) {
                DialogUtil.showLoadingDialog(parentFragmentManager)
            } else {
                DialogUtil.dismissLoadingDialog()
            }
        }
    }
}