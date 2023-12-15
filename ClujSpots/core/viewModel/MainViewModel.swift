//
//  MainViewModel.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 14.12.2023.
//

import Foundation
import Network

class MainViewModel: ObservableObject {
    
    @Published var hasInternetConnection: Bool = true
    private let monitor = NWPathMonitor()

    init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.hasInternetConnection = path.status == .satisfied
            }
        }
        monitor.start(queue: DispatchQueue(label: "NetworkMonitor", qos: .background))
    }
}
