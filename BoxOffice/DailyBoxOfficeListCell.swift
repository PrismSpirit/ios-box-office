//
//  DailyBoxOfficeListCell.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/10/24.
//

import UIKit

class DailyBoxOfficeListCell: UICollectionViewListCell {
    var boxOffice: BoxOffice?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var configuration = DailyBoxOfficeConfiguration().updated(for: state)
        configuration.boxOffice = boxOffice
        
        contentConfiguration = configuration
    }
}
