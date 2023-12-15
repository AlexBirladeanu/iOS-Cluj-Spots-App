//
//  MapPin.swift
//
//
//  Created by Alex Bîrlădeanu on 15.12.2023.
//

import SwiftUI

public struct MapPin: View {
    
    let isSelected: Bool
    let imageName: String
    let backgroundColor: Color
    
    public init(isSelected: Bool, imageName: String, backgroundColor: Color) {
        self.isSelected = isSelected
        self.imageName = imageName
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
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
