//
//  FlightRepository.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

protocol FlightRepositoryProtocol {
    func getFlights() async throws -> [FlightSchedule]
}

class FlightRepository: FlightRepositoryProtocol {
    let api: APIServiceProtocal
    
    init(api: APIServiceProtocal) {
        self.api = api
    }
    
    func getFlights() async throws -> [FlightSchedule] {
        do {
            let data = try await api.fetchFlights()
            return data
        } catch {
            throw error
        }
    }
}
