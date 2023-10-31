//
//  WebService.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/27/23.
//

import Foundation

protocol APIImplement {
    func fetchData<T: Decodable>(location: String, path: String, modelType: T.Type) async throws -> T
}
struct WebService: APIImplement {
    func fetchData<T: Decodable>(location: String, path: String, modelType: T.Type) async throws -> T {
        do {
            let paramLocation = URLQueryItem(name: "location", value: location)
            let networkRequest = NetworkRequest(baseUrl: "\(Constants.baseWeatherUrl)",
                                                path: path,
                                                params: [paramLocation, Constants.apiKey],
                                                type: .GET,
                                                headers: Constants.headers)
            let urlRequest = try networkRequest.getURLRequest()
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let urlResponse = response as? HTTPURLResponse else { throw NetworkError.invalidResponseError }
            guard urlResponse.statusCode >= 200 && urlResponse.statusCode < 300 else { 
                if urlResponse.statusCode == 429 {
                    throw NetworkError.outOfAPILimitation
                } else {
                    throw NetworkError.invalidResponseError
                }
             }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let result = try? jsonDecoder.decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            return result
        } catch NetworkError.invalidUrl {
            throw NetworkError.invalidUrl
        } catch NetworkError.invalidRequest {
            throw NetworkError.invalidRequest
        }
    }
}
