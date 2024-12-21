//
//  MockNetworkingService.swift
//  LloydsSampleWeatherAppTests
//
//  Created by Abinash Barooah on 20/12/2024.
//

import Foundation
@testable import LloydsSampleWeatherApp

class MockNetworkingService: NetworkingService {
    private let result: Result<Data, Error>

    init(result: Result<Data, Error>) {
        self.result = result
    }

    // Async/Await fetchData
    func fetchData(from url: URL) async throws -> Data {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}

