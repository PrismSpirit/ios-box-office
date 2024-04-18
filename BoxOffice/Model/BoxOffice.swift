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
    let movieCode: String
    
    enum RankingEntry {
        case old
        case new
    }
}

struct MovieDetail: Hashable {
    let movieName: String
    let directors: [String]
    let productionYear: Int
    let openDate: String
    let showTime: Int
    let watchGrade: [String]
    let nations: [String]
    let genres: [String]
    let actors: [String]
    
    let imageURL: String
}
