//
//  WifiLocationMapper.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 15.12.2023.
//

import Foundation

class WifiLocationMapper {
    
    private init() {}
    
    static func dtoToUiState(_ dto: WifiLocationDTO) -> WifiLocationState? {
        guard let latitude = Double(dto.lat), let longitude = Double(dto.lon) else { return nil }
        return WifiLocationState(
            lat: latitude,
            lon: longitude,
            name: dto.SSID,
            location: dto.descriere
        )
    }
    
    static func uiStateToEntity(_ state: WifiLocationState) -> WifiLocationEntity {
        return WifiLocationEntity(
            id: state.id,
            name: state.name,
            location: state.location,
            lat: state.lat,
            lon: state.lon
        )
    }
}
