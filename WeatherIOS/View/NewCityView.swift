//
//  NewCityView.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 24/5/22.
//

import SwiftUI

struct NewCityView: View {

    @Environment (\.presentationMode) var presentationMode
    
    //@ObservedObject private var viewModel: NewCityViewModel
    @ObservedObject private var weatherManager: WeatherManager
    @State private var cityName: String = ""
    
    init(_ weatherManager:WeatherManager){
        //self.viewModel = NewCityViewModel(weatherManager)
        self.weatherManager = weatherManager
    }
    
    var body: some View {
        NavigationView {
            VStack{
                VStack {
                    HStack {
                        TextField("Insert a City Name", text: self.$cityName)
                        if weatherManager.isLoading{
                            ProgressView()
                        }
                    }
                    Divider()
                }
                if !self.weatherManager.errorMessage.isEmpty{
                    Text(self.weatherManager.errorMessage)
                        .onChange(of: self.cityName) { _ in
                            self.weatherManager.errorMessage = ""
                        }
                        .foregroundColor(.red)
                }
                Spacer()
            }.padding()
                .navigationTitle("New City")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save"){
                            saveButtonWasTapped()
                        }.disabled(self.weatherManager.isLoading || self.cityName.isEmpty)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel"){
                            cancelButtonWasTapped()
                        }.disabled(self.weatherManager.isLoading)
                    }
                }
                
        }
    }
    
    func saveButtonWasTapped(){
        self.weatherManager.appendNewWeather(city: City(name: cityName), newCityView: self)
    }
    
    func cancelButtonWasTapped(){
        presentationMode.wrappedValue.dismiss()
    }
}

struct NewCityView_Previews: PreviewProvider {
    static var previews: some View {
        NewCityView(WeatherManager())
    }
}
