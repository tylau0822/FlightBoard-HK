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
    var selectedDate: Date
    
    let category: FlightCategory
    let repository: FlightRepositoryProtocol
    
    init(category: FlightCategory,
         repository: FlightRepositoryProtocol,
         initialDate: Date = Date()) {
        self.category = category
        self.repository = repository
        self.selectedDate = initialDate
    }
    
    func loadFlights() async {
        do {
            flights = try await repository.getFlights(date: selectedDate, category: category)
        } catch {
            print(error.localizedDescription)
        }
    }
}
