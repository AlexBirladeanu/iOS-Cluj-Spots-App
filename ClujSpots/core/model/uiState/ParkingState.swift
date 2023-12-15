//
//  ParkingState.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 12.12.2023.
//

import Foundation

class ParkingState: UIState {
    
    let name: String
    let capacity: Int
    let freeSpots: String
    let lastUpdatedAt: String
    
    init(lat: Double, lon: Double, name: String, capacity: Int, freeSpots: String, lastUpdatedAt: String) {
        self.name = name
        self.capacity = capacity
        self.freeSpots = freeSpots
        self.lastUpdatedAt = lastUpdatedAt
        super.init(lat: lat, lon: lon, description: name)
    }
}
