//
//  SearchListView.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 14.12.2023.
//

import SwiftUI
import MapViewComponents

struct SearchListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var searchText: String
    @Binding var selectedState: UIState?
    let states: [UIState]
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, hasDummyText: false)
                .padding(.horizontal)
                .padding(.top)
            List {
                ForEach(searchText.isEmpty ? states : states.filter{$0.description.lowercased().contains(searchText.lowercased())}) { state in
                    ListRow(text: state.description)
                        .onTapGesture {
                            searchText = state.description
                            selectedState = state
                            dismiss()
                        }
                }
            }
        }
    }
}

struct ListRow: View {
    
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(Color(.systemGray))
                .padding(.trailing, 4)
        }
        .padding(.vertical)
    }
}
