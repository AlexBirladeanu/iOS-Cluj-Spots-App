//
//  BottomSheet.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 14.12.2023.
//

import SwiftUI
import CoreLocation
import MapViewComponents

struct WifiSheet: View {
    
    let state: WifiLocationState
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            Text("\(state.name)")
                .font(.title)
            Text("\(state.location)")
                .foregroundStyle(Color(.systemGray))
                .font(.system(size: 20))
            HStack {
                Spacer()
                GoogleMapsLink(lat: state.lat, lon: state.lon)
                Spacer()
            }
            .padding(.top)
        }
        .padding(.horizontal, 32)
    }
}

struct BikeStationSheet: View {
    
    let state: BikeStationState

    var body: some View {
        VStack(
            alignment: .leading
        ) {
            Text("\(state.description)")
                .font(.title)
                .padding(.bottom)
            Group {
                Text("\(state.bikeGates)")
                    .foregroundStyle(state.bikeGates > 0 ? Color(.systemGreen) : Color(.systemRed))
                +
                Text(" bikes out of \(state.bikeGates + state.emptyGates + state.serviceGates) gates")
            }
            Text("\(state.serviceGates) service gates")
                .italic()
                .foregroundStyle(Color(.systemGray))
            HStack {
                Spacer()
                GoogleMapsLink(lat: state.lat, lon: state.lon)
                Spacer()
            }
            .padding(.top)
        }
        .padding(.horizontal, 32)
    }
}

struct ParkingSheet: View {
    
    let state: ParkingState
    
    var body: some View {
        VStack(
            alignment: .center
        ) {
            VStack(
                alignment: .leading
            ) {
                Text("\(state.name)")
                    .font(.title)
                    .padding(.top)
                Text("Last updated at \(state.lastUpdatedAt)")
                    .foregroundStyle(Color(.systemGray))
                    .italic()
                    .padding(.bottom)
                Group {
                    Text("\(state.freeSpots)")
                        .foregroundStyle((Int(state.freeSpots) ?? 0) > 0 ? Color(.systemGreen) : Color(.systemRed))
                    +
                    Text(" available spaces out of \(state.capacity)")
                }
            }
            GoogleMapsLink(lat: state.lat, lon: state.lon)
                .padding(.top)
        }
    }
}
