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
        List(viewModel.flights) { flight in
            FlightRowView(
                flight: flight,
                cityName: viewModel.cityName(
                    for: flight.locationCode?.first ?? "")
            )
        }.listRowSpacing(16)
        .background(Color(.systemGroupedBackground))
        .task {
            await viewModel.loadFlights()
        }
    }
}
