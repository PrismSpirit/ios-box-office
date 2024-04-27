//
//  DailyBoxOfficeConfiguration.swift
//  BoxOffice
//
//  Created by Prism, Gray on 4/12/24.
//

import UIKit

struct DailyBoxOfficeConfiguration: UIContentConfiguration {
    var boxOffice: BoxOffice?
    let screenMode: ScreenMode
    
    func makeContentView() -> UIView & UIContentView {
        switch screenMode {
        case .list:
            return DailyBoxOfficeListContentView(configuration: self)
        case .grid:
            return DailyBoxOfficeGridContentView(configuration: self)
        }
    }
    
    func updated(for state: UIConfigurationState) -> DailyBoxOfficeConfiguration {
        return self
    }
}
