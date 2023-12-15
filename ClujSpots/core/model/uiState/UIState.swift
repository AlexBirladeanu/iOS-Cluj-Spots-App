//
//  UIState.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 12.12.2023.
//

import Foundation
import MapKit

class UIState: Identifiable, Equatable {
    
    let id: String = UUID().uuidString
    let lat: Double
    let lon: Double
    let description: String
    
    init(lat: Double, lon: Double, description: String) {
        self.lat = lat
        self.lon = lon
        self.description = description
    }
    
    static func == (lhs: UIState, rhs: UIState) -> Bool {
        return lhs.id == rhs.id
    }
}
