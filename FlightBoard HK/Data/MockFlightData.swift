//
//  MockFlightData.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

struct MockFlightData {
    static let flights: [FlightSchedule] = [
        FlightSchedule(
            scheduledTime: "00:05",
            flights: [
                Flight(
                    flightNumber: "ZE 862",
                    airlineCode: "ESR"
                )
            ],
            status: "Dep 00:51",
            statusCode: nil,
            destinations: ["ICN"],
            terminal: "T1",
            checkInAisle: "J",
            gate: "20"
        ),
        FlightSchedule(
            scheduledTime: "00:45",
            flights: [
                Flight(
                    flightNumber: "CX 181",
                    airlineCode: "CPA"
                ),
                Flight(
                    flightNumber: "AY 5093",
                    airlineCode: "FIN"
                ),
                Flight(
                    flightNumber: "OM 5627",
                    airlineCode: "MGL"
                ),
                Flight(
                    flightNumber: "BA 4131",
                    airlineCode: "BAW"
                )
            ],
            status: "Dep 00:46",
            statusCode: nil,
            destinations: ["SYD"],
            terminal: "T1",
            checkInAisle: "A",
            gate: "65"
        )
    ]
}
