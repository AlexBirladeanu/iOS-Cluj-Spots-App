//
//  ClujSpotsApp.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 11.12.2023.
//

import SwiftUI
import SwiftData

@main
struct ClujSpotsApp: App {
    
    @StateObject var vm = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            let locationManager = LocationManager()
            let mapVM = MapViewModel(networkServiceProtocol: NetworkService())
            if vm.hasInternetConnection {
                MapView(vm: mapVM)
                    .onAppear {
                        locationManager.setDelegate(mapVM)
                    }
            } else {
                OfflineView()
            }
        }
        .modelContainer(for: WifiLocationEntity.self)
    }
}
