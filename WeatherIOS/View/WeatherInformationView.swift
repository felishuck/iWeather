//
//  WeatherInformationView.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 25/5/22.
//

import SwiftUI

struct WeatherInformationView: View {
    @State var weatherInformation: WeatherInformation
    init(_ weatherInformation:WeatherInformation){
        self.weatherInformation = weatherInformation
    }
    var body: some View {
        ScrollView {
            VStack {
                WeatherInformationHeadView(weatherInformation: weatherInformation)
                VStack {
                    HStack(spacing:15){
                        WeatherWindInformationView(degress: weatherInformation.wind.degrees, speed: weatherInformation.getWindInKMH())
                            .frame(width:150, height: 150)
                            .padding()
                        .background(.thinMaterial)
                        .cornerRadius(15)
                        WeatherGenericInformationView(iconName: "thermometer", title: "Feels Like", mainInfo: "\(Int(weatherInformation.mainData.feelsLike))º", text: "This sentence is a sample")
                            .frame(width:150, height: 150)
                            .padding()
                        .background(.thinMaterial)
                        .cornerRadius(15)
                    }.padding(.bottom, 10)
                    HStack(spacing:15){
                        WeatherGenericInformationView(iconName: "humidity", title: "Humidity", mainInfo: "\(Int(weatherInformation.mainData.humidity))%", text: "This sentence is a sample")
                            .frame(width:150, height: 150)
                            .padding()
                        .background(.thinMaterial)
                        .cornerRadius(15)
                        WeatherGenericInformationView(iconName: "eye", title: "Visibility", mainInfo: "\(Int(weatherInformation.visibility/1000))km", text: "This sentence is a sample")
                            .frame(width:150, height: 150)
                            .padding()
                        .background(.thinMaterial)
                        .cornerRadius(15)
                    }
                }
            }
        }
    }

}

struct WeatherInformationView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInformationView(weatherInformation1)
            .previewInterfaceOrientation(.portrait)
            .background(
                Image("rainy")
            )
    }
}


