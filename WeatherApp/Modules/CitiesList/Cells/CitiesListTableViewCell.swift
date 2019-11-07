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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static var className: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setActivityIndicator(isRunning: false)
    }
    
    override func prepareForReuse() {
        cityNameLabel.text = nil
        temperatureLabel.text = nil
        setActivityIndicator(isRunning: false)
    }
    
    func setup(with cityName: String, temperature: Int?) {
        cityNameLabel.text = cityName
        if let temperature = temperature {
            temperatureLabel.text = "\(String(temperature)) °C"
        }
    }
    
    func setActivityIndicator(isRunning: Bool) {
        if isRunning {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        activityIndicator.isHidden = !isRunning
        temperatureLabel.isHidden = isRunning
    }
}
