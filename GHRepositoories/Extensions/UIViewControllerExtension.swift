//
//  UIViewControllerExtension.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 22/09/2021.
//

import UIKit

fileprivate var activityIndicatorView: CustomActivityIndicatorView!

extension UIViewController {
    
    func showLoadingView() {
        activityIndicatorView = CustomActivityIndicatorView(frame: self.view.bounds)
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.alpha = 0.0
        UIView.animate(withDuration: 1) {
            activityIndicatorView.alpha = 0.8
        }
        activityIndicatorView.activityIndicator.startAnimating()
    }
    
    func removeActivityIndicatorView() {
        activityIndicatorView.removeFromSuperview()
        activityIndicatorView.activityIndicator.stopAnimating()
    }
}
