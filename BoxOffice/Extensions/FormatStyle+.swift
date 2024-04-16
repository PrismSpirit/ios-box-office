//
//  FormatStyle+.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/10/24.
//

import Foundation

extension FormatStyle where Self == Date.ISO8601FormatStyle {
    static var iso8601FullDate: Date.ISO8601FormatStyle {
        let formatStyle = Date.ISO8601FormatStyle(timeZone: .autoupdatingCurrent)
        return formatStyle.year().month().day()
    }
    
    static var iso8601FullDateWithoutSeparator: Date.ISO8601FormatStyle {
        let formatStyle = Date.ISO8601FormatStyle(dateSeparator: .omitted, timeZone: .autoupdatingCurrent)
        return formatStyle.year().month().day()
    }
}
