//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by RuslanKa on 03.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import Foundation

public struct MessageResponse: Decodable {
    var code: String
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message = "message"
    }
     
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try (try? container.decode(String.self, forKey: .code)) ?? String(try container.decode(Int.self, forKey: .code))
        message = try? container.decode(String.self, forKey: .message)
    }
}

public struct WeatherResponse: Decodable {
    var coordinates: CoordinatesResponse
    var mainWeatherInfo: MainWeatherInfoResponse
    var windInfo: WindInfoResponse
    var cityId: Int
    var cityName: String
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case mainWeatherInfo = "main"
        case windInfo = "wind"
        case cityId = "id"
        case cityName = "name"
        case date = "dt"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        coordinates = try container.decode(CoordinatesResponse.self, forKey: .coordinates)
        mainWeatherInfo = try container.decode(MainWeatherInfoResponse.self, forKey: .mainWeatherInfo)
        windInfo = try container.decode(WindInfoResponse.self, forKey: .windInfo)
        cityId = try container.decode(Int.self, forKey: .cityId)
        cityName = try container.decode(String.self, forKey: .cityName)
        let timeIntervalDate = try container.decode(TimeInterval.self, forKey: .date)
        date = Date.init(timeIntervalSince1970: timeIntervalDate)
    }
}

public struct MainWeatherInfoResponse: Decodable {
    var temperature: Double
    var temperatureMin: Double
    var temperatureMax: Double
    var humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
        case humidity = "humidity"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try container.decode(Double.self, forKey: .temperature)
        temperatureMin = try container.decode(Double.self, forKey: .temperatureMin)
        temperatureMax = try container.decode(Double.self, forKey: .temperatureMax)
        humidity = try container.decode(Double.self, forKey: .humidity)
    }
}

public struct WindInfoResponse: Decodable {
    var windSpeed: Double
    
    enum CodingKeys: String, CodingKey {
        case windSpeed = "speed"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        windSpeed = try container.decode(Double.self, forKey: .windSpeed)
    }
}

public struct ForecastResponse: Decodable {
    var list: [WeatherDetailResponse]
    var city: CityResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case list = "list"
        case city = "city"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        list = try container.decode([WeatherDetailResponse].self, forKey: .list)
        city = try container.decode(CityResponse.self, forKey: .city)
    }
}

public struct WeatherDetailResponse: Decodable {
    var date: Date
    var mainInfo: MainWeatherInfoResponse
    var windInfo: WindInfoResponse
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case mainInfo = "main"
        case windInfo = "wind"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let timeIntervalDate = try container.decode(TimeInterval.self, forKey: .date)
        date = Date.init(timeIntervalSince1970: timeIntervalDate)
        mainInfo = try container.decode(MainWeatherInfoResponse.self, forKey: .mainInfo)
        windInfo = try container.decode(WindInfoResponse.self, forKey: .windInfo)
    }
}

public struct CityResponse: Decodable {
    var id: Int
    var name: String
    var coordinates: CoordinatesResponse
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case coordinates = "coord"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        coordinates = try container.decode(CoordinatesResponse.self, forKey: .coordinates)
    }
}

public struct CoordinatesResponse: Decodable {
    var latitude: Double
    var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }
}
