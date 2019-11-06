//
//  CitiesListModuleConfigurator.swift
//  WeatherApp
//
//  Created by RuslanKa on 01.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation
import UIKit

class CitiesListModuleConfigurator {
    func createModule(with cities: [City], output: CitiesListModuleOutput? = nil) -> CitiesListViewController {
        let storyboard = UIStoryboard(name: "CitiesList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: CitiesListViewController.self)) as! CitiesListViewController
        
        let presenter = CitiesListPresenter(cities: cities)
        let tableAdapter = CitiesListTableAdapter()
        let router = CitiesListRouter()
        
        viewController.adapter = tableAdapter
        viewController.output = presenter
        presenter.view = viewController
        presenter.router = router
        router.view = viewController
        tableAdapter.output = presenter
        
        return viewController
    }
}
