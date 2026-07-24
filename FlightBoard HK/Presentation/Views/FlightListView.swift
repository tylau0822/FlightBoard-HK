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
    @State var isShowingDatePicker = false
    
    init(category: FlightCategory) {
        let apiService = APIService()
        let flightRepository = FlightRepository(api: apiService)
        let airportRepository = AirportRepository()
        
        self.category = category
        _viewModel = StateObject(
            wrappedValue: FlightListViewModel(category: category, flightRepository: flightRepository, airportRepository: airportRepository)
        )
    }
    
    var body: some View {
        VStack {
            controlsBar
            
            content
        }
        .sheet(isPresented: $isShowingDatePicker) {
            DatePickerView(selectedDate: $viewModel.selectedDate, isPresented: $isShowingDatePicker)
        }
        .task {
            await viewModel.loadFlights()
        }
    }
    
    private var controlsBar: some View {
        HStack {
            searchField
            
            Button {
                isShowingDatePicker = true
            } label: {
                Image(systemName: "calendar")
                    .foregroundStyle(.black.opacity(0.8))
            }
            
        }.padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField(category == .arrival ? "Flight Number / Origin" : "Flight Number / Destination", text: $viewModel.searchText)
                .autocorrectionDisabled()
        }.padding(8)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            Text(DateFormatting.dateString(from: viewModel.selectedDate))
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
