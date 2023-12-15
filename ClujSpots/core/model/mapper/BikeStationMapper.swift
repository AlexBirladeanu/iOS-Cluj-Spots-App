//
//  BikeStationMapper.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 15.12.2023.
//

import Foundation

class BikeStationMapper {
    
    private init() {}
    
    static func dtoToUiState(_ dto: BikeStationDTO) -> BikeStationState? {
        guard
            let latitude = Double(dto.latitude ?? ""),
            let longitude = Double(dto.longitude ?? ""),
            let station = dto.station,
            let isActive = dto.isActive,
            let bikeGates = Int(dto.bikeGates ?? ""),
            let emptyGates = Int(dto.emptyGates ?? ""),
            let serviceGates = Int(dto.serviceGates ?? "")
        else { return nil }
        
        let state = BikeStationState(
            lat: latitude,
            lon: longitude,
            station: station,
            isActive: isActive == "1" ? true : false,
            bikeGates: bikeGates,
            emptyGates: emptyGates,
            serviceGates: serviceGates
        )
        return state
    }
}
