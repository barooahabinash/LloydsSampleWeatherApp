//
//  LloydsSampleWeatherAppTests.swift
//  LloydsSampleWeatherAppTests
//
//  Created by Abinash Barooah on 17/12/2024.
//

import XCTest
@testable import LloydsSampleWeatherApp

final class LloydsSampleWeatherAppTests: XCTestCase {
    private var viewModel: WeatherViewModel!
    private var mockWeatherService: MockWeatherService!

    override func setUp() {
        super.setUp()
        mockWeatherService = MockWeatherService()
       // viewModel = WeatherViewModel(weatherService: mockWeatherService) // Inject mock service
    }

    override func tearDown() {
        viewModel = nil
        mockWeatherService = nil
        super.tearDown()
    }

    func testFetchWeather_Success() {
        // Arrange
        let mockWeather = WeatherResponse(
            name: "London",
            main: Main(temp: 15.0),
            weather: [Weather(description: "Sunny", icon: "01d")]
        )
        mockWeatherService.mockResponse = .success(mockWeather) // Provide mock response

        // Act
        let expectation = XCTestExpectation(description: "Fetch weather succeeds")
        viewModel.city = "London"
        viewModel.fetchWeather()

        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Allow time for async callback
            XCTAssertEqual(self.viewModel.weather?.name, "London")
            XCTAssertEqual(self.viewModel.weather?.main.temp, 15.0)
            XCTAssertEqual(self.viewModel.weather?.weather.first?.description, "Sunny")
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchWeather_Failure() {
        // Arrange
        mockWeatherService.mockResponse = .failure(URLError(.notConnectedToInternet)) // Provide failure response

        // Act
        let expectation = XCTestExpectation(description: "Fetch weather fails")
        viewModel.city = "InvalidCity"
        viewModel.fetchWeather()

        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Allow time for async callback
            XCTAssertNil(self.viewModel.weather)
            XCTAssertEqual(self.viewModel.errorMessage, URLError(.notConnectedToInternet).localizedDescription)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
