//
//  SearchBar.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 14.12.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let hasDummyText: Bool
    
    var body: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.trailing, 4)

                if text.isEmpty && hasDummyText {
                    Text("Search")
                        .foregroundStyle(.gray)
                        .padding(.leading, 4)
                }
                TextField(hasDummyText ? "" : "Search", text: $text)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray5))

                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
            .padding(.horizontal, 2)
            .background(Color(.systemGray5))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
        }
}

#Preview {
    SearchBar(text: Binding(get: {
        ""
    }, set: { _ in
        
    }), hasDummyText: false)
}
