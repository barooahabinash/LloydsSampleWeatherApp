//
//  WeatherCardView.swift
//  LloydsSampleWeatherApp
//
//  Created by Abinash Barooah on 19/12/2024.
//


import SwiftUI

struct WeatherCardView: View {
    let weather: WeatherResponse?
    let errorMessage: String?

    var body: some View {
        ZStack {
            if let weather = weather {
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.blue, .cyan]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                    .overlay(
                        VStack(spacing: 10) {
                            Text(weather.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(radius: 2)

                            if let iconCode = weather.weather.first?.icon {
                                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png")) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                } placeholder: {
                                    ProgressView()
                                }
                            }

                            Text("\(Int(weather.main.temp))°C")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text(weather.weather.first?.description.capitalized ?? "N/A")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                    )
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.headline)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .frame(height: 200)
        .padding(.horizontal)
    }
}

// This is for preview only
struct WeatherCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherCardView(
                weather: WeatherResponse(
                    name: "San Francisco",
                    main: Main(temp: 22.0),
                    weather: [Weather(description: "Clear sky", icon: "01d")]
                ),
                errorMessage: nil
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Valid Data")

            WeatherCardView(
                weather: nil,
                errorMessage: "Unable to fetch weather data. Please try again."
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Error Message")

            //Optional
            WeatherCardView(
                weather: nil,
                errorMessage: nil
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Loading State")
        }
    }
}
