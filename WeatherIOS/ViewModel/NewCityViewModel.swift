//
//  NewCityViewModel.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 4/6/22.
//

import Foundation

class NewCityViewModel: ObservableObject{
    @Published var weatherManager: WeatherManager
    @Published var cityName:String
    
    init(_ weatherManager:WeatherManager){
        self.weatherManager = weatherManager
        cityName = ""
    }
    
    func saveButtonWasTapped(_ newCityView: NewCityView?){
        self.weatherManager.appendNewWeather(city: City(name: cityName), newCityView: newCityView)
    }
    
    func cancelButtonTapped(_ newCityView: NewCityView){
        newCityView.presentationMode.wrappedValue.dismiss()
    }
    
    
}
