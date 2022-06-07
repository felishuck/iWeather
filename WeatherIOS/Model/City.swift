//
//  City.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 24/5/22.
//

import Foundation

struct City{
    var name:String
    
    func getRequestName()->String{
        var result = ""
        for character in name{
            result.append(character == " " ? "%20" : "\(character)")
        }
        return result
    }
}

extension City: Codable{
    
}
