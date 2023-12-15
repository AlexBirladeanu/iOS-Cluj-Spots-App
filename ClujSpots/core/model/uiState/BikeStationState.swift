//
//  BikeStationState.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 12.12.2023.
//

import Foundation

class BikeStationState: UIState {
    
    let station: String
    let isActive: Bool
    let bikeGates: Int
    let emptyGates: Int
    let serviceGates: Int
    
    init(lat: Double, lon: Double, station: String, isActive: Bool, bikeGates: Int, emptyGates: Int, serviceGates: Int) {
        self.station = station
        self.isActive = isActive
        self.bikeGates = bikeGates
        self.emptyGates = emptyGates
        self.serviceGates = serviceGates
        super.init(lat: lat, lon: lon, description: "ClujBike \(station)")
    }
}
