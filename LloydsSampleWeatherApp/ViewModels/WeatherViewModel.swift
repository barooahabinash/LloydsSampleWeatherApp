//
//  WeatherViewModel.swift
//  LloydsSampleWeatherApp
//
//  Created by Abinash Barooah on 18/12/2024.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var errorMessage: String?
    
    private let weatherService: WeatherServiceProtocol


    init(weatherService: WeatherServiceProtocol = WeatherService(networkingService: DefaultNetworkingService())) {
                self.weatherService = weatherService
            }

    func fetchWeather(for city: String) async {
        do {
            errorMessage = nil // Clear previous data
            weather = nil
            weather = try await weatherService.fetchWeather(for: city)
        } catch {
            self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
        }
    }
}
