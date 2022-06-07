//
//  ListOfCitiesViewModel.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 4/6/22.
//

import SwiftUI

class ListOfCitiesViewModel: ObservableObject{
    @Environment (\.presentationMode) var presentationMode
    
    @Published var weatherManager: WeatherManager
    @Published var isNewCityViewShown: Bool = false
    @Published var listOfWeather: [WeatherInformation]
    @Published var rows: [WeatherRowView]
    
    init(weatherManager:WeatherManager){
        self.weatherManager = weatherManager
        isNewCityViewShown = false
        listOfWeather = weatherManager.listOfWeather
        rows = []
        self.updateRows()
        if rows.isEmpty {
            isNewCityViewShown = true
        }
    }
    
    func dismissView(){
        presentationMode.wrappedValue.dismiss()
    }
    
    func addNewCityButtonWasTapped(){
        isNewCityViewShown = true
    }
    
    func dismissAddNewCityView(){
        isNewCityViewShown = false
        updateRows()
    }
    
    func removeWeather(atOffSet indexSet: IndexSet){
        weatherManager.listOfWeather.remove(atOffsets: indexSet)
        weatherManager.selectedIndex = 0
        updateRows()
    }
    
    func getAllWeatherRowViews()->[WeatherRowView]{
        var rows:[WeatherRowView] = []
        for weatherInformation in weatherManager.listOfWeather{
            rows.append(WeatherRowView(weatherInformation))
        }
        
        return rows
    }
    
    func updateRows(){
        self.rows = getAllWeatherRowViews()
    }
    
}
