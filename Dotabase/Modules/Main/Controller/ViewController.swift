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
    
    private var data = ["Tap me"] {
        didSet {
            myTableView.reloadData()
        }
    }
    
    private lazy var myLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9333333333, green: 0.9215686275, blue: 0.8666666667, alpha: 1)
        label.font = UIFont(name: "Trajan Pro", size: 34)
        label.text = "HEROES"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.barTintColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        searchBar.layer.borderWidth = 0
        searchBar.delegate = self
//        navigationItem.titleView = searchBar
        return searchBar
    }()
    
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
        view.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        [myTableView, myLabel, mySearchBar].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureConstraints() {
        
        //constraints setup with Snapkit pod
        myLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(40)
        }
        
        mySearchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(myLabel.snp.bottom).inset(-20)
        }
        
        myTableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(mySearchBar.snp.bottom).inset(-20)
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

//MARK - Extensions

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
        getHeroes()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
