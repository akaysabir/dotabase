//
//  BaseViewController.swift
//  Dotabase
//
//  Created by zhussupov on 28.05.2021.
//  
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup
    
    private func setupView() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        
    }
    
    private func configureConstraints() {
        
    }
    
    // MARK: - Public actions
    
    // MARK: - Private actions
    
}
