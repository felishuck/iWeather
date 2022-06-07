//
//  Theme.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 29/5/22.
//

import Foundation
import SwiftUI

struct Theme: Identifiable{
    var id:Int
    var gradient:LinearGradient
}

extension Theme:Equatable{
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        lhs.id == rhs.id
    }
}
