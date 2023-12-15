//
//  Parking.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 12.12.2023.
//

import Foundation

struct ParkingDTO: Decodable {
    let denumire: String
    let lat: String
    let lon: String
    let capacitate: Int
    let locuri_libere: LocuriLibere
    let detalii: ParkingDetails
}

enum LocuriLibere: Decodable {
    case int(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.typeMismatch(LocuriLibere.self, .init(codingPath: decoder.codingPath, debugDescription: "Expected Int or String"))
        }
    }
}

struct ParkingDetails: Decodable {
    
    let actualizare: String
}
