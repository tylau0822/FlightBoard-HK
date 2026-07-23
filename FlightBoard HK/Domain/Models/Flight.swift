//
//  Flight.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import Foundation

struct FlightSchedule: Identifiable {
    let id = UUID()
    
    let scheduledTime: String
    let flights: [Flight]
    let status: String
    let statusCode: String?
    
    let destinations: [String]
    
    let terminal: String?
    let checkInAisle: String?
    let gate: String?
    
    enum CodingKeys: String, CodingKey {
        case scheduledTime = "time"
        case flights = "flight"
        case status
        case statusCode
        case destinations = "destination"
        case terminal
        case checkInAisle = "aisle"
        case gate
    }
}

struct Flight: Hashable {
    let flightNumber: String
    let airlineCode: String
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "no"
        case airlineCode = "airline"
    }
}
