//
//  DailyBoxOfficeConfiguration.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/12/24.
//

import UIKit

struct DailyBoxOfficeConfiguration: UIContentConfiguration {
    var boxOffice: BoxOffice?
    
    func makeContentView() -> UIView & UIContentView {
        return DailyBoxOfficeContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> DailyBoxOfficeConfiguration {
        return self
    }
}
