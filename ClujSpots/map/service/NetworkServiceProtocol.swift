//
//  NetworkServiceProtocol.swift
//  ClujSpots
//
//  Created by Birladeanu, Alexandru on 26.03.2024.
//

import Combine

protocol NetworkServiceProtocol {
    func getRemoteDataPublisher() -> AnyPublisher<[UIState], Error>
}
