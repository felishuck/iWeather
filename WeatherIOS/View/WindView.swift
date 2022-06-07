//
//  WindView.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 22/5/22.
//

import SwiftUI

struct WindView: View {
    @State var wind:Wind = Wind(speed: 1.4, degrees: 360)
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 200)
                .opacity(0.15)
                .overlay(VStack(alignment:.leading){
                    HStack {
                        Image(systemName: "wind")
                        Text("Wind")
                            .fontWeight(.bold)
                        Spacer()
                    }.foregroundColor(.gray)
                    Spacer()
                }.padding())
            Circle()
                .frame(width: 100)
                .opacity(0.15)
            VStack{
                Text("\(wind.speed.description)")
                    .font(.title)
                Text("m/s")
                    .font(.body)
            }
        }
    }
}

struct WindView_Previews: PreviewProvider {
    static var previews: some View {
        WindView()
    }
}
