//
//  APIs.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/6/24.
//

import Foundation

protocol API {
    static var baseURL: URL { get }
}

enum APIs {
    enum Kobis {
        static let baseURL = URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest")!
    }
}

extension APIs.Kobis {
    enum BoxOffice: RawRepresentable, API {
        static var baseURL = APIs.Kobis.baseURL.appendingPathComponent("boxoffice")
        
        var rawValue: String {
            switch self {
            case .dailyList:
                return "searchDailyBoxOfficeList.json"
            }
        }
        
        case dailyList
    }
    
    enum Movie: RawRepresentable, API {
        static var baseURL = APIs.Kobis.baseURL.appendingPathComponent("movie")
        
        var rawValue: String {
            switch self {
            case .info:
                return "searchMovieInfo.json"
            }
        }
        
        case info
    }
}

extension RawRepresentable where RawValue == String, Self: API {
    var url: URL { Self.baseURL.appendingPathComponent(rawValue) }
    
    init?(rawValue: String) { nil }
}