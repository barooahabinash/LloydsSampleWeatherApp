//
//  WeatherViewModelTests.swift
//  LloydsSampleWeatherAppTests
//
//  Created by Abinash Barooah on 21/12/2024.
//

import XCTest
@testable import LloydsSampleWeatherApp

final class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var mockWeatherService: MockWeatherService!

    @MainActor override func setUp() {
        super.setUp()
        mockWeatherService = MockWeatherService()
        viewModel = WeatherViewModel(weatherService: mockWeatherService)
    }

    override func tearDown() {
        viewModel = nil
        mockWeatherService = nil
        super.tearDown()
    }

    func testFetchWeatherSuccess() async {
        let mockWeather = WeatherResponse(
            name: "San Francisco",
            main: Main(temp: 22.0),
            weather: [Weather(description: "Clear sky", icon: "01d")]
        )
        mockWeatherService.mockWeatherResponse = mockWeather

        await viewModel.fetchWeather(for: "San Francisco")

        // Assert: Validate the fetched weather
        await MainActor.run {
            XCTAssertNotNil(viewModel.weather)
            XCTAssertEqual(viewModel.weather?.name, "San Francisco")
            XCTAssertNil(viewModel.errorMessage)
        }
    }

    func testFetchWeatherFailure() async {
        mockWeatherService.shouldReturnError = true

        await viewModel.fetchWeather(for: "InvalidCity")

        await MainActor.run {
            XCTAssertNil(viewModel.weather)
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertEqual(viewModel.errorMessage, "Failed to fetch weather: The operation couldn’t be completed. (NSURLErrorDomain error -1011.)")
        }
    }

    func testFetchWeatherNoData() async {
        mockWeatherService.mockWeatherResponse = nil

        await viewModel.fetchWeather(for: "")

        await MainActor.run {
            XCTAssertNil(viewModel.weather)
            XCTAssertNotNil(viewModel.errorMessage)
        }
    }
}
