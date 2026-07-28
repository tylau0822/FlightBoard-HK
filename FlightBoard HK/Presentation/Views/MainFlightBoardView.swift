//
//  MainFlightBoardView.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 24/7/2026.
//

import SwiftUI

struct MainFlightBoardView: View {
    @EnvironmentObject var boardState: FlightBoardState
    
    @State var selectedTab: FlightCategory = .arrival
    @State var isShowingDatePicker = false
    
    var body: some View {
        ZStack {
            VStack {
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
                
                TabView(selection: $selectedTab) {
                    FlightTabScreen(category: .arrival)
                    .tabItem {
                        Label("Arrival", systemImage: "airplane.arrival")
                    }

                    FlightTabScreen(category: .departure)
                    .tabItem {
                        Label("Departure", systemImage: "airplane.departure")
                    }
                }
            }
        }.sheet(isPresented: $isShowingDatePicker) {
            DatePickerView(selectedDate: $boardState.selectedDate, isPresented: $isShowingDatePicker)
        }
    }
    
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField(selectedTab == .arrival ? "Flight Number / Origin" : "Flight Number / Destination", text: $boardState.searchText)
                .autocorrectionDisabled()
        }.padding(8)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

private struct FlightTabScreen: View {
    let category: FlightCategory
    @EnvironmentObject var boardState: FlightBoardState
    @StateObject private var viewModel: FlightListViewModel
    
    init(category: FlightCategory) {
        self.category = category
        _viewModel = StateObject(wrappedValue: DIContainer.shared.makeFlightListViewModel(category: category))
    }
    
    var body: some View {
        FlightListView(viewModel: viewModel)
            .task {
                await viewModel.loadFlights(date: boardState.selectedDate)
                
                viewModel.searchText = boardState.searchText
            }
            .onChange(of: boardState.searchText) { _, newValue in
                viewModel.searchText = boardState.searchText
            }
            .onChange(of: boardState.selectedDate) { _, newDate in
                Task {
                    await viewModel.loadFlights(date: newDate)
                }
            }
    }
}
