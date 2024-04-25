//
//  LayoutManager.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/24/24.
//

import UIKit

fileprivate struct ListLayout {
    static func getLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

fileprivate struct Grid2ColumnLayout {
    static func getLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        group.interItemSpacing = .fixed(-15)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = -15
        return UICollectionViewCompositionalLayout(section: section)
    }
}

struct LayoutManager {
    private init() { }
    
    static func layout(screenMode: ScreenMode) -> UICollectionViewCompositionalLayout {
        switch screenMode {
        case .list:
            return ListLayout.getLayout()
        case .grid:
            return Grid2ColumnLayout.getLayout()
        }
    }
}
