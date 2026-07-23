//
//  APIClient.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 23/7/2026.
//

import Foundation

public enum APIError: Error, Equatable {
    case invalidURL
    case transport(String)
    case decoding(String)
    case server(statusCode: Int)
}

/// Thin abstraction over networking so it can be mocked in tests and swapped
/// (e.g. for a caching or logging decorator) without touching call sites.
public protocol APIClientProtocol: Sendable {
    func get<T: Decodable>(url: URL) async throws -> T
}

public final class APIClient: APIClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    public init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    public func get<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await performRequest(url: url)

        if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            throw APIError.server(statusCode: http.statusCode)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decoding(error.localizedDescription)
        }
    }

    private func performRequest(url: URL) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(from: url)
        } catch {
            throw APIError.transport(error.localizedDescription)
        }
    }
}
