//
//  IndicatableView+UITableView.swift
//  sosedi
//
//  Created by Ali Zhussupov on 2/19/21.
//  Copyright © 2021 Ali Zhussupov. All rights reserved.
//

import UIKit
import SnapKit

extension IndicatableView where Self: UITableView {
    
    var isLoading: Bool {
        return _activityView != nil
    }
    
    private var _activityView: UIView? {
        for case let activityView as TableViewIndicatorView in subviews {
            return activityView
        }
        return nil
    }
    
    func showActivityIndicator() {
        guard _activityView == nil else {
            return
        }
        let activityView = TableViewIndicatorView()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityView)
        activityView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalToSuperview()
        }
    }
    
    func hideActivityIndicator() {
        guard let activityView = _activityView  else {
          return
        }
        activityView.removeFromSuperview()
    }
}

extension UITableView: IndicatableView {}
