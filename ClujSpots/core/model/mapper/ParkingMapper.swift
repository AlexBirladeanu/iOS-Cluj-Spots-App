//
//  ParkingMapper.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 15.12.2023.
//

import Foundation

class ParkingMapper {
    
    private init() {}
    
    static func dtoToUiState (_ dto: ParkingDTO) -> ParkingState? {
        guard
            let latitude = Double(dto.lat),
            let longitude = Double(dto.lon)
        else { return nil }
        let freeSpotsString = switch dto.locuri_libere {
            case .int(let value):
                "\(value)"
            default:
                "Unknown"
        }
        return ParkingState(
            lat: latitude,
            lon: longitude,
            name: dto.denumire,
            capacity: dto.capacitate,
            freeSpots: freeSpotsString,
            lastUpdatedAt: dto.detalii.actualizare
        )
    }
}
