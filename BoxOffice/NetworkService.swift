//
//  NetworkService.swift
//  BoxOffice
//
//  Created by Gray, Prism on 4/5/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
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
    
    func getDailyBoxOffice(date: String, completion: @escaping CompletionHandler) {
        var components = URLComponents(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")
        let apiKey = URLQueryItem(name: "key", value: "\(Environment.apiKey)")
        let targetDate = URLQueryItem(name: "targetDt", value: "20240403")
        components?.queryItems = [apiKey, targetDate]

        let url = components?.url

        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                completion(.failure(.invalidURL))
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode))
                return
            }

            guard let data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
    func getMovieDetail(movieCode: String, completion: @escaping CompletionHandler) {
        let baseURL = "https://www.kobis.or.kr"
        let path = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        
        guard var components = URLComponents(string: "\(baseURL)\(path)") else {
            completion(.failure(.invalidURL))
            
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "key", value: Environment.apiKey),
            URLQueryItem(name: "movieCd", value: movieCode)
        ]
        
        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                let nsError = error as NSError
                switch nsError.code {
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
