//
//  FlightListView.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import SwiftUI

struct FlightListView: View {
    @EnvironmentObject var boardState: FlightBoardState
    @ObservedObject var viewModel: FlightListViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(DateFormatting.dateString(from: boardState.selectedDate))
                .font(.headline)
                .padding()
            
            List {
                ForEach(viewModel.visibleFlights) { flight in
                    FlightRowView(
                        flight: flight,
                        cityName: viewModel.cityName(
                            for: flight.locationCode?.first ?? "")
                    )
                }
            }
            .contentMargins(.top, 0)
            .listRowSpacing(16)
        }.background(Color(.systemGroupedBackground))
    }
}
