//
//  NetworkingServiceTests.swift
//  LloydsSampleWeatherAppTests
//
//  Created by Abinash Barooah on 21/12/2024.
//  This is for testing the real NetworkingService in case we make changes to it later on

import XCTest
@testable import LloydsSampleWeatherApp

class NetworkingServiceTests: XCTestCase {
    private var weatherService: WeatherService!

    override func setUp() async throws {
        // Use the real NetworkingService for testing
        let networkingService = DefaultNetworkingService()
        weatherService = WeatherService(networkingService: networkingService)
    }

    func testFetchWeatherWithRealNetwork() async throws {
        do {
            let weather = try await weatherService.fetchWeather(for: "London")
            XCTAssertEqual(weather.name, "London")
            XCTAssert(weather.main.temp > -50 && weather.main.temp < 50, "Temperature seems unrealistic.")
        } catch {
            XCTFail("Unexpected error during network call: \(error)")
        }
    }
}
