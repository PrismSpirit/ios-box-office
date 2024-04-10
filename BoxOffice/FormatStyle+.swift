//
//  FormatStyle+.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/10/24.
//

import Foundation

extension FormatStyle where Self == Date.ISO8601FormatStyle {
    static var iso8601FullDate: Date.ISO8601FormatStyle {
        return iso8601.year().month().day()
    }
    
    static var iso8601FullDateWithoutSeparator: Date.ISO8601FormatStyle {
        return iso8601FullDate.dateSeparator(.omitted)
    }
}
