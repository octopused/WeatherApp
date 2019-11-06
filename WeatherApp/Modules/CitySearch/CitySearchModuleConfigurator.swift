//
//  CitySearchModuleConfigurator.swift
//  WeatherApp
//
//  Created by RuslanKa on 03.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import UIKit

final class CitySearchModuleConfigurator {
    func createModule(moduleOutput: CitySearchModuleOutput? = nil) -> CitySearchViewController {
        let storyboard = UIStoryboard(name: "CitySearch", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: CitySearchViewController.self)) as! CitySearchViewController
        
        let presenter = CitySearchPresenter()
        let router = CitySearchRouter()
        let tableAdapter = CitySearchTableAdapter()
        
        viewController.output = presenter
        viewController.adapter = tableAdapter
        presenter.view = viewController
        presenter.router = router
        presenter.output = moduleOutput
        router.view = viewController
        tableAdapter.output = presenter
        
        return viewController
    }
}
