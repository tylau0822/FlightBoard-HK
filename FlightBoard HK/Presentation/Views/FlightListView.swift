//
//  FlightListView.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import SwiftUI

struct FlightListView: View {
    @StateObject var viewModel = FlightListViewModel()
    
    var body: some View {
        List(viewModel.flights) { flight in
            VStack {
                HStack {
                    Text(flight.scheduledTime)
                    ForEach(flight.destinations, id: \.self) { destination in
                        Text(destination)
                    }
                    
                    Spacer()
                    Text(flight.status)
                }
                
                Divider()
                
                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading) {
                        ForEach(flight.flights, id: \.self) { airline in
                            Text(airline.flightNumber)
                        }
                    }.frame(width: 100, alignment: .leading)
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("TERMINAL")
                            Spacer()
                            Text(flight.terminal ?? "-")
                        }
                        
                        HStack {
                            Text("CHECK-IN")
                            Spacer()
                            Text(flight.checkInAisle ?? "-")
                        }
                        
                        HStack {
                            Text("GATE")
                            Spacer()
                            Text(flight.gate ?? "-")
                        }
                    }
                }
            }
        }.listRowSpacing(16)
    }
}

#Preview {
    FlightListView()
}
