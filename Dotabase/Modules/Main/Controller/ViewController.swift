//
//  ViewController.swift
//  Dotabase
//
//  Created by zhussupov on 25.05.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK - Public properties
    
    var service: DotaServiceProtocol?
    
    //MARK - Private properties
    
    var data = ["Tap me"] {
        didSet {
            myTableView.reloadData()
        }
    }
    
    private lazy var myTableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .gray
        view.separatorStyle = .singleLine
        view.estimatedRowHeight = 100.0
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")         // register cell name
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK - Setup
    
    private func setup() {
        view.backgroundColor = .white
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        [myTableView].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureConstraints() {
        
        //constraints setup with Snapkit pod
        myTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }
    //MARK - Public actions
    
    //MARK -  Private actions
    
    
    private func getHeroes() {
        service?.getHeroes({ [weak self] (heroes) in
            self?.data = heroes.compactMap{ $0.localized_name }
        })
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.myLabel.text = data[indexPath.row]
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = MainViewController()
//        navigationController?.pushViewController(vc, animated: true)
        getHeroes()
    }
    
}
