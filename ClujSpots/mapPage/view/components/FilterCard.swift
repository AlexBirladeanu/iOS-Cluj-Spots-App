//
//  FilterCard.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 15.12.2023.
//

import SwiftUI

struct FilterCard: View {
    
    let imageName: String
    let text: String
    let isSelected: Bool
    let onTap: () -> ()
    
    var body: some View {
        
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.white)
                .padding(.leading)
            Text(text)
                .padding(.leading, 2)
                .padding(.trailing)
        }
        .padding(.vertical, 4)
        .background(isSelected ? Color(.systemBlue) : Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
        .onTapGesture {
            onTap()
        }
    }
}
