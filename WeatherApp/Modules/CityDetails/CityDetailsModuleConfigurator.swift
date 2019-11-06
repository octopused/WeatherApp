//
//  CityDetailsModuleConfigurator.swift
//  WeatherApp
//
//  Created by RuslanKa on 02.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation
import UIKit

final class CityDetailsModuleConfigurator {
    func createModule(with city: City, weatherInfoList: [WeatherInfo], moduleOutput: CityDetailsModuleOuput? = nil) -> CityDetailsViewController {
        let storyboard = UIStoryboard(name: "CityDetails", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: CityDetailsViewController.self)) as! CityDetailsViewController
        
        let presenter = CityDetailsPresenter(city: city)
        presenter.weatherInfoList = weatherInfoList
        let tableAdapter = CityDetailsTableAdapter()
        let router = CityDetailsRouter()
        
        viewController.adapter = tableAdapter
        viewController.output = presenter
        presenter.view = viewController
        presenter.router = router
        router.view = viewController
        tableAdapter.output = presenter
        
        return viewController
    }
}
