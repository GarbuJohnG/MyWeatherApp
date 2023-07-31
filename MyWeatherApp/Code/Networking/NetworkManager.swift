//
//  NetworkManager.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import Foundation
import Combine

enum APIError: LocalizedError {
    case locationError
    case requestFailed
    case decodeError
    var errorDescription: String? {
        switch self {
            case .locationError: return "Unable to determine location."
            case .requestFailed: return "Unable to perform requested action."
            case .decodeError: return "Unable to decode data"
        }
    }
}

enum HTTPMethodType: String {
    case POST = "POST"
    case GET = "GET"
}

struct NetworkConstants {
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    static let weatherAPI = "weather"
    static let forecastAPI = "forecast"
}

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    func requestAPI<T: Decodable>(url: String, parameter: [String: AnyObject]? = nil, httpMethodType: HTTPMethodType = .GET) -> AnyPublisher<T, APIError> {
        guard let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: escapedAddress) else {
                return Fail(error: APIError.requestFailed).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethodType.rawValue
        
        if let requestBodyParams = parameter {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: requestBodyParams, options: .prettyPrinted)
            } catch {
                return Fail(error: APIError.requestFailed).eraseToAnyPublisher()
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.0 }
            .decode(type: T.self, decoder: JSONDecoder())
            .catch { _ in Fail(error: APIError.decodeError).eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
    
}
