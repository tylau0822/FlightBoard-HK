//
//  Airport.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 24/7/2026.
//

struct Airport: Codable {
    let icao: String
    let iata: String?
    let name: String
    let city: String
    let state: String
    let country: String
    let elevation: Int
    let lat: Double
    let lon: Double
    let tz: String
}
