//
//  CityDetailsTableViewAdapter.swift
//  WeatherApp
//
//  Created by RuslanKa on 02.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation
import UIKit

final class CityDetailsTableAdapter: NSObject {
    var output: CityDetailsTableAdapterOutput?
    
    var weatherInfos: [WeatherInfo] = []
    var footerText: String = ""
    var isShowTime: Bool = true
    
    func bind(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CityDetailsDayTableViewCell.className, bundle: nil),
                           forCellReuseIdentifier: CityDetailsDayTableViewCell.className)
        tableView.register(UINib(nibName: CityDetailsTableFooterView.className, bundle: nil),
                           forHeaderFooterViewReuseIdentifier: CityDetailsTableFooterView.className)
    }
    
    func set(weatherInfos: [WeatherInfo], isShowTime: Bool) {
        self.weatherInfos = weatherInfos.sorted { $0.date < $1.date }
        self.isShowTime = isShowTime
    }
    
    func setFooterText(_ text: String) {
        self.footerText = text
    }

}

extension CityDetailsTableAdapter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityDetailsDayTableViewCell.className, for: indexPath)
        if let dayCell = cell as? CityDetailsDayTableViewCell {
            dayCell.setup(with: weatherInfos[indexPath.row], isShowTime: self.isShowTime)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CityDetailsTableFooterView.className) as? CityDetailsTableFooterView
        footerView?.delegate = self
        footerView?.setup(with: footerText)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}

extension CityDetailsTableAdapter: CityDetailsTableFooterDelegate {
    func footerTouched() {
        output?.showMoreOrLess()
    }
}
