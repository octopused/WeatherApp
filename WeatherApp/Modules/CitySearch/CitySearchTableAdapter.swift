//
//  CitySearchTableAdapter.swift
//  WeatherApp
//
//  Created by RuslanKa on 03.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import UIKit

final class CitySearchTableAdapter: NSObject {
    
    var output: CitySearchTableAdapterOutput?
    
    var cities: [City] = []
    
    func bind(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CitySearchResultTableViewCell.className, bundle: nil),
                           forCellReuseIdentifier: CitySearchResultTableViewCell.className)
    }
    
    func set(cities: [City]) {
        self.cities = cities
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension CitySearchTableAdapter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitySearchResultTableViewCell.className, for: indexPath)
        if let searchResultCell = cell as? CitySearchResultTableViewCell {
            searchResultCell.setup(with: cities[indexPath.row].name)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.addCity(cities[indexPath.row])
    }
}
