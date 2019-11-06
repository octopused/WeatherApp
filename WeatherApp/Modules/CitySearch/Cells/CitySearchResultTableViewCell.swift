//
//  CitySearchResultTableViewCell.swift
//  WeatherApp
//
//  Created by RuslanKa on 03.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import UIKit

final class CitySearchResultTableViewCell: UITableViewCell {

    static var className: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityNameLabel.text = nil
    }
    
    func setup(with cityName: String) {
        cityNameLabel.text = cityName
    }
    
}
