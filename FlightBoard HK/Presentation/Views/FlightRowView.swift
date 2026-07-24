//
//  FlightRowView.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 24/7/2026.
//

import SwiftUI

struct FlightRowView: View {
    let flight: FlightSchedule
    let cityName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 4) {
                AsyncImage(url: flight.logoURL) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFit()
                    }
                }
                .frame(width: 24, height: 24)
                
                Text(flight.primaryFlightNumber)
                    .font(.headline)
                    .fontWeight(.bold)
                
                if flight.codeshareCount > 0 {
                    Text("+ \(flight.codeshareCount) codeshares")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(.gray.opacity(0.15))
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                FlightStatusBadge(status: flight.status)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(flight.primaryLocationCode)
                        .font(.system(size: 24, weight: .bold))
                    
                    Text(cityName)
                        .foregroundStyle(.secondary)
                }

                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(flight.scheduledTime)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text("Scheduled")
                        .foregroundStyle(.secondary)
                }
            }
            
            HStack(spacing: 12) {
                if flight.type == .arrival {
                    InfoChip(
                        title: "Parking Stand",
                        value: flight.stand ?? "-"
                    )

                    InfoChip(
                        title: "Hall",
                        value: flight.hall ?? "-"
                    )
                    
                    InfoChip(
                        title: "Belt",
                        value: flight.baggage ?? "-"
                    )
                } else {
                    InfoChip(
                        title: "Gate",
                        value: flight.gate ?? "-"
                    )

                    InfoChip(
                        title: "Terminal",
                        value: flight.terminal?.isEmpty == false
                        ? flight.terminal!
                        : "-"
                    )
                    
                    InfoChip(
                        title: "Check-in",
                        value: flight.checkInAisle ?? "-"
                    )
                }
                               
                Spacer()
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
}

struct InfoChip: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)

            Text(value)
                .fontWeight(.semibold)
        }
        .padding(8)
        .background(.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
