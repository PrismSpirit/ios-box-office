//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by JIWOONG on 2024/04/10.
//

struct BoxOffice: Hashable {
    let rank: Int
    let rankChange: Int
    let rankingEntry: RankingEntry
    let title: String
    let todayAudience: Int
    let totalAudience: Int
    
    enum RankingEntry {
        case old
        case new
    }
}
