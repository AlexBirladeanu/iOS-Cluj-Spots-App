//
//  GoogleMapsLink.swift
//
//
//  Created by Alex Bîrlădeanu on 15.12.2023.
//

import SwiftUI

public struct GoogleMapsLink: View {
    
    let lat: Double
    let lon: Double
    
    public init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
    public var body: some View {
        if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(lat),\(lon)&directionsmode=driving") {
            Link(destination: url, label: {
                HStack {
                    Image(systemName: "arrowtriangle.up.fill")
                        .foregroundStyle(.white)
                    Text("Start")
                        .foregroundStyle(.white)
                }
                .padding(8)
                .padding(.horizontal, 8)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemBlue))
                )
            })
        }
    }
}
