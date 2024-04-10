//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by JIWOONG on 2024/04/10.
//

struct BoxOffice {
    let rank: String
    let rankChange: String
    let rankingEntry: RankingEntry
    let title: String
    let todayAudience: String
    let totalAudience: String
    
    enum RankingEntry {
        case old
        case new
    }
}
