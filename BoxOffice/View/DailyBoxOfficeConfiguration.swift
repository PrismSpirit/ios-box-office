//
//  DailyBoxOfficeConfiguration.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/12/24.
//

import UIKit

struct DailyBoxOfficeListConfiguration: UIContentConfiguration {
    var boxOffice: BoxOffice?
    
    func makeContentView() -> UIView & UIContentView {
        return DailyBoxOfficeListContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> DailyBoxOfficeListConfiguration {
        return self
    }
}

struct DailyBoxOfficeGridConfiguration: UIContentConfiguration {
    var boxOffice: BoxOffice?
    
    func makeContentView() -> UIView & UIContentView {
        return DailyBoxOfficeGridContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> DailyBoxOfficeGridConfiguration {
        return self
    }
}
