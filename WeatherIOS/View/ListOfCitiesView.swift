//
//  ContentView.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 22/5/22.
//

import SwiftUI


struct ListOfCitiesView: View {

    @Environment (\.presentationMode) var presentationMode

    @ObservedObject var viewModel: ListOfCitiesViewModel
    
    init(weatherManager:WeatherManager){
        self.viewModel = ListOfCitiesViewModel(weatherManager: weatherManager)
        //UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "pink")!]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "rainBlue")!]
        
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(self.viewModel.rows) { weatherRowView in
                    weatherRowView
  
                }
                .onDelete(perform: { indexSet in
                    self.viewModel.removeWeather(atOffSet: indexSet)
                })
                .onAppear{
                    self.viewModel.weatherManager.updateWeatherInformation()
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
            }
            .onAppear{
                self.viewModel.updateRows()
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.viewModel.addNewCityButtonWasTapped()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }
                }
            }.sheet(isPresented: self.$viewModel.isNewCityViewShown) {
                viewModel.dismissAddNewCityView()
            } content: {
                NewCityView(self.viewModel.weatherManager)
            }.background(LinearGradient(colors: [Color("rainBlue"), Color("pink")], startPoint: .topLeading, endPoint: .bottomTrailing))
                .navigationTitle("Cities")
                .foregroundColor(Color("pink"))

        }
    }
}

struct ListOfCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfCitiesView(weatherManager: WeatherManager())
    }
}
