//
//  FlightListViewModel.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import Combine

class FlightListViewModel: ObservableObject {
    @Published var flights: [FlightSchedule] = []
    
    init() {
        loadMockData()
    }
    
    func loadMockData() {
        flights = MockFlightData.flights
    }
}
