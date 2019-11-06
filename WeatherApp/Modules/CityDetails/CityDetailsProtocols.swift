//
//  CityDetailsProtocols.swift
//  WeatherApp
//
//  Created by RuslanKa on 02.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation

protocol CityDetailsViewInput: class {
    func reloadView()
    func set(weatherInfoList: [WeatherInfo], footerText: String, isShowTime: Bool)
    func setTitle(_ title: String)
}

protocol CityDetailsViewOutput {
    func viewDidLoad()
}

protocol CityDetailsModuleOuput {
    
}

protocol CityDetailsRouterInput {
    
}

protocol CityDetailsTableAdapterOutput {
    func showMoreOrLess()
}

protocol CityDetailsTableFooterDelegate {
    func footerTouched()
}

enum CityDetailsState {
    case short
    case full
}
