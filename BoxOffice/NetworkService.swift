//
//  NetworkService.swift
//  BoxOffice
//
//  Created by JIWOONG on 2024/04/05.
//

import Foundation

enum NetworkError: Error {
    case noData
    case notFoundURL
    case wrongResponse
}
typealias CompletionHandler = (Result<Data, NetworkError>) -> Void

class NetworkService {
    func loadDailyBoxOffice(completion: @escaping CompletionHandler) {
        
        var components = URLComponents(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")
        let apiKey = URLQueryItem(name: "key", value: "\(Environment.apiKey)")
        let targetDate = URLQueryItem(name: "targetDt", value: "20240403")
        components?.queryItems = [apiKey, targetDate]

        let url = components?.url

        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                completion(.failure(.notFoundURL))
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.wrongResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
            
        }
        task.resume()
    }
}
