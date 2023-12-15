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
    var cancellables = Set<AnyCancellable>()
    let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
    
    enum Url: String {
        case parkings = "https://data.e-primariaclujnapoca.ro/sitpark.json"
        case wifis = "https://data.gov.ro/dataset/fbeab450-4092-40c7-b0ef-ce0222e6c17b/resource/3cd79e1f-6b75-4b6f-bf32-903e2b6fad51/download/wifi_cluj.json"
        case bikes = "https://data.e-primariaclujnapoca.ro/bike/statii.php"
    }

    init() {
        getRemoteData()
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
    
    private func getRemoteData() {
        let parkingsPublisher = fetchData(from: Url.parkings.rawValue, responseType: [ParkingDTO].self)
            .map { dtoArray in
                dtoArray.map{ParkingMapper.dtoToUiState($0)}.compactMap{$0} as [UIState]
            }
        let wifisPublisher = fetchData(from: Url.wifis.rawValue, responseType: [WifiLocationDTO].self)
            .map { dtoArray in
                dtoArray.map{WifiLocationMapper.dtoToUiState($0)}.compactMap{$0} as [UIState]
            }
//        let bikesPublisher = fetchData(from: Url.bikes.rawValue, responseType: [BikeStationDTO].self)
//            .map { dtoArray in
//                dtoArray.map{BikeStationMapper.dtoToUiState($0)}.compactMap{$0} as [UIState]
//            }
        Publishers.Merge(wifisPublisher, parkingsPublisher)
//            .merge(with: bikesPublisher)
            .receive(on: DispatchQueue.main)
            .sink { _ in} receiveValue: { [weak self] response in
                let currentArray = self?.unfilteredUiStates ?? []
                self?.unfilteredUiStates = currentArray + response
                self?.uiStates = self?.unfilteredUiStates ?? []
            }
            .store(in: &cancellables)
    }
    
    private func fetchData<T>(from url: String, responseType: T.Type) -> AnyPublisher<T, Error> where T: Decodable {
            guard let url = URL(string: url) else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }

            return URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .map(\.data)
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
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
