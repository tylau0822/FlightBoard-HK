//
//  FlightListViewModel.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import Foundation
import Combine

class FlightListViewModel: ObservableObject {
    @Published var visibleFlights: [FlightSchedule] = []
    
    @Published var searchText: String = "" {
        didSet { filterFlights() }
    }
    
    var selectedDate: Date
    
    let category: FlightCategory
    let flightRepository: FlightRepositoryProtocol
    let airportRepository: AirportRepositoryProtocol
    
    private var allFlights: [FlightSchedule] = []
    
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
            allFlights = try await flightRepository.getFlights(date: selectedDate, category: category)
            filterFlights()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func filterFlights() {
        var result = allFlights
        
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let trimmedNoSpaces = trimmed.replacingOccurrences(of: " ", with: "")
        
        if !trimmed.isEmpty {
            result = result.filter { flight in
                let flightNumberMatches = flight.airlines.contains { airline in
                    let flightNumber = airline.flightNumber.lowercased()
                    let flightNumberNoSpaces = flightNumber.replacingOccurrences(of: " ", with: "")
                    return flightNumber.contains(trimmed) || flightNumberNoSpaces.contains(trimmedNoSpaces)
                }
                
                let locationMatches = flight.locationCode?.contains { location in
                    let code = location.lowercased()
                    let cityName = cityName(for: location).lowercased()
                    return code.contains(trimmed) || cityName.contains(trimmed)
                } ?? false
                
                return flightNumberMatches || locationMatches
            }
        }
        
        visibleFlights = result
    }
    
    func cityName(for code: String) -> String {
        airportRepository.city(for: code)
    }
}
