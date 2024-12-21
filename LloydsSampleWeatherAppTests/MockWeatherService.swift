//
//  MockWeatherService.swift
//  LloydsSampleWeatherAppTests
//
//  Created by Abinash Barooah on 18/12/2024.
//

import Foundation
@testable import LloydsSampleWeatherApp

class MockWeatherService: WeatherServiceProtocol {
    var shouldReturnError = false
    var mockWeatherResponse: WeatherResponse?

    func fetchWeather(for city: String) async throws -> WeatherResponse {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        guard let response = mockWeatherResponse else {
            throw URLError(.cannotFindHost)
        }
        return response
    }
}


