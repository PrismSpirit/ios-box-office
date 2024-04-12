//
//  Environment.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/5/24.
//

import Foundation

public enum Environment {
    enum Keys {
        static let apiKey = "API_KEY"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist not found")
        }
        
        return dict
    }()
    
    static let apiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[Keys.apiKey] as? String else {
            fatalError("API KEY does not exist in plist")
        }
        
        return apiKeyString
    }()
}
