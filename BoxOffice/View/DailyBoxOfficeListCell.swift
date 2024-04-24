//
//  DailyBoxOfficeListCell.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/10/24.
//

import UIKit

final class DailyBoxOfficeCell: UICollectionViewListCell {
    var boxOffice: BoxOffice?
    var screenMode: ScreenMode?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let screenMode else {
            return
        }
        
        var configuration = DailyBoxOfficeConfiguration(screenMode: screenMode).updated(for: state)
        configuration.boxOffice = boxOffice
        
        contentConfiguration = configuration
    }
}
