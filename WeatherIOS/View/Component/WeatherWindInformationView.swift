//
//  WeatherWindInformationView.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 1/6/22.
//

import SwiftUI

struct WeatherWindInformationView: View {
    @State private var degress: Int
    @State private var speed: Int
    
    init(degress:Int, speed:Int){
        self.degress = degress
        self.speed = speed
    }
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "wind")
                Text("Wind")
                Spacer()
            }.foregroundColor(.secondary)
            Circle()
                .foregroundColor(.clear)
                .overlay(
                    ZStack {
                        Image("compas")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay(
                                Image("arrow2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .rotationEffect(Angle(degrees: Double(degress)))
                            )
                        Circle()
                            .frame(width: 60, height: 60, alignment: .center)
                            .overlay(
                                VStack{
                                    Text("\(speed)")
                                    Text("km/h")
                                }.foregroundColor(.white)
                            )
                    }
                )
        }
    }
}

struct WeatherWindInformationView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWindInformationView(degress: 45, speed: 23)
            .background(.gray)
    }
}
