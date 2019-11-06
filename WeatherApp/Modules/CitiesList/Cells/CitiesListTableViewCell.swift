//
//  CitiesListTableViewCell.swift
//  WeatherApp
//
//  Created by RuslanKa on 01.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import UIKit

class CitiesListTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    static var className: String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        cityNameLabel.text = nil
        temperatureLabel.text = nil
    }
    
    func setup(with cityName: String, temperature: Int?) {
        cityNameLabel.text = cityName
        if let temperature = temperature {
            temperatureLabel.text = "\(String(temperature)) °C"
        }
    }
}
