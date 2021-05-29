//
//  HidableTextField.swift
//  Dotabase
//
//  Created by zhussupov on 28.05.2021.
//

import UIKit

class HideableTextField: UITextField {
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAccessoryInput()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private actions
    
    private func setupAccessoryInput() {
        let toolbar = UIToolbar(frame: CGRect.init(x: 0.0, y: 0.0, width: self.frame.width, height: 44.0))
        let dismissButton = UIBarButtonItem(title: "Done",
                                            style: .plain,
                                            target: self,
                                            action: #selector(hideKeyboard))
                
        dismissButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.green],
                                             for: .normal)
        dismissButton.tintColor = UIColor.green
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.items = [flexSpace, dismissButton]
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        toolbar.addGestureRecognizer(tapGestureRecognizer)
        
        self.inputAccessoryView = toolbar
    }
    
    @objc private func hideKeyboard() {
        self.resignFirstResponder()
    }
    
}
