//
//  MainViewController.swift
//  Dotabase
//
//  Created by zhussupov on 26.05.2021.
//  
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - Public properties
    
    
    
    // MARK: - Private properties
    
    private var data = [
        "heroes"
    ]
    
    private var images = [
        "heroImage"
    ]
    
    private lazy var myLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9333333333, green: 0.9215686275, blue: 0.8666666667, alpha: 1)
        label.font = UIFont(name: "Trajan Pro", size: 34)
        label.text = "DOTABASE"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var myCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.itemSize = CGSize(width: view.frame.width*0.4, height: view.frame.height*0.3)
        
        let view = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        view.dataSource = self
        view.delegate = self
        view.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        view.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        view.alwaysBounceVertical = true
        view.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        [myCollectionView, myLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureConstraints() {
        myCollectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(myLabel.snp.bottom)
        }
        
        myLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(40)
        }
    }
    
    // MARK: - Public actions
    
    // MARK: - Private actions
    
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ViewController()
        vc.service = DotaService()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.myLabel.text = data[indexPath.row]
        cell.myImage.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
    
    
}
