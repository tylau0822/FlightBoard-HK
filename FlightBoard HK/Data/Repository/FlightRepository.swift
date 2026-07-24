//
//  FlightRepository.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import Foundation

protocol FlightRepositoryProtocol {
    func getFlights(date: Date, category: FlightCategory) async throws -> [FlightSchedule]
}

class FlightRepository: FlightRepositoryProtocol {
    let api: APIServiceProtocal
    
    init(api: APIServiceProtocal) {
        self.api = api
    }
    
    func getFlights(date: Date, category: FlightCategory) async throws -> [FlightSchedule] {
        switch category {
        case .arrival:
            let arrvals = try await api.fetchArrialFlights(date: date, category: category)
            return arrvals.map { $0.toDomain() }
        case .departure:
            let departures = try await api.fetchDepartureFlights(date: date, category: category)
            return departures.map { $0.toDomain() }
        }
    }
}
