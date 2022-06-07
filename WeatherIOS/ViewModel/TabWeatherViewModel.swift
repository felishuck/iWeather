//
//  TabWeatherViewModel.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 1/6/22.
//

import SwiftUI

class TabWeatherViewModel: ObservableObject{
    @ObservedObject var weatherManager: WeatherManager
    
    @Published var firstBackgroundImage:Image
    @Published var secondBackgroundImage:Image
    @Published var secondImageOpacity: Double
    
    @Published var isWeatherListShown: Bool
    
    init(weatherManager: WeatherManager){
        self.weatherManager = weatherManager
        firstBackgroundImage = Image("")
        secondBackgroundImage = Image("")
        secondImageOpacity = 0
        isWeatherListShown = false
    }
    
    func isListOfWeatherEmpty()->Bool{
        return self.weatherManager.listOfWeather.isEmpty
    }
    
    func currentWeatherInformation()->WeatherInformation?{
        if isListOfWeatherEmpty(){
            let currentIndex = weatherManager.selectedIndex
            return weatherManager.listOfWeather[currentIndex]
        }
        return nil
    }
    
    func listOfWeatherInformation()->[WeatherInformation]{
        return weatherManager.listOfWeather
    }
    
    func udpateImages(){
        let index = self.weatherManager.selectedIndex
        let imageName = self.weatherManager.listOfWeather[index].getConditionName()
        self.firstBackgroundImage = Image(imageName)
        self.secondBackgroundImage = Image(imageName)
    }
    
    func getWeatherImage(by index: Int)->Image{
        let imageName = self.weatherManager.listOfWeather[index].getConditionName()
        return Image(imageName)
    }
    
    func getIndex(for weatherInformation: WeatherInformation)->Int{
        return weatherManager.listOfWeather.firstIndex { weather in
            weatherInformation.id == weather.id
        }!
    }
    

    func backgroundTransition(newIndex:Int){
        let newImageName = weatherManager.listOfWeather[newIndex].getConditionName()
        secondBackgroundImage = Image(newImageName)
        secondImageOpacity = secondImageOpacity == 1 ? 0 : 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.firstBackgroundImage = Image(newImageName)
            self.secondImageOpacity = self.secondImageOpacity == 1 ? 0 : 1
        }
    }
    
    func weatherButtonWasPressed(){
        self.isWeatherListShown = true
    }
}
