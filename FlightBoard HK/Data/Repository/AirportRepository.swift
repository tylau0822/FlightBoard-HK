//
//  AirportManager.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 24/7/2026.
//

import Foundation

protocol AirportRepositoryProtocol {
    func city(for iata: String) -> String
}

class AirportRepository: AirportRepositoryProtocol {
    private var airports: [String: Airport] = [:]
    
    init() {
        loadAirports()
    }
    
    func city(for iata: String) -> String {
        let code = iata.uppercased().trimmingCharacters(in: .whitespaces)
        return airports[code]?.city ?? code
    }
    
    private func loadAirports() {
        guard let url = Bundle.main.url(forResource: "airports", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            let decoded = try JSONDecoder().decode([String: Airport].self, from: data)
            
            for (_, airport) in decoded {
                if let iata = airport.iata, !iata.isEmpty {
                    self.airports[iata.uppercased()] = airport
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
