//
//  MainTabView.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import SwiftUI

struct MainTabView: View {

    var body: some View {

        TabView {

            FlightListView(category: .arrival)
            .tabItem {
                Label("Arrival", systemImage: "airplane.arrival")
            }

            FlightListView(category: .departure)
            .tabItem {
                Label("Departure", systemImage: "airplane.departure")
            }
        }
    }
}
