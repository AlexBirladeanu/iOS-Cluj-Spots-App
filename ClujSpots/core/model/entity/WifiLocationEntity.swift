//
//  WifiLocalModel.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 15.12.2023.
//

import SwiftData

@Model
final class WifiLocationEntity: Identifiable {
    
    @Attribute(.unique) var id: String
    var name: String
    var location: String
    var lat: Double
    var lon: Double
    
    init(id: String, name: String, location: String, lat: Double, lon: Double) {
        self.id = id
        self.name = name
        self.location = location
        self.lat = lat
        self.lon = lon
    }
}
