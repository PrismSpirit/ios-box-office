//
//  NetworkService.swift
//  BoxOffice
//
//  Created by Gray, Prism on 4/5/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case notConnected(Error)
    case badNetwork(Error)
    case requestFailure(Error)
    case invalidStatusCode
    case noData
}

final class NetworkService {
    typealias CompletionHandler = (Result<Data, NetworkError>) -> Void
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request(url: URL, queryParameters: [String: String], completion: @escaping CompletionHandler) {
        guard var components = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidURL))
            return
        }
        
        components.queryItems = queryParameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                let nsError = error as NSError
                switch nsError.code {
                case NSURLErrorNotConnectedToInternet:
                    completion(.failure(.notConnected(error)))
                case NSURLErrorTimedOut:
                    completion(.failure(.badNetwork(error)))
                default:
                    completion(.failure(.requestFailure(error)))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode))
                return
            }
            
            if let data {
                completion(.success(data))
            } else {
                completion(.failure(.noData))
            }
        }
        task.resume()
    }
}
