//
//  ViewController.swift
//  Dotabase
//
//  Created by zhussupov on 25.05.2021.
//

import UIKit
import SnapKit
import Kingfisher

class HeroViewController: BaseViewController, KeyboardHandling {
    
    //MARK - Public properties
    
    var service: DotaServiceProtocol?
    
    //MARK - Private properties
    
    private var data: [Hero] = [] {
        didSet {
            let searchStr = mySearchBar.text ?? ""
            filteredData = data.filter {
                ($0.localized_name ?? "").lowercased().contains(searchStr.lowercased()) || searchStr.isEmpty
            }
        }
    }
    
    private var filteredData: [Hero] = [] {
        didSet {
            myTableView.reloadDataAnimated()
        }
    }
    
    private var heroLore: [String: String] = [:]
    
    private lazy var myLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9333333333, green: 0.9215686275, blue: 0.8666666667, alpha: 1)
        label.font = UIFont(name: "Trajan Pro", size: 21)
        label.text = "HEROES"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mySearchBar: HideableSearchBar = {
        let searchBar = HideableSearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.barTintColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        searchBar.layer.borderWidth = 0
        searchBar.delegate = self
        searchBar.searchTextField.textColor = #colorLiteral(red: 0.9333333333, green: 0.9215686275, blue: 0.8666666667, alpha: 1)
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
        view.rowHeight = 80
        view.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")         // register cell name
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(getHeroes), for: .valueChanged)
        return refresh
    }()
    
    //MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getHeroes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserverForKeyboardNotification(with: myTableView)
    }
    
    //MARK - Setup
    
    private func setup() {
        navigationItem.titleView = myLabel
        view.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        myTableView.addSubview(refreshControl)
        [myTableView, mySearchBar].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureConstraints() {
        
        //constraints setup with Snapkit pod
        
        mySearchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            
        }
        
        myTableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(mySearchBar.snp.bottom)
        }
    }
    
    //MARK - Public actions
    
    //MARK -  Private actions
    
    @objc private func getHeroes() {
        myTableView.showActivityIndicator()
        service?.getHeroes({ [weak self] (heroes) in
            self?.myTableView.hideActivityIndicator()
            self?.refreshControl.endRefreshing()
            self?.data = heroes.map { $0.value }
            self?.data.sort(by: { (lhs, rhs) -> Bool in
                return lhs.localized_name ?? "" < rhs.localized_name ?? ""
            })
//                .compactMap{ $0.localized_name }
        })
        service?.getHeroLore({ [weak self] (lore) in
            self?.heroLore = lore
            self?.heroLore["dawnbreaker"] = Dawnbreaker.lore
        })
        
    }
    
    
}

//MARK - Extensions

extension HeroViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.myLabel.text = filteredData[indexPath.row].localized_name
        
        
        if cell.myLabel.text == "Dawnbreaker" {
            let url = URL(string: Dawnbreaker.img)
            cell.myImage.kf.setImage(with: url,
                                     placeholder: nil,
                                     options: [.transition(.fade(0.5))])
        } else {
            let url = URL(string: "https://api.opendota.com" + "\(filteredData[indexPath.row].img ?? "")")
            cell.myImage.kf.indicatorType = .activity
            cell.myImage.kf.setImage(with: url,
                                     placeholder: nil,
                                     options: [.transition(.fade(0.5))])
        }
        
        cell.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        
        return cell
    }
}

extension HeroViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = HeroDetailsViewController()
        vc.hero = filteredData[indexPath.row]
        if let heroName = filteredData[indexPath.row].name?.replacingOccurrences(of: "npc_dota_hero_", with: ""),
           let lore = heroLore[heroName] {
            vc.lore = lore
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HeroViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = data.filter {
            ($0.localized_name ?? "").lowercased().contains(searchText.lowercased()) || searchText.isEmpty
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
}
