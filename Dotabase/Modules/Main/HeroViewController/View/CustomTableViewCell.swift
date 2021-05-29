//
//  CustomTableViewCell.swift
//  Dotabase
//
//  Created by zhussupov on 25.05.2021.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9333333333, green: 0.9215686275, blue: 0.8666666667, alpha: 1)
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [myLabel, myImage].forEach {
            addSubview($0)
        }
        
        myImage.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(myImage.snp.height)
            $0.width.equalTo(70)
        }
        
        myLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(myImage.snp.trailing).inset(-20)
        }

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
