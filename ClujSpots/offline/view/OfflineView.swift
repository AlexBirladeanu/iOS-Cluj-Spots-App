//
//  OfflineView.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 15.12.2023.
//

import SwiftUI
import SwiftData

struct OfflineView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \WifiLocationEntity.location) var localWifis: [WifiLocationEntity]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(localWifis) { model in
                        VStack(alignment: .leading) {
                            Text(model.location)
                                .font(.system(size: 18))
                            Text(model.name)
                                .foregroundStyle(Color(.systemGray))
                        }
                    }
                } header: {
                    Text("Oops, it seems you are offline. Here are some free WiFi spots you can check out!")
                        .textCase(nil)
                        .font(.system(size: 24))
                        .foregroundStyle(Color(.systemGray))
                        .padding(.bottom)
                }
            }
            .navigationTitle("No connection")
        }
    }
}

#Preview {
    OfflineView()
}
