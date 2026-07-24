//
//  APIService.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import Foundation

protocol APIServiceProtocal {
    func fetchDepartureFlights(date: Date, category: FlightCategory) async throws -> [DepartureFlightSchedule]
    func fetchArrialFlights(date: Date, category: FlightCategory) async throws -> [ArrivalFlightSchedule]
}

class APIService: APIServiceProtocal {
    let client: APIClientProtocol
    let baseURL: URL
    
    init(client: APIClientProtocol = APIClient(), baseURL: URL = URL(string: "https://www.hongkongairport.com/flightinfo-rest/rest/flights/past")!) {
        self.client = client
        self.baseURL = baseURL
    }
    
    func fetchDepartureFlights(date: Date, category: FlightCategory) async throws -> [DepartureFlightSchedule] {
        let url = try buildURL(date: date, category: category)
        let responses: [DepartureFlightResponse] = try await client.get(url: url)
        return responses.flatMap(\.list)
    }
    
    func fetchArrialFlights(date: Date, category: FlightCategory) async throws -> [ArrivalFlightSchedule] {
        let url = try buildURL(date: date, category: category)
        let responses: [ArrivalFlightResponse] = try await client.get(url: url)
        return responses.flatMap(\.list)
    }
    
    private func buildURL(date: Date, category: FlightCategory) throws -> URL {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }

        components.queryItems = [
            URLQueryItem(name: "date", value: DateFormatting.dateString(from: date)),
            URLQueryItem(name: "lang", value: "en"),
            URLQueryItem(name: "cargo", value: "false"),
            URLQueryItem(name: "arrival", value: category == .arrival ? "true" : "false")
        ]
        
        guard let url = components.url else { throw APIError.invalidURL }
        return url
    }
}
