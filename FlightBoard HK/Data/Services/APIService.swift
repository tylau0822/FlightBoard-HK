//
//  APIService.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import Foundation

protocol APIServiceProtocal {
    func fetchFlights() async throws -> [FlightSchedule]
}

class APIService: APIServiceProtocal {
    let client: APIClientProtocol
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func fetchFlights() async throws -> [FlightSchedule] {
        guard let url = URL(string: "https://www.hongkongairport.com/flightinfo-rest/rest/flights/past?date=2026-07-23&lang=en&cargo=false&arrival=false") else { throw APIError.invalidURL }
        let responses: [FlightResponse] = try await client.get(url: url)
        return responses.flatMap(\.list)
    }
}
