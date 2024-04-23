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
    
    enum Kakao {
        static let baseURL = URL(string: "https://dapi.kakao.com/v2/")!
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

extension APIs.Kakao {
    enum Search: RawRepresentable, API {
        static var baseURL = APIs.Kakao.baseURL.appendingPathComponent("search")
        
        var rawValue: String {
            switch self {
            case .image:
                return "image"
            }
        }
        
        case image
    }
}

extension RawRepresentable where RawValue == String, Self: API {
    var url: URL { Self.baseURL.appendingPathComponent(rawValue) }
    
    init?(rawValue: String) { nil }
}
