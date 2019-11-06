//
//  CityDetailsDayTableViewCell.swift
//  WeatherApp
//
//  Created by RuslanKa on 02.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import UIKit

final class CityDetailsDayTableViewCell: UITableViewCell {
    
    static var className: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        dateLabel.text = nil
        timeLabel.text = nil
        temperatureLabel.text = nil
        windSpeedLabel.text = nil
        humidityLabel.text = nil
    }
    
    func setup(with weatherInfo: WeatherInfo, isShowTime: Bool) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        dateLabel.text = dateFormatter.string(from: weatherInfo.date)
        if isShowTime {
            dateFormatter.dateFormat = "HH:00"
            timeLabel.text = dateFormatter.string(from: weatherInfo.date)
            timeLabel.isHidden = false
        } else {
            timeLabel.isHidden = true
        }
        temperatureLabel.text = String(Int(weatherInfo.temperature))
        windSpeedLabel.text = String(Int(weatherInfo.windSpeed))
        humidityLabel.text = String(Int(weatherInfo.humidity))
    }
}
