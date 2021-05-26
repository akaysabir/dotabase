//
//  CustomTableViewCell.swift
//  Dotabase
//
//  Created by zhussupov on 25.05.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var myImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = . blue
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [myLabel, myImage].forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            myImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            myImage.widthAnchor.constraint(equalToConstant: 100),
            myImage.topAnchor.constraint(equalTo: topAnchor),
            myImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            myLabel.leadingAnchor.constraint(equalTo: myImage.trailingAnchor, constant: 10),
            myLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            myLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            myLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
