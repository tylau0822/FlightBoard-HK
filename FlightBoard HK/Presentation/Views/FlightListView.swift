//
//  FlightListView.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import SwiftUI

struct FlightListView: View {
    let category: FlightCategory
    @StateObject var viewModel: FlightListViewModel
    
    init(category: FlightCategory) {
        let apiService = APIService()
        let flightRepository = FlightRepository(api: apiService)
        let airportRepository = AirportRepository()
        
        self.category = category
        _viewModel = StateObject(
            wrappedValue: FlightListViewModel(category: category, flightRepository: flightRepository, airportRepository: airportRepository)
        )
    }
    
    var body: some View {
        VStack {
            controlsBar
            
            content
        }
        .task {
            await viewModel.loadFlights()
        }
    }
    
    private var controlsBar: some View {
        HStack {
            searchField
        }.padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField(category == .arrival ? "Flight Number / Origin" : "Flight Number / Destination", text: $viewModel.searchText)
                .autocorrectionDisabled()
        }.padding(8)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var content: some View {
        List {
            ForEach(viewModel.visibleFlights) { flight in
                FlightRowView(
                    flight: flight,
                    cityName: viewModel.cityName(
                        for: flight.locationCode?.first ?? "")
                )
            }
        }
        .listRowSpacing(16)
        .background(Color(.systemGroupedBackground))
    }
}
