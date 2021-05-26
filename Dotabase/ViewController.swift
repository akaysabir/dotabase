//
//  ViewController.swift
//  Dotabase
//
//  Created by zhussupov on 25.05.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    //MARK - Public properties
    
    //MARK - Private properties
    
    let data = [
        "Foo",
        "Bar",
        "Baz",
        "Kek",
        "Cheburek"
    ]
    
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
