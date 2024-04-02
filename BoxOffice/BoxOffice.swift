//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by JIWOONG on 2024/04/02.
//

struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let queriedDateRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case queriedDateRange = "showRange"
        case dailyBoxOfficeList
    }
}

struct DailyBoxOffice: Decodable {
    let registrationNumber, rank, rankChange: String
    let rankOldAndNew: RankOldAndNew
    let movieCode, movieName, openDate: String
    let salesAmount, salesShare, salesChange, salesChangeRate, salesAccumulation: String
    let audienceCount, audienceChange, audienceChangeRate, audienceAccmulation: String
    let screenCount, showCount: String
    
    private enum CodingKeys: String, CodingKey {
        case registrationNumber = "rnum"
        case rank
        case rankChange = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare = "salesShare"
        case salesChange = "salesInten"
        case salesChangeRate = "salesChange"
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceChange = "audiInten"
        case audienceChangeRate = "audiChange"
        case audienceAccmulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

enum RankOldAndNew: String, Decodable {
    case old = "OLD"
    case new = "NEW"
}
