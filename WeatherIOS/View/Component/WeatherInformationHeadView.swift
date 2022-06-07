//
//  WeatherInformationHeadView.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 25/5/22.
//

import SwiftUI

struct WeatherInformationHeadView: View {
    @State var weatherInformation:WeatherInformation
    var body: some View {
        VStack{
            Text(weatherInformation.name)
                .font(.title)
            Text("\(Int(weatherInformation.mainData.temperature))º")
                .font(.system(size: 80))
                .fontWeight(.light)
            Text(weatherInformation.weather[0].description.capitalized)
                .font(.title2)
            HStack{
                Text("H:\(Int(weatherInformation.mainData.Min))º   L:\(Int(weatherInformation.mainData.Min))º")
            }
        }.frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .padding(100)
    }
}

struct WeatherInformationHeadView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInformationHeadView(weatherInformation: weatherInformation1).background(.gray)
    }
}
