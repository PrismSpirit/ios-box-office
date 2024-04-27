//
//  AlertManager.swift
//  BoxOffice
//
//  Created by Prism, Gray on 4/15/24.
//

import UIKit

fileprivate struct NetworkingFailAlert {
    static func makeAlert(error: Error) -> UIAlertController {
        let alertController = UIAlertController(title: "Network Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default))
        
        return alertController
    }
}

fileprivate struct JSONDecodingFailAlert {
    static func makeAlert(error: Error) -> UIAlertController {
        let alertController = UIAlertController(title: "Data Decoding Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default))
        
        return alertController
    }
}

fileprivate struct UnknownErrorAlert {
    static func makeAlert(error: Error) -> UIAlertController {
        let alertController = UIAlertController(title: "Unkwown Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default))
        
        return alertController
    }
}

struct AlertManager {
    private init() { }
    
    static func alert(for error: Error) -> UIAlertController {
        switch error {
        case let error as NetworkError:
            return NetworkingFailAlert.makeAlert(error: error)
        case let error as DecodingError:
            return JSONDecodingFailAlert.makeAlert(error: error)
        default:
            return UnknownErrorAlert.makeAlert(error: error)
        }
    }
}
