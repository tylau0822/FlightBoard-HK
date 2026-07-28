//
//  FlightStatusBadge.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 24/7/2026.
//

import SwiftUI

struct FlightStatusBadge: View {

    let status: String

    var body: some View {
        Text(status)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(statusColor.opacity(0.15))
            .foregroundStyle(statusColor)
            .clipShape(Capsule())
    }

    private var statusColor: Color {
        if status.contains("Delayed") {
            return .orange
        }

        if status.contains("Cancelled") {
            return .red
        }
        
        return !status.isEmpty ? .green : .white
    }
}
