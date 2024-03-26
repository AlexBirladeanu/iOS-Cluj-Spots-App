//
//  NetworkService.swift
//  ClujSpots
//
//  Created by Birladeanu, Alexandru on 26.03.2024.
//

import Foundation
import Combine

struct NetworkService: NetworkServiceProtocol {
    
    enum Url: String {
        case parkings = "https://data.e-primariaclujnapoca.ro/sitpark.json"
        case wifis = "https://data.gov.ro/dataset/fbeab450-4092-40c7-b0ef-ce0222e6c17b/resource/3cd79e1f-6b75-4b6f-bf32-903e2b6fad51/download/wifi_cluj.json"
        case bikes = "https://data.e-primariaclujnapoca.ro/bike/statii.php"
    }

    func getRemoteDataPublisher() -> AnyPublisher<[UIState], Error> {
        let parkingsPublisher = performNetworkRequest(from: Url.parkings.rawValue, responseType: [ParkingDTO].self)
            .map { dtoArray in
                dtoArray.map{ParkingMapper.dtoToUiState($0)}.compactMap{$0} as [UIState]
            }
        let wifisPublisher = performNetworkRequest(from: Url.wifis.rawValue, responseType: [WifiLocationDTO].self)
            .map { dtoArray in
                dtoArray.map{WifiLocationMapper.dtoToUiState($0)}.compactMap{$0} as [UIState]
            }
        let bikesPublisher = performNetworkRequest(from: Url.bikes.rawValue, responseType: [BikeStationDTO].self)
            .map { dtoArray in
                dtoArray.map{BikeStationMapper.dtoToUiState($0)}.compactMap{$0} as [UIState]
            }
        return Publishers.Merge(wifisPublisher, parkingsPublisher)
            .merge(with: bikesPublisher)
            .eraseToAnyPublisher()
    }
    
    private func performNetworkRequest<T>(from url: String, responseType: T.Type) -> AnyPublisher<T, Error> where T: Decodable {
        guard let url = URL(string: url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
