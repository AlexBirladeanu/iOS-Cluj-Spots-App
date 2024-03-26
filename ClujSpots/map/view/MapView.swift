//
//  ContentView.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 11.12.2023.
//

import SwiftUI
import MapKit
import SwiftData
import MapViewComponents

struct MapView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \WifiLocationEntity.location) var localWifis: [WifiLocationEntity]
    @ObservedObject var vm: MapViewModel
    @State var userTrackingMode = MapUserTrackingMode.follow
    
    init(vm: MapViewModel) {
        self.vm = vm
        vm.getRemoteData { _ in }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                mapLayer
                VStack(alignment: .center) {
                    NavigationLink {
                        SearchListView(
                            searchText: $vm.searchText,
                            selectedState: $vm.selectedState,
                            states: vm.uiStates
                        )
                    } label: {
                        SearchBar(text: $vm.searchText, hasDummyText: true)
                            .padding(.top, 40)
                            .padding(.horizontal)
                    }
                    filters
                        .padding(.horizontal)
                        .padding(.top, 4)
                    Spacer()
                }
                .padding(.top)
            }
            .sheet(isPresented: Binding(get: { vm.selectedState != nil }, set: { _ in}), onDismiss: {
                vm.selectedState = nil
            },content: {
                switch vm.selectedState {
                case is WifiLocationState:
                    WifiSheet(state: vm.selectedState as! WifiLocationState)
                        .presentationDetents([.fraction(0.3)])
                        .presentationDragIndicator(.visible)
                        .presentationBackgroundInteraction(.enabled)
                        .presentationBackground(.ultraThinMaterial)
                case is ParkingState:
                    ParkingSheet(state: vm.selectedState as! ParkingState)
                        .presentationDetents([.fraction(0.3)])
                        .presentationDragIndicator(.visible)
                        .presentationBackgroundInteraction(.enabled)
                        .presentationBackground(.ultraThinMaterial)
                default:
                    BikeStationSheet(state: vm.selectedState as! BikeStationState)
                        .presentationDetents([.fraction(0.3)])
                        .presentationDragIndicator(.visible)
                        .presentationBackgroundInteraction(.enabled)
                        .presentationBackground(.ultraThinMaterial)
                }
            })
            .ignoresSafeArea()
        }
        .onChange(of: vm.uiStates) { _, _ in
            vm.checkLocalStorage(localWifis, context)
        }
    }
}

extension MapView {
    
    private var mapLayer: some View {
        withAnimation(.easeInOut) {
            Map(
                coordinateRegion: $vm.centerRegion,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode,
                annotationItems: vm.uiStates) { uiState in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: uiState.lat, longitude: uiState.lon)) {
                        let pinImage = switch uiState {
                        case is WifiLocationState:
                            "wifi"
                        case is BikeStationState:
                            "bicycle"
                        default:
                            "car.side"
                        }
                        let pinColor = switch uiState {
                        case is WifiLocationState:
                            Color(uiColor: .systemBlue)
                        case is BikeStationState:
                            Color(uiColor: .systemGreen)
                        default:
                            Color(uiColor: .systemOrange)
                        }
                        MapPin(
                            isSelected: vm.selectedState == uiState,
                            imageName: pinImage,
                            backgroundColor: pinColor)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                if (vm.selectedState == uiState) {
                                    vm.selectedState = nil
                                } else {
                                    vm.selectedState = uiState
                                }
                            }
                        }
                    }
                }
        }
    }
}

extension MapView {
    
    var filters: some View {
        HStack(alignment: .top, spacing: 8) {
            FilterCard(
                imageName: "bicycle",
                text: "Bikes",
                isSelected: vm.filters.showBikes,
                onTap: vm.toggleBikesFilter
            )
            FilterCard(
                imageName: "car.side",
                text: "Cars",
                isSelected: vm.filters.showParkings,
                onTap: vm.toggleParkingsFilter
            )
            FilterCard(
                imageName: "wifi",
                text: "Wifi",
                isSelected: vm.filters.showWifis,
                onTap: vm.toggleWifiFilter
            )
        }
    }
}

#Preview {
    MapView(vm: MapViewModel(networkServiceProtocol: NetworkService()))
}
