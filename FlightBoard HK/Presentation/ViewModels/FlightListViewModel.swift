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
    
    let repository: FlightRepositoryProtocol
    
    init(repository: FlightRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadFlights() async {
        do {
            flights = try await repository.getFlights()
        } catch {
            print(error.localizedDescription)
        }
    }
}
