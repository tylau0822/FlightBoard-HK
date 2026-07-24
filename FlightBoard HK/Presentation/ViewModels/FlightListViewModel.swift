//
//  FlightListViewModel.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import Foundation
import Combine

class FlightListViewModel: ObservableObject {
    @Published var flights: [FlightSchedule] = []
    var selectedDate: Date
    
    let category: FlightCategory
    let flightRepository: FlightRepositoryProtocol
    let airportRepository: AirportRepositoryProtocol
    
    init(category: FlightCategory,
         flightRepository: FlightRepositoryProtocol,
         airportRepository: AirportRepositoryProtocol,
         initialDate: Date = Date()) {
        self.category = category
        self.flightRepository = flightRepository
        self.airportRepository = airportRepository
        self.selectedDate = initialDate
    }
    
    func loadFlights() async {
        do {
            flights = try await flightRepository.getFlights(date: selectedDate, category: category)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func cityName(for code: String) -> String {
        airportRepository.city(for: code)
    }
}
