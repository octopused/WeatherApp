//
//  CitiesListViewController.swift
//  WeatherApp
//
//  Created by RuslanKa on 01.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import UIKit

final class CitiesListViewController: UIViewController {

    // MARK: - Properties
    
    var output: CitiesListViewOutput?
    var adapter: CitiesListTableAdapter?
    
    @IBOutlet weak var tableView: UITableView!
    let addNewCityButton: UIButton = UIButton()
    let refreshControl = UIRefreshControl()
    
    // MARK: - Private
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.visibleCells.forEach { $0.setSelected(false, animated: true) }
    }

    func setupUI() {
        tableView.rowHeight = 80
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        adapter?.bind(tableView: tableView)
        
        addNewCityButton.setTitle("Add City", for: .normal)
        addNewCityButton.setTitleColor(.black, for: .normal)
        addNewCityButton.addTarget(self, action: #selector(addNewCity), for: .touchUpInside)
        
        navigationItem.setRightBarButton(UIBarButtonItem(customView: addNewCityButton), animated: false)
    }
    
    @objc func addNewCity() {
        output?.showCitySearch()
    }
    
    @objc func reloadData() {
        output?.reloadData()
        refreshControl.endRefreshing()
    }
}

extension CitiesListViewController: CitiesListViewInput {
    func set(cities: [City]) {
        adapter?.set(cities: cities)
    }
    
    func set(weatherInfoList: [WeatherInfo]) {
        adapter?.set(weatherInfoList: weatherInfoList)
    }
    
    func enableAddCityButton(_ isEnabled: Bool) {
        addNewCityButton.setTitleColor(isEnabled ? .black : .lightGray, for: .normal)
        addNewCityButton.isEnabled = isEnabled
    }
    
    func reloadView() {
        tableView.reloadData()
    }
}
