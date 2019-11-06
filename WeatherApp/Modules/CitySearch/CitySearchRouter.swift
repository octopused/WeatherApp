//
//  CitySearchRouter.swift
//  WeatherApp
//
//  Created by RuslanKa on 03.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import UIKit

final class CitySearchRouter {
    weak var view: UIViewController?
}

extension CitySearchRouter: CitySearchRouterInput {
    func close() {
        view?.dismiss(animated: true, completion: nil)
    }
}
