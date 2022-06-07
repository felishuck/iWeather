//
//  WeatherInformationHumidityView.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 25/5/22.
//

import SwiftUI

struct WeatherGenericInformationView: View {
    @State var iconName:String
    @State var title:String
    @State var mainInfo:String
    @State var text:String
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            HStack{
                Image(systemName: iconName)
                Text(title)
                Spacer()
            }.foregroundColor(.secondary)
            Text(mainInfo)
                .font(.system(size: 60))
                .foregroundColor(.white)
            Spacer()
        }.overlay(
            VStack{
                Spacer()
                Text(text)
                    .lineLimit(2)
                    .frame(width: 180)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.white)
            }
        )
    }
}

struct WeatherInformationHumidityView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherGenericInformationView(
            iconName: "humidity.fill",
            title: "Humidity",
            mainInfo: "45%",
            text: "This sentence is a sample or not")
        .background(.gray)
    }
}
