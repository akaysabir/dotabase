//
//  TableViewIndicatorView.swift
//  sosedi
//
//  Created by Ali Zhussupov on 2/19/21.
//  Copyright © 2021 Ali Zhussupov. All rights reserved.
//

import UIKit
import SnapKit

final class TableViewIndicatorView: UIView {
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .white
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        indicatorView.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
