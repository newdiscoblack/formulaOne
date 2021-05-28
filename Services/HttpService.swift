//
//  ApiService.swift
//  formula-one
//
//  Created by Kacper Jagiello on 09/04/2021.
//

import Foundation
import Combine

public protocol HttpServing {
    func fetchDataFrom<T: Decodable>(
        _ url: URL
    ) -> AnyPublisher<T, Error>
}

public protocol HasHttpService {
    var httpService: HttpServing { get }
}

public struct HttpService: HttpServing {
    public init() { }
    public func fetchDataFrom<T: Decodable>(
        _ url: URL
    ) -> AnyPublisher<T, Error> {
        URLSession.shared
            .dataTaskPublisher(
                for: url
            )
            .tryMap { element -> Data in
                print("Request URL: \(url)")
                guard let httpResponse = element.response as? HTTPURLResponse else {
                    throw ApiError.invalidServerResponse(element.response)
                }
                
                guard httpResponse.statusCode == 200 else {
                    throw ApiError.responseError(httpResponse.statusCode)
                }
                
                return element.data
            }
            .decode(
                type: T.self,
                decoder: JSONDecoder()
            )
            .print("Request")
            .eraseToAnyPublisher()
    }
}
