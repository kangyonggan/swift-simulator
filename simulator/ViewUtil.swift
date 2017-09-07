//
//  ViewUtil.swift
//  simulator
//
//  Created by kangyonggan on 9/6/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//


import UIKit

class ViewUtil: NSObject {
   
    // 加载中图标
    static func loadingView(_ fromParentView: UIView) -> UIActivityIndicatorView {
        let loadingView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        loadingView.color = AppConstants.MASTER_COLOR
        loadingView.center = fromParentView.center;
        loadingView.hidesWhenStopped = true;
        
        fromParentView.addSubview(loadingView)
        loadingView.startAnimating();
        
        return loadingView;
    }
    
    // 判断是否正在加载
    static func isLoading(_ loadingView: UIActivityIndicatorView?) -> Bool {
        return loadingView != nil && loadingView!.isAnimating;
    }
    
    // 停止加载中动画
    static func stopLoading(_ loadingView: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            loadingView.stopAnimating();
            loadingView.removeFromSuperview();
        }
    }
}
