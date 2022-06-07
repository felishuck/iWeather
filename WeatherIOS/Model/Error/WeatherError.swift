//
//  WeatherError.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 24/5/22.
//

import Foundation

enum WeatherError: Error {
    case cityNotFoundError
    case cityAlreadyAddedError
    case connectingApiError
}
