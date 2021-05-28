//
//  CustomCollectionViewCell.swift
//  Dotabase
//
//  Created by zhussupov on 27.05.2021.
//

import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9333333333, green: 0.9215686275, blue: 0.8666666667, alpha: 1)
        label.font = UIFont(name: "Trajan Pro", size: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var myImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [myLabel, myImage].forEach {
            addSubview($0)
        }
        
        myImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
        
        myLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(myImage.snp.bottom)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
