//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Jaehun Lee on 4/2/24.
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
    
    func test_BoxOffice모델을_사용해_정상적으로_파싱되는지_테스트() throws {
        let fileName = "box_office_sample"
        let fileExtension = "json"
        
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: fileName, withExtension: fileExtension) else {
            XCTFail("Missing File: \"\(fileName).\(fileExtension)\"")
            return
        }
        
        let result = try? JSONDecoder().decode(BoxOffice.self, from: Data(contentsOf: url))
        
        XCTAssertNotNil(result)
    }
}
