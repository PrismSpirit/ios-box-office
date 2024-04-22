//
//  DailyBoxOfficeListCell.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/10/24.
//

import UIKit

final class DailyBoxOfficeListCell: UICollectionViewListCell {
    var boxOffice: BoxOffice?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var configuration = DailyBoxOfficeListConfiguration().updated(for: state)
        configuration.boxOffice = boxOffice
        
        contentConfiguration = configuration
    }
}

final class DailyBoxOfficeGridCell: UICollectionViewListCell {
    var boxOffice: BoxOffice?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var configuration = DailyBoxOfficeGridConfiguration().updated(for: state)
        configuration.boxOffice = boxOffice
        
        contentConfiguration = configuration
    }
}
