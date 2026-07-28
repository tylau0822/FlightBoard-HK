//
//  DIContainer.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 24/7/2026.
//

class DIContainer {
    static let shared = DIContainer()
    
    private let apiService: APIServiceProtocal
    private let flightRepository: FlightRepositoryProtocol
    private let airportRepository: AirportRepositoryProtocol
    
    init(apiService: APIServiceProtocal = APIService(),
         airportRepository: AirportRepositoryProtocol = AirportRepository()) {
        self.apiService = apiService
        self.flightRepository = FlightRepository(api: apiService)
        self.airportRepository = airportRepository
    }
    
    func makeFlightListViewModel(category: FlightCategory) -> FlightListViewModel {
        FlightListViewModel(
            category: category,
            flightRepository: flightRepository,
            airportRepository: airportRepository
        )
    }
}
