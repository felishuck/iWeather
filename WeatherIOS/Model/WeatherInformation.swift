//
//  Weather.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 22/5/22.
//

import SwiftUI

struct WeatherInformation: Codable, Identifiable {
    let coordinate: Coordinate
    let weather: [Weather]
    let mainData: Temperature
    let visibility: Int
    let wind: Wind
    let sunInformation: SunInformation
    let id:Int
    let name: String
    
    enum CodingKeys: String, CodingKey{
        case coordinate = "coord"
        case weather
        case mainData = "main"
        case visibility
        case wind
        case sunInformation = "sys"
        case id
        case name
    }
    
    func getConditionName()->String{
        switch weather[0].id{
        case 200..<300:
            return "storm"
        case 300..<400:
            return "drizle"
        case 500..<600:
            return "rainy"
        case 600..<700:
            return "snow"
        case 700..<800:
            return "smog"
        case 800:
            return "sunny"
        case 801..<803:
            return "notTooCloudy"
        default:
            return "cloudy"
        }
    }

    
    func getWindInKMH()->Int{
        return Int(self.wind.speed * 3600 / 1000)
    }
    
    
}


extension WeatherInformation: CustomStringConvertible{
    var description: String {
        return "\nPlace: \(self.name)\nTemperature: \(self.mainData.temperature)º\nMin: \(self.mainData.Min)º\nMax: \(self.mainData.Max)º\nDescription: \(self.weather[0].description)"
    }
    
    
}

struct Coordinate: Codable{
    let longitud: Double
    let latitud: Double
    
    enum CodingKeys: String, CodingKey{
        case longitud = "lon"
        case latitud = "lat"
    }
}

struct Weather: Codable{
    let id: Int
    let main: String
    let description: String
}

struct Temperature: Codable{
    let temperature: Double
    let feelsLike: Double
    let Min: Double
    let Max: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey{
        case temperature = "temp"
        case feelsLike = "feels_like"
        case Min = "temp_min"
        case Max = "temp_max"
        case pressure
        case humidity
    }
}

struct Wind: Codable{
    let speed: Double
    let degrees: Int
    
    enum CodingKeys: String, CodingKey{
        case speed
        case degrees = "deg"
    }
}

struct SunInformation: Codable{
    let sunrise: Int
    let sunset: Int
}

