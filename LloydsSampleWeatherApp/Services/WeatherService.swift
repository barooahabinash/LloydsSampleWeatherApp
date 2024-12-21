//
//  WeatherService.swift
//  LloydsSampleWeatherApp
//
//  Created by Abinash Barooah on 18/12/2024.
//


import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> WeatherResponse
}

class WeatherService: WeatherServiceProtocol {
    private let networkingService: NetworkingService
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "474d308dcc4f2e1608b373f1cdf84004"

    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }

    func fetchWeather(for city: String) async throws -> WeatherResponse {
        guard let url = URL(string: "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric") else {
            throw URLError(.badURL)
        }

        let data: Data = try await networkingService.fetchData(from: url)
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
