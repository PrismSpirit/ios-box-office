//
//  DailyBoxOfficeResponseDTO.swift
//  BoxOffice
//
//  Created by JIWOONG on 2024/04/02.
//

struct DailyBoxOfficeResponseDTO: Decodable {
    let boxOfficeResult: BoxOfficeResultDTO
}

extension DailyBoxOfficeResponseDTO {
    struct BoxOfficeResultDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case boxOfficeType = "boxofficeType"
            case queriedDateRange = "showRange"
            case dailyBoxOfficeList
        }
        
        let boxOfficeType: String
        let queriedDateRange: String
        let dailyBoxOfficeList: [DailyBoxOfficeDTO]
    }
}

extension DailyBoxOfficeResponseDTO {
    struct DailyBoxOfficeDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case registrationNumber = "rnum"
            case rank
            case rankChange = "rankInten"
            case rankingEntry = "rankOldAndNew"
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
        
        enum RankingEntryDTO: String, Decodable {
            case old = "OLD"
            case new = "NEW"
        }
        
        let registrationNumber, rank, rankChange: String
        let rankingEntry: RankingEntryDTO
        let movieCode, movieName, openDate: String
        let salesAmount, salesShare, salesChange, salesChangeRate, salesAccumulation: String
        let audienceCount, audienceChange, audienceChangeRate, audienceAccmulation: String
        let screenCount, showCount: String
    }
}

extension DailyBoxOfficeResponseDTO.DailyBoxOfficeDTO {
    func toModel() -> BoxOffice {
        return .init(rank: Int(rank) ?? .zero,
                     rankChange: Int(rankChange) ?? .zero,
                     rankingEntry: rankingEntry == .old ? .old : .new,
                     title: movieName,
                     todayAudience: Int(audienceCount) ?? .zero,
                     totalAudience: Int(audienceAccmulation) ?? .zero,
                     movieCode: movieCode)
    }
}
