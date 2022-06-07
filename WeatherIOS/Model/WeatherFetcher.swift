//
//  WeatherFetcher.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 24/5/22.
//

import Foundation

struct WeatherFetcher {
    
    let apiAddress = "https://api.openweathermap.org/data/2.5/weather"
    let appid = "acf1b985e8b56922d01cd383c0f7f257"
    
    func fetchWeather(city:City, listOfWeather:[WeatherInformation], completion: @escaping(Result<WeatherInformation, Error>)->Void){
        
        guard let url = URL(string: "\(apiAddress)?q=\(city.getRequestName())&appid=\(appid)&units=metric") else {return}
        
        let weatherRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: weatherRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                if let weatherInformation = try? JSONDecoder().decode(WeatherInformation.self, from: data){
                    if listOfWeather.contains(where: {weatherInformation.name == $0.name}){
                        completion(.failure(WeatherError.cityAlreadyAddedError))
                    } else {
                        completion(.success(weatherInformation))
                    }
                } else {
                    completion(.failure(WeatherError.cityNotFoundError))
                }
            }
        }.resume()
    }
}
