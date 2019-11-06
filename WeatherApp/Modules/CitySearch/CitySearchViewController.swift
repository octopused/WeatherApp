//
//  CitySearchViewController.swift
//  WeatherApp
//
//  Created by RuslanKa on 03.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import UIKit

final class CitySearchViewController: UIViewController {

    var output: CitySearchViewOutput?
    var adapter: CitySearchTableAdapter?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.viewDidLoad()
    }

    func setupUI() {
        tableView.rowHeight = 80
        adapter?.bind(tableView: tableView)
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
    }
}

// MARK: - CitySearchViewInput

extension CitySearchViewController: CitySearchViewInput {
    func setSearchResults(_ cities: [City]) {
        adapter?.set(cities: cities)
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension CitySearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        output?.close()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output?.searchCity(with: searchText)
    }
}
