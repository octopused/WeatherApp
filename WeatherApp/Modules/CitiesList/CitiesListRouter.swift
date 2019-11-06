//
//  CitiesListRouter.swift
//  WeatherApp
//
//  Created by RuslanKa on 01.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import UIKit

class CitiesListRouter {
    weak var view: UIViewController?
}

extension CitiesListRouter: CitiesListRouterInput {
    func showCityDetailInfo(city: City, weatherInfoList: [WeatherInfo]) {
        let cityDetailsViewController = CityDetailsModuleConfigurator()
            .createModule(with: city, weatherInfoList: weatherInfoList)
        view?.navigationController?.pushViewController(cityDetailsViewController, animated: true)
    }
    
    func showCitySearch(citySearchModuleOutput: CitySearchModuleOutput?) {
        let citySearchViewController = CitySearchModuleConfigurator().createModule(moduleOutput: citySearchModuleOutput)
        view?.present(citySearchViewController, animated: true, completion: nil)
    }
}
