//
//  AlertFactory.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/15/24.
//

import UIKit

protocol Alertable {
    func makeAlert(error: any Error) -> UIAlertController
}

struct NetworkingFailAlert: Alertable {
    func makeAlert(error: any Error) -> UIAlertController {
        let alertController = UIAlertController(title: "Network Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default))
        
        return alertController
    }
}

struct JSONDecodingFailAlert: Alertable {
    func makeAlert(error: any Error) -> UIAlertController {
        let alertController = UIAlertController(title: "Data Decoding Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default))
        
        return alertController
    }
}

struct UnknownErrorAlert: Alertable {
    func makeAlert(error: any Error) -> UIAlertController {
        let alertController = UIAlertController(title: "Unkwown Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default))
        
        return alertController
    }
}

struct AlertFactory {
    private init() { }
    
    static func alert(for error: any Error) -> UIAlertController {
        switch error {
        case let error as NetworkError:
            return NetworkingFailAlert().makeAlert(error: error)
        case let error as DecodingError:
            return JSONDecodingFailAlert().makeAlert(error: error)
        default:
            return UnknownErrorAlert().makeAlert(error: error)
        }
    }
}
