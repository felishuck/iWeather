//
//  MainMenuView.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 6/6/22.
//

import SwiftUI

struct MainMenuView: View {
    @Binding var isWeatherListShown:Bool
    var body: some View {
        Image("main")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack(spacing: 40){
                    Text("iWeather")
                        .font(.system(size: 70, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    .shadow(color: .black, radius: 10, x: 0, y: 0)
                    
                    Button {
                        isWeatherListShown = true
                    } label: {
                        Label {
                            Text("Add a New City")
                        } icon: {
                            Image(systemName: "location.fill")
                        }.padding()
                            .background(.thinMaterial)
                            .cornerRadius(20)
                            .foregroundColor(.black)

                    }

                }
            )
    }
}
/*
struct MainMenuView_Previews: PreviewProvider {
    @State var isShown: Bool = false
    static var previews: some View {
        MainMenuView(isWeatherListShown: $isShown)
    }
}*/
