//
//  WifiLocation.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 12.12.2023.
//

import Foundation

struct WifiLocationDTO: Decodable {
    let SSID: String
    let descriere: String
    let lat: String
    let lon: String
}
