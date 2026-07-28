//
//  FlightBoard_HKApp.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import SwiftUI
import SwiftData

@main
struct FlightBoard_HKApp: App {
    @StateObject private var state = FlightBoardState()
    
    var body: some Scene {
        WindowGroup {
            MainFlightBoardView()
                .environmentObject(state)
        }
    }
}
