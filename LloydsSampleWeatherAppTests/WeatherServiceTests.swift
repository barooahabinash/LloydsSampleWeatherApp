//
//  WeatherServiceTests.swift
//  LloydsSampleWeatherApp
//
//  Created by Abinash Barooah on 20/12/2024.
//


import XCTest
@testable import LloydsSampleWeatherApp

class WeatherServiceTests: XCTestCase {
    func testFetchWeatherSuccess() async throws {
        // Mock NetworkingService with a successful response
        let mockNetworkingService = MockNetworkingService(result: .success(validWeatherData()))
        let weatherService = WeatherService(networkingService: mockNetworkingService)

        do {
            let weather = try await weatherService.fetchWeather(for: "London")
            XCTAssertEqual(weather.name, "London")
            XCTAssertEqual(weather.main.temp, 15.0)
            XCTAssertEqual(weather.weather.first?.description, "clear sky")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchWeatherFailure() async throws {
        // Mock NetworkingService with a failure response
        let mockNetworkingService = MockNetworkingService(result: .failure(URLError(.badServerResponse)))
        let weatherService = WeatherService(networkingService: mockNetworkingService)

        do {
            _ = try await weatherService.fetchWeather(for: "London")
            XCTFail("Expected error, but got success.")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }

    // Helper for valid WeatherResponse JSON
    private func validWeatherData() -> Data {
        let json = """
        {
            "name": "London",
            "main": { "temp": 15.0 },
            "weather": [ { "description": "clear sky", "icon": "01d" } ]
        }
        """
        return Data(json.utf8)
    }
}

