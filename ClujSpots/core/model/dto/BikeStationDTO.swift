//
//  BikeStation.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 12.12.2023.
//

import Foundation

struct BikeStationDTO: Decodable {
    
    let station: String?
    let latitude: String?
    let longitude: String?
    let isActive: String?
    let bikeGates: String?
    let emptyGates: String?
    let serviceGates: String?

    enum CodingKeys: String, CodingKey {
        case station        = "Statie"
        case latitude       = "Latitude"
        case longitude      = "Longitude"
        case isActive       = "IsActive"
        case bikeGates      = "Nr porti cu bicicleta"
        case emptyGates     = "Nr porti fara bicicleta"
        case serviceGates   = "Nr porti service"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        station         = try values.decodeIfPresent(String.self, forKey: .station)
        latitude        = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude       = try values.decodeIfPresent(String.self, forKey: .longitude)
        isActive        = try values.decodeIfPresent(String.self, forKey: .isActive)
        bikeGates       = try values.decodeIfPresent(String.self, forKey: .bikeGates)
        emptyGates      = try values.decodeIfPresent(String.self, forKey: .emptyGates)
        serviceGates    = try values.decodeIfPresent(String.self, forKey: .serviceGates)
    }
}
