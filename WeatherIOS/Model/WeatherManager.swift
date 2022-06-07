//
//  WeatherManager.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 22/5/22.
//

import Foundation
import Combine

class WeatherManager: ObservableObject{
    @Published var listOfWeather: [WeatherInformation] = []{
        didSet{
            self.saveCities()
        }
    }
    @Published var isLoading: Bool
    @Published var errorMessage: String
    @Published var wasSavedSuccesfully: Bool
    @Published var selectedIndex: Int
    @Published var cityName:String
    
    private var apiAddress = "https://api.openweathermap.org/data/2.5/weather"
    private var appdid = "acf1b985e8b56922d01cd383c0f7f257"
    private var userDefault:UserDefaults
    
    init(){
        self.userDefault = UserDefaults()
        self.isLoading = false
        self.errorMessage = ""
        self.wasSavedSuccesfully = false
        self.selectedIndex = 0
        self.cityName = ""
        self.listOfWeather = self.loadWeatherList()
        self.updateWeatherInformation()

    }
    
    func getWeatherIndex(_ weatherInformation:WeatherInformation)->Int{
        let index = self.listOfWeather.firstIndex(where: {$0.name == weatherInformation.name})!
        return index
    }
    
    func saveCities(){
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self.listOfWeather){
            self.userDefault.setValue(data, forKey: "weather.cities")
        }
    }
    
    func loadWeatherList()->[WeatherInformation]{
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "weather.cities"),
           let weatherList = try? decoder.decode([WeatherInformation].self, from: data){
            return weatherList
        } else {
            return []
        }
    }
    
    func updateWeatherInformation(){
        
        for (index, weather) in self.listOfWeather.enumerated(){
            let city = City(name: weather.name)
            WeatherFetcher().fetchWeather(city: city, listOfWeather: self.listOfWeather) { [unowned self] result in
                switch result {
                case .success(let weatherInformation):
                    DispatchQueue.main.async {
                        self.listOfWeather[index] = weatherInformation
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    
    
    func appendNewWeather(city:City, newCityView:NewCityView?){
        self.isLoading = true
        WeatherFetcher().fetchWeather(city: city, listOfWeather: self.listOfWeather) { [unowned self] result in
            switch result {
            case .success(let weatherInformation):
                DispatchQueue.main.async {
                    self.listOfWeather.append(weatherInformation)
                    self.isLoading = false
                    if let newCityView = newCityView {
                        newCityView.presentationMode.wrappedValue.dismiss()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    if let error = error as? WeatherError{
                        if error == WeatherError.cityNotFoundError{
                            self.errorMessage = "City not found"
                        }
                        
                        if error == WeatherError.cityAlreadyAddedError{
                            self.errorMessage = "This city was already added"
                        }
                    }
                    self.isLoading = false
                }
            }
        }
    }
    
    func printWeather(){
        print(listOfWeather.count)
        for weather in listOfWeather{
            print(weather)
        }
    }
}

#if DEBUG

let weatherInformation1 = WeatherInformation(
    coordinate:
        Coordinate(longitud: 120.34, latitud: -102.31),
    weather: [Weather(id: 800, main: "Clear", description: "clear sky")],
    mainData: Temperature(
        temperature: 28.5,
        feelsLike: 29,
        Min: 25,
        Max: 30,
        pressure: 1023,
        humidity: 40),
    visibility: 10000,
    wind: Wind(
        speed: 5.0,
        degrees: 120),
    sunInformation:
        SunInformation(
            sunrise: 1560343627,
            sunset: 1560396563),
    id:12345678,
    name: "Medina-Sidonia")

#endif

