//
//  FlightBoardState.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 24/7/2026.
//

import Foundation
import Combine

@MainActor
class FlightBoardState: ObservableObject {
    @Published var searchText = ""
    @Published var selectedDate = Date()
}
