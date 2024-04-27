//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Prism, Gray on 4/2/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_모델을_사용해_정상적으로_파싱되는지_테스트() throws {
        let fileName = "box_office_sample"
        let fileExtension = "json"
        
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: fileName, withExtension: fileExtension) else {
            XCTFail("Missing File: \"\(fileName).\(fileExtension)\"")
            return
        }
        
        do {
            let result = try JSONDecoder().decode(DailyBoxOfficeResponseDTO.self, from: Data(contentsOf: url))
            XCTAssertEqual(DailyBoxOfficeResponseDTO.mock, result)
        } catch {
            XCTFail()
        }
        
    }
}

#if DEBUG
extension DailyBoxOfficeResponseDTO: Equatable {
    static var mock: Self = .init(boxOfficeResult: .init(boxOfficeType: "일별 박스오피스",
                                                         queriedDateRange: "20220105~20220105",
                                                         dailyBoxOfficeList: [
                                                            .init(rankingEntry: .new, movieCode: "20199882"),
                                                            .init(rankingEntry: .old, movieCode: "20210028"),
                                                            .init(rankingEntry: .new, movieCode: "20218764"),
                                                            .init(rankingEntry: .old, movieCode: "20194403"),
                                                            .init(rankingEntry: .old, movieCode: "20217807"),
                                                            .init(rankingEntry: .old, movieCode: "20192354"),
                                                            .init(rankingEntry: .old, movieCode: "20218415"),
                                                            .init(rankingEntry: .old, movieCode: "20210672"),
                                                            .init(rankingEntry: .old, movieCode: "20218390"),
                                                            .init(rankingEntry: .old, movieCode: "20210864")
                                                         ]))
    
    public static func == (lhs: DailyBoxOfficeResponseDTO, rhs: DailyBoxOfficeResponseDTO) -> Bool {
        return lhs.boxOfficeResult == rhs.boxOfficeResult
    }
}

extension DailyBoxOfficeResponseDTO.BoxOfficeResultDTO: Equatable {
    public static func == (lhs: DailyBoxOfficeResponseDTO.BoxOfficeResultDTO, rhs: DailyBoxOfficeResponseDTO.BoxOfficeResultDTO) -> Bool {
        return (lhs.boxOfficeType == rhs.boxOfficeType) && (lhs.queriedDateRange == rhs.queriedDateRange) && (lhs.dailyBoxOfficeList == rhs.dailyBoxOfficeList)
    }
}

extension DailyBoxOfficeResponseDTO.DailyBoxOfficeDTO: Equatable {
    init(rankingEntry: RankingEntryDTO, movieCode: String) {
        self.init(registrationNumber: "",
                  rank: "",
                  rankChange: "",
                  rankingEntry: rankingEntry,
                  movieCode: movieCode,
                  movieName: "",
                  openDate: "",
                  salesAmount: "",
                  salesShare: "",
                  salesChange: "",
                  salesChangeRate: "",
                  salesAccumulation: "",
                  audienceCount: "",
                  audienceChange: "",
                  audienceChangeRate: "",
                  audienceAccmulation: "",
                  screenCount: "",
                  showCount: "")
    }
    
    public static func == (lhs: DailyBoxOfficeResponseDTO.DailyBoxOfficeDTO, rhs: DailyBoxOfficeResponseDTO.DailyBoxOfficeDTO) -> Bool {
        return lhs.movieCode == rhs.movieCode
    }
}
#endif
