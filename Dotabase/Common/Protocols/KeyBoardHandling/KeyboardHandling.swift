//
//  KeyboardHandling.swift
//  Dotabase
//
//  Created by zhussupov on 28.05.2021.
//

import UIKit

protocol KeyboardHandling {
    func keyboardWillShow(with keyboardSize: CGSize)
    func keyboardWillHide(with keyboardSize: CGSize)
    func addObserverForKeyboardNotification(with scrollView: UIScrollView?)
    func registerForKeyboardWillShowNotification(with scrollView: UIScrollView?)
    func registerForKeyboardWillHideNotification(with scrollView: UIScrollView?)
}

extension KeyboardHandling where Self: UIViewController {
    
    func keyboardWillShow(with keyboardSize: CGSize) {
        
    }
    
    func keyboardWillHide(with keyboardSize: CGSize) {
        
    }
    
    func addObserverForKeyboardNotification(with scrollView: UIScrollView? = nil) {
        registerForKeyboardWillShowNotification(with: scrollView)
        registerForKeyboardWillHideNotification(with: scrollView)
    }
    
    func registerForKeyboardWillShowNotification(with scrollView: UIScrollView?) {
        let block: (Notification) -> Void = { [weak self] notification -> Void in
            let userInfo = notification.userInfo
            let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
            if let scrollView = scrollView {
                let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top,
                                                 left: scrollView.contentInset.left,
                                                 bottom: keyboardSize.height,
                                                 right: scrollView.contentInset.right)
                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets
            }
            self?.keyboardWillShow(with: keyboardSize)
        }
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                                   object: nil,
                                                   queue: nil,
                                                   using: block)
    }

    func registerForKeyboardWillHideNotification(with scrollView: UIScrollView?) {
        let block: (Notification) -> Void = { [weak self] notification -> Void in
            let userInfo = notification.userInfo
            let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
            if let scrollView = scrollView {
                let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top,
                                                 left: scrollView.contentInset.left,
                                                 bottom: 0,
                                                 right: scrollView.contentInset.right)

                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets
            }
            self?.keyboardWillHide(with: keyboardSize)
        }
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                                   object: nil,
                                                   queue: nil,
                                                   using: block)
    }
}

