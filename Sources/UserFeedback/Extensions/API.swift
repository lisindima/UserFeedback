//
//  API.swift
//  
//
//  Created by Дмитрий Лисин on 16.11.2020.
//

import Foundation
import Combine

final class API {
    private var requests = Set<AnyCancellable>()
    
    private func createRequest(_ endpoint: Endpoint, httpMethod: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: endpoint.url)
        request.allowsExpensiveNetworkAccess = true
        request.httpMethod = httpMethod.rawValue
        request.setValue("Bearer TEST", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("UserFeedback", forHTTPHeaderField: "User-Agent")
        return request
    }
    
    private func createDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 7)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
    private func createEncoder() -> JSONEncoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dataEncodingStrategy = .base64
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }
    
    func upload<Parameters: Encodable, T: Decodable>(_ endpoint: Endpoint, parameters: Parameters, httpMethod: HTTPMethod = .post, completion: @escaping (Result<T, ApiError>) -> Void) {
        var request = createRequest(endpoint, httpMethod: httpMethod)
        request.httpBody = try? createEncoder().encode(parameters)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: createDecoder())
            .map(Result.success)
            .catch { error -> Just<Result<T, ApiError>> in
                error is DecodingError
                    ? Just(.failure(.decodeFailed(error)))
                    : Just(.failure(.uploadFailed(error)))
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &requests)
    }
    
    func fetch<T: Decodable>(_ endpoint: Endpoint, httpMethod: HTTPMethod = .get, completion: @escaping (Result<T, ApiError>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: createRequest(endpoint, httpMethod: httpMethod))
            .map(\.data)
            .decode(type: T.self, decoder: createDecoder())
            .map(Result.success)
            .catch { error -> Just<Result<T, ApiError>> in
                error is DecodingError
                    ? Just(.failure(.decodeFailed(error)))
                    : Just(.failure(.uploadFailed(error)))
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &requests)
    }
}

extension Endpoint {
    static let api = API()
}

extension Endpoint {
    var url: URL {
        switch self {
        case .issues:
            return .makeForEndpoint("issues")
        }
    }
}

extension URL {
    static func makeForEndpoint(_ endpoint: String) -> URL {
        URL(string: "https://api.github.com/\(endpoint)")!
    }
}
