//
//  APIInteractor.swift
//  Challenge
//
//  Created by Serguei on 10/10/21.
//

import Foundation
import Combine

struct APIInteractor {
    private var urlComponents = URLComponents()
    
    init(scheme: Scheme, host: String, path: String){
        urlComponents.scheme = scheme.rawValue
        urlComponents.host = host
        urlComponents.path = path
    }
    
    func execute<T: Decodable>(method: Method, type: T.Type) -> AnyPublisher<T, Error> {
        guard let url = urlComponents.url else {
            fatalError("Invalid URL")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return URLSession(configuration: .default)
            .dataTaskPublisher(for: urlRequest)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NetworkingError.invalidHTTPResponse
                }
                return output.data
            }
            .decode(type: type, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension APIInteractor {
    enum Scheme: String {
        case http = "http"
        case https = "https"
    }
    
    enum Method: String {
        case get = "GET"
    }
    
    enum NetworkingError: Error {
        case invalidHTTPResponse
    }

}
