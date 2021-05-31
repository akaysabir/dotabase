//
//  HeroDetailsControllerViewController.swift
//  Dotabase
//
//  Created by zhussupov on 30.05.2021.
//  
//

import UIKit

class HeroDetailsViewController: UIViewController {
    
    // MARK: - Public properties
    
    public var hero: Hero = Hero()
    public var lore: String?
    
    // MARK: - Private properties
    
    private lazy var viewTitle: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9333333333, green: 0.9215686275, blue: 0.8666666667, alpha: 1)
        label.font = UIFont(name: "Trajan Pro", size: 21)
        label.text = hero.localized_name
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var avatarImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        let url = URL(string: "\(hero.image_url ?? "")")
        view.kf.setImage(with: url)
        return view
    }()
    
    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9333333333, green: 0.9215686275, blue: 0.8666666667, alpha: 1)
        label.font = UIFont(name: "Trajan Pro", size: 30)
        label.text = "Hero lore"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loreLabel: UITextView = {
        let label = UITextView()
        label.textColor = #colorLiteral(red: 0.9333333333, green: 0.9215686275, blue: 0.8666666667, alpha: 1)
        label.font = UIFont(name: "Arial", size: 17)
        label.text = lore
        label.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        label.isEditable = false
//        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        navigationItem.titleView = viewTitle
        view.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        [avatarImage, sectionTitleLabel, loreLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureConstraints() {
        avatarImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(20)
            $0.width.equalTo(140)
            $0.height.equalTo(100)
        }
        
        sectionTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(avatarImage.snp.bottom).inset(-20)
        }
        
        loreLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
            $0.top.equalTo(sectionTitleLabel.snp.bottom)
        }
    }
    
    // MARK: - Public actions
    
    // MARK: - Private actions
    
}
