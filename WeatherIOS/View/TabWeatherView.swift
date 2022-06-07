//
//  ContentView.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 27/5/22.
//

import SwiftUI

struct TabWeatherView: View {

    @ObservedObject private var viewModel: TabWeatherViewModel
    
    @State private var selectedIndex:Int = 0

    init(_ weatherManager:WeatherManager){
        viewModel = TabWeatherViewModel(weatherManager: weatherManager)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    Group{
                        viewModel.firstBackgroundImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)

                        viewModel.secondBackgroundImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(viewModel.secondImageOpacity)
                        .animation(.easeInOut(duration: 0.5), value: viewModel.secondImageOpacity)
                    }.edgesIgnoringSafeArea(.vertical)
                )                    .fullScreenCover(isPresented: self.$viewModel.isWeatherListShown, onDismiss: {
                    self.viewModel.weatherManager.updateWeatherInformation()
                }, content: {
                    ListOfCitiesView(weatherManager: self.viewModel.weatherManager)
                })
            if !viewModel.weatherManager.listOfWeather.isEmpty{
                TabView(selection: self.$selectedIndex){
                    ForEach(self.viewModel.listOfWeatherInformation()) { weatherInformation in
                        WeatherInformationView(weatherInformation)
                            .tag(self.viewModel.getIndex(for: weatherInformation))
                    }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .onAppear{
                        viewModel.udpateImages()
                    }
                    .onChange(of: self.selectedIndex, perform: { newValue in
                        viewModel.weatherManager.updateWeatherInformation()
                        viewModel.backgroundTransition(newIndex: newValue)
                    })
                ListCityButton(isWeatherListShown: self.$viewModel.isWeatherListShown)
            } else {
                MainMenuView(isWeatherListShown: self.$viewModel.isWeatherListShown)
            }
            
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabWeatherView(WeatherManager())
    }
}

struct ListCityButton: View {
    @Binding var isWeatherListShown: Bool

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Button(action: {
                    self.isWeatherListShown = true
                }, label: {
                    Image(systemName: "list.bullet.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                }
                ).padding(.trailing, 20)
                Spacer()
            }
        }
    }
}
