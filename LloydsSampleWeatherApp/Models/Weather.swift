//
//  Weather.swift
//  LloydsSampleWeatherApp
//
//  Created by Abinash Barooah on 18/12/2024.
//

import Foundation

struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let icon: String
}
