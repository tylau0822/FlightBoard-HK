//
//  FlightListView.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import SwiftUI

struct FlightListView: View {
    let category: FlightCategory
    @StateObject var viewModel: FlightListViewModel
    
    init(category: FlightCategory) {
        let apiService = APIService()
        let repository = FlightRepository(api: apiService)
        
        self.category = category
        _viewModel = StateObject(
            wrappedValue: FlightListViewModel(category: category, repository: repository)
        )
    }
    
    var body: some View {
        List(viewModel.flights) { flight in
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("FLIGHT")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12))

                    ForEach(flight.flights, id: \.self) { airline in
                        Text(airline.flightNumber)
                    }
                }.frame(width: 100, alignment: .leading)
                
                
                Divider()
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("TIME")
                                .foregroundStyle(.gray)
                                .font(.system(size: 12))
                            Text(flight.scheduledTime)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(
                                flight.type == .arrival
                                ? "ORIGIN"
                                : "DESTINATION"
                            )
                                .foregroundStyle(.gray)
                                .font(.system(size: 12))
                            ForEach(flight.locationCode ?? [], id: \.self) { destination in
                                Text(destination)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("STATUS")
                            .foregroundStyle(.gray)
                            .font(.system(size: 12))
                        Text(flight.status)
                    }
                    Spacer()
                }
            }
        }.listRowSpacing(16)
        .task {
            await viewModel.loadFlights()
        }
    }
}
