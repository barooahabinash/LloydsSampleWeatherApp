//
//  ContentView.swift
//  LloydsSampleWeatherApp
//
//  Created by Abinash Barooah on 18/12/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter city", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Get Weather") {
                    Task {
                        await viewModel.fetchWeather(for: city)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()

                if let weather = viewModel.weather {
                    WeatherCardView(weather: weather, errorMessage: nil)
                } else {
                    WeatherCardView(weather: nil, errorMessage: viewModel.errorMessage)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Weather App")
        }
    }
}

//Preview only
#Preview {
    ContentView()
}
