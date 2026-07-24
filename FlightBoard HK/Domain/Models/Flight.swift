//
//  Flight.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import Foundation

struct DepartureFlightResponse: Codable {
    let date: String
    let arrival: Bool
    let cargo: Bool
    let list: [DepartureFlightSchedule]
}

struct ArrivalFlightResponse: Codable {
    let date: String
    let arrival: Bool
    let cargo: Bool
    let list: [ArrivalFlightSchedule]
}

struct FlightSchedule: Identifiable, Hashable {
    let id = UUID()
    
    let scheduledTime: String
    let flights: [Flight]
    let status: String
    let statusCode: String?
    
    let locationCode: [String]?
    
    let terminal: String?
    let checkInAisle: String?
    let gate: String?
    
    let baggage: String?
    let hall: String?
    let stand: String?
    
    let type: FlightCategory
}

struct Flight: Hashable, Codable {
    let flightNumber: String
    let airlineCode: String
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "no"
        case airlineCode = "airline"
    }
}

struct DepartureFlightSchedule: Codable {
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

struct ArrivalFlightSchedule: Codable {
    let scheduledTime: String
    let flights: [Flight]
    let status: String
    let statusCode: String?

    let origins: [String]

    let baggage: String?
    let hall: String?
    let terminal: String?
    let stand: String?
    
    enum CodingKeys: String, CodingKey {
        case scheduledTime = "time"
        case flights = "flight"
        case status
        case statusCode
        case origins = "origin"
        case baggage
        case hall
        case terminal
        case stand
    }
}

extension DepartureFlightSchedule {
    func toDomain() -> FlightSchedule {
        FlightSchedule(
            scheduledTime: scheduledTime,
            flights: flights,
            status: status,
            statusCode: statusCode,
            locationCode: destinations,
            terminal: terminal,
            checkInAisle: checkInAisle,
            gate: gate,
            baggage: nil,
            hall: nil,
            stand: nil,
            type: .departure
        )
    }
}

extension ArrivalFlightSchedule {
    func toDomain() -> FlightSchedule {
        FlightSchedule(
            scheduledTime: scheduledTime,
            flights: flights,
            status: status,
            statusCode: statusCode,
            locationCode: origins,
            terminal: terminal,
            checkInAisle: nil,
            gate: nil,
            baggage: baggage,
            hall: hall,
            stand: stand,
            type: .arrival
        )
    }
}
