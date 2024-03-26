//
//  MapViewModel.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 13.12.2023.
//

import Foundation
import MapKit
import Combine
import SwiftData

class MapViewModel: ObservableObject, UserLocationDelegate {
    
    @Published var uiStates: [UIState] = []
    @Published var centerRegion = MKCoordinateRegion()
    @Published var userLocation: CLLocation?
    @Published var searchText = ""
    @Published var selectedState: UIState? {
        didSet {
            if let state = selectedState {
                centerRegion = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: state.lat, longitude: state.lon),
                    span: defaultSpan
                )
            } else {
                searchText = ""
            }
        }
    }
    var unfilteredUiStates: [UIState] = []
    var filters: (showParkings: Bool, showBikes: Bool, showWifis: Bool) = (true, true, true)
    let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
    let networkServiceProtocol: NetworkServiceProtocol
    var cancellables = Set<AnyCancellable>()

    init(networkServiceProtocol: NetworkServiceProtocol) {
        self.networkServiceProtocol = networkServiceProtocol
    }
    
    func getRemoteData(onCompletion: @escaping ([UIState]) -> ()) {
        networkServiceProtocol.getRemoteDataPublisher()
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: DispatchQueue.main)
        .sink { _ in} receiveValue: { [weak self] response in
            let currentArray = self?.unfilteredUiStates ?? []
            self?.unfilteredUiStates = currentArray + response
            self?.uiStates = self?.unfilteredUiStates ?? []
            onCompletion(response)
        }
        .store(in: &cancellables)
    }
}

extension MapViewModel {
    
    func toggleBikesFilter() {
        filters.showBikes = !filters.showBikes
        filterList()
    }
    
    func toggleParkingsFilter() {
        filters.showParkings = !filters.showParkings
        filterList()
    }
    
    func toggleWifiFilter() {
        filters.showWifis = !filters.showWifis
        filterList()
    }
    
    private func filterList() {
        var result = [UIState]()
        if filters.showBikes {
            result += unfilteredUiStates.compactMap{ $0 as? BikeStationState }
        }
        if filters.showParkings {
            result += unfilteredUiStates.compactMap{ $0 as? ParkingState }
        }
        if filters.showWifis {
            result += unfilteredUiStates.compactMap{ $0 as? WifiLocationState }
        }
        uiStates = result
    }
}

extension MapViewModel {
    
    func onUserLocationChanged(location: CLLocation) {
        if userLocation == nil {
            centerRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
                span: defaultSpan
            )
        }
        userLocation = location
    }
}

extension MapViewModel {
    
    func checkLocalStorage(_ localWifis: [WifiLocationEntity], _ context: ModelContext) {
        let remoteWifis = unfilteredUiStates.compactMap{ $0 as? WifiLocationState }
        if localWifis.isEmpty && !remoteWifis.isEmpty {
            remoteWifis.map{ WifiLocationMapper.uiStateToEntity($0) }.forEach { model in
                context.insert(model)
            }
        }
    }
}
