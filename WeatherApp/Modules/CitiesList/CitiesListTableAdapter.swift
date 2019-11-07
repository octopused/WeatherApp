//
//  CitiesListTableViewAdapter.swift
//  WeatherApp
//
//  Created by RuslanKa on 01.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation
import UIKit

class CitiesListTableAdapter: NSObject {
    var output: CitiesListAdapterOutput?
    
    var cities: [City] = []
    var weatherInfoList: [WeatherInfo] = []
        
    fileprivate func getTemperature(for city: City) -> Int? {
        let temperature = weatherInfoList
            .filter { $0.city == city }
            .filter { $0.date > Date() }
            .sorted { $0.date < $1.date }
            .first?
            .temperature
        if let temperature = temperature {
            return Int(temperature)
        }
        return nil
    }
    
    func bind(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CitiesListTableViewCell.className, bundle: nil),
                           forCellReuseIdentifier: CitiesListTableViewCell.className)
    }
    
    func set(cities: [City]) {
        self.cities = cities
    }
    
    func set(weatherInfoList: [WeatherInfo]) {
        self.weatherInfoList = weatherInfoList
    }

    func indexPath(for city: City) -> IndexPath? {
        guard let rowIndex = cities.firstIndex(of: city) else {
            return nil
        }
        return IndexPath(row: rowIndex, section: 0)
    }
}

extension CitiesListTableAdapter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitiesListTableViewCell.className, for: indexPath)
        if let cityCell = cell as? CitiesListTableViewCell {
            let city = cities[indexPath.row]
            cityCell.setup(with: city.name, temperature: getTemperature(for: city))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.selectCity(cities[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { [weak self] (action, indexPath) in
            guard let self = self else {
                return
            }
            self.output?.deleteCity(self.cities[indexPath.row])
        })
        return [deleteAction]
    }
}
