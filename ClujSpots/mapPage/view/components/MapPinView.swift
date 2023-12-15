//
//  MapPinView.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 13.12.2023.
//

import SwiftUI

struct MapPinView: View {
    @Binding var isSelected: Bool
    
    let uiState: UIState
    var imageName: String {
        switch uiState {
        case is WifiLocationState:
            "wifi"
        case is BikeStationState:
            "bicycle"
        default:
            "car.side"
        }
    }
    var backgroundColor: Color {
        switch uiState {
        case is WifiLocationState:
            Color(uiColor: .systemBlue)
        case is BikeStationState:
            Color(uiColor: .systemGreen)
        default:
            Color(uiColor: .systemOrange)
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(isSelected ? Color(uiColor: .systemRed) : backgroundColor)
                .cornerRadius(36)
            Image(systemName: "triangle.fill")
                .foregroundStyle(isSelected ? Color(uiColor: .systemRed) : backgroundColor)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -6)
                .padding(.bottom, 30)
        }
        .scaleEffect(isSelected ? 1.5 : 1)
        .shadow(radius: 10)
    }
}

#Preview {
    MapPinView(isSelected: Binding(get: {
        false
    }, set: { newValue in
        
    }), uiState: UIState(lat: 1.0, lon: 2.0, description: "ClujBike"))
}
