//
//  WifiLocationState.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 12.12.2023.
//

import Foundation
import SwiftData

class WifiLocationState: UIState {
    
    let name: String
    let location: String
    
    init(lat: Double, lon: Double, name: String, location: String) {
        self.name = name
        self.location = location
        super.init(lat: lat, lon: lon, description: "\(name) \(location)")
    }
}
