//
//  Environment.swift
//  BoxOffice
//
//  Created by Prism, Gray on 4/5/24.
//

import Foundation

public enum Environment {
    enum Keys {
        static let kobisApiKey = "KOBIS_API_KEY"
        static let kakaoApiKey = "KAKAO_API_KEY"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist not found")
        }
        
        return dict
    }()
    
    static let kobisApiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[Keys.kobisApiKey] as? String else {
            fatalError("Kobis API KEY does not exist in plist")
        }
        
        return apiKeyString
    }()
    
    static let kakaoApiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[Keys.kakaoApiKey] as? String else {
            fatalError("Kakao API KEY does not exist in plist")
        }
        
        return apiKeyString
    }()
}
