//
//  OpenWeatherAPIService.swift
//  WeatherApp
//
//  Created by RuslanKa on 02.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation

class OpenWeatherAPIService {
    
    private let urlSession = URLSession.shared
    private var baseUrl = URL(string: Constants.OpenWeather.openWeather)!
    private let apiKey = Constants.OpenWeather.openWeatherApiKey
    
    private var jsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }
    
    enum APIServiceError: Error {
        case urlError
        case error(description: String? = nil)
        case decodeError
        case noData
    }
    
    enum Endpoints: String {
        case currentWeather = "weather"
        case forecast = "forecast"
    }
    
    enum APIParams {
        case weatherByCoordinates(latitude: String, longitude: String)
        case weatherByCityName(cityName: String)
        case weatherByCityId(cityId: String)
        var urlString: String {
            switch self {
            case .weatherByCoordinates(let latitude, let longitude):
                return "lat=\(latitude)&lon=\(longitude)"
            case .weatherByCityName(let cityName):
                return "q=\(cityName)"
            case .weatherByCityId(let cityId):
                return "id=\(cityId)"
            }
        }
    }
    
    private func fetchResources<T: Decodable>(fromUrlString urlString: String, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard let url = URL(string: urlString),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.urlError))
            return
        }
        
        let queryItems = [URLQueryItem(name: "appid", value: apiKey), URLQueryItem(name: "units", value: "metric")]
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = queryItems
        } else {
            urlComponents.queryItems?.append(contentsOf: queryItems)
        }
        
        guard let fullUrl = urlComponents.url else {
            completion(.failure(.urlError))
            return
        }
        
        urlSession.dataTask(with: fullUrl) { [weak self] (data, response, error) in
            guard let self = self else {
                return
            }
            guard error == nil else {
                completion(.failure(.error(description: error!.localizedDescription)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            guard let messageResponse = try? self.jsonDecoder.decode(MessageResponse.self, from: data) else {
                completion(.failure(.decodeError))
                return
            }
            if messageResponse.code == "200" {
                guard let values = try? self.jsonDecoder.decode(T.self, from: data) else {
                    completion(.failure(.decodeError))
                    return
                }
                completion(.success(values))
            } else {
                completion(.failure(.error(description: messageResponse.message)))
            }
        }.resume()
    }
    
    func getWeatherCurrent(cityName: String, completion: @escaping (Result<WeatherResponse, APIServiceError>) -> Void) {
        let urlString = "\(baseUrl.appendingPathComponent(Endpoints.currentWeather.rawValue))" +
            "?\(APIParams.weatherByCityName(cityName: cityName).urlString)"
        fetchResources(fromUrlString: urlString, completion: completion)
    }
    
    func getWeatherCurrent(cityId: Int, completion: @escaping (Result<WeatherResponse, APIServiceError>) -> Void) {
        let urlString = "\(baseUrl.appendingPathComponent(Endpoints.currentWeather.rawValue))" +
            "?\(APIParams.weatherByCityId(cityId: String(cityId)).urlString)"
        fetchResources(fromUrlString: urlString, completion: completion)
    }
    
    func getWeatherForecast(cityName: String, completion: @escaping (Result<ForecastResponse, APIServiceError>) -> Void) {
        let urlString = "\(baseUrl.appendingPathComponent(Endpoints.forecast.rawValue))" +
            "?\(APIParams.weatherByCityName(cityName: cityName).urlString)"
        fetchResources(fromUrlString: urlString, completion: completion)
    }
    
    func getWeatherForecast(cityId: Int, completion: @escaping (Result<ForecastResponse, APIServiceError>) -> Void) {
        let urlString = "\(baseUrl.appendingPathComponent(Endpoints.forecast.rawValue))" +
            "?\(APIParams.weatherByCityId(cityId: String(cityId)).urlString)"
        fetchResources(fromUrlString: urlString, completion: completion)
    }
    
    func getWeatherCurrent(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, APIServiceError>) -> Void) {
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = ","
        numberFormatter.maximumFractionDigits = 6
        guard let latitudeString = numberFormatter.string(from: NSNumber(value: latitude)),
            let longitudeString = numberFormatter.string(from: NSNumber(value: longitude)) else {
            completion(.failure(.error(description: "Can't parse coordinates for query")))
            return
        }
        let urlString = "\(baseUrl.appendingPathComponent(Endpoints.currentWeather.rawValue))" +
            "?\(APIParams.weatherByCoordinates(latitude: latitudeString, longitude: longitudeString).urlString)"
        fetchResources(fromUrlString: urlString, completion: completion)
    }
    
}


