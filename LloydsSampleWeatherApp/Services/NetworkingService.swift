//
//  NetworkingService.swift
//  LloydsSampleWeatherApp
//
//  Created by Abinash Barooah on 18/12/2024.
//

import Foundation

protocol NetworkingService {
    func fetchData(from url: URL) async throws -> Data
    }

class DefaultNetworkingService: NetworkingService {

    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}
