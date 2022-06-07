//
//  WeatherRowView.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 25/5/22.
//

import SwiftUI

struct WeatherRowView: View, Identifiable {
    
    var id:Int
    @State var weatherInformation: WeatherInformation
    
    init(_ weatherInformation:WeatherInformation){
        id = weatherInformation.id
        self.weatherInformation = weatherInformation
    }
    
    var body: some View {
        VStack{
            HStack(alignment: .top) {
                Text(weatherInformation.name)
                    .font(.title2)
                    .fontWeight(.medium)
                Spacer()
                Text("\(Int(weatherInformation.mainData.temperature))º")
                    .font(.largeTitle)
                    .fontWeight(.medium)
            }
            Spacer()
            HStack{
                Text(weatherInformation.weather[0].description.capitalized)
                Spacer()
                Text("L: \(Int(weatherInformation.mainData.Min))º H:\(Int(weatherInformation.mainData.Max))º")
            }
        }
        .frame(height: 90)
        .foregroundColor(.white)
            .shadow(color: .gray, radius: 10, x: 0, y: 0)
        .padding()
        .background(
            Image(weatherInformation.getConditionName())
                .blur(radius: 5)
        
        )
            .cornerRadius(15)
    }
}

struct WeatherRowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRowView(weatherInformation1)
    }
}
