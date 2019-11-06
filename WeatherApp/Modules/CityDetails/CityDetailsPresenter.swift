//
//  CityDetailsPresenter.swift
//  WeatherApp
//
//  Created by RuslanKa on 02.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import CoreData
import Foundation

final class CityDetailsPresenter {
    weak var view: CityDetailsViewInput?
    var router: CityDetailsRouterInput?
    var weatherService: OpenWeatherAPIService
    
    var city: City
    var weatherInfoList: [WeatherInfo] = []
    var fromDate: Date
    var state: CityDetailsState
    
    init(city: City) {
        self.city = city
        self.fromDate = Date()
        self.state = .short
        self.weatherService = OpenWeatherAPIService()
    }
    
    // MARK: - Private Methods
    
    func displayWeather(for state: CityDetailsState) {
        switch state {
        case .short:
            let weatherInfoByDays = self.getAggregatedWeatherInfoByDays(weatherInfoList: weatherInfoList)
            self.view?.set(weatherInfoList: weatherInfoByDays, footerText: "MORE", isShowTime: false)
        case .full:
            self.view?.set(weatherInfoList: weatherInfoList, footerText: "LESS", isShowTime: true)
        }
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadView()
        }
    }

    func getAggregatedWeatherInfoByDays(weatherInfoList: [WeatherInfo]) -> [WeatherInfo] {
        let calendar = Calendar.current
        let weatherInfoDaytime = weatherInfoList.filter { (weatherInfo) -> Bool in
            let hourComponent = calendar.component(.hour, from: weatherInfo.date)
            return hourComponent > 12 && hourComponent < 17
        }
        let weatherInfoByDays = weatherInfoDaytime.reduce([Date: WeatherInfo]()) { (result, weatherInfo) -> [Date: WeatherInfo] in
            let yearComponent = calendar.component(.year, from: weatherInfo.date)
            let monthComponent = calendar.component(.month, from: weatherInfo.date)
            let dayComponent = calendar.component(.day, from: weatherInfo.date)
            let components = DateComponents(year: yearComponent, month: monthComponent, day: dayComponent)
            guard let dayDate = calendar.date(from: components) else {
                return result
            }
            var aggregated = result
            if aggregated[dayDate] == nil {
                aggregated[dayDate] = weatherInfo
            }
            return aggregated
        }
        return weatherInfoByDays.map { $0.value }.sorted(by: { $0.date < $1.date })
    }
    
}

// MARK: - CityDetailsViewOutput

extension CityDetailsPresenter: CityDetailsViewOutput {
    func viewDidLoad() {
        view?.setTitle(city.name)
        displayWeather(for: self.state)
    }
}

// MARK: - CityDetailsTableAdapterOutput

extension CityDetailsPresenter: CityDetailsTableAdapterOutput {
    func showMoreOrLess() {
        if state == .short {
            state = .full
        } else {
            state = .short
        }
        displayWeather(for: state)
    }
}
