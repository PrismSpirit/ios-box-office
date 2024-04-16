//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/16/24.
//

import UIKit

final class CalendarViewController: UIViewController {
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .autoupdatingCurrent
        calendarView.locale = .autoupdatingCurrent
        calendarView.timeZone = .autoupdatingCurrent
        calendarView.availableDateRange = DateInterval(start: Date(timeIntervalSince1970: 0), end: Date())
        return calendarView
    }()
    
    override func viewDidLoad() {
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: self.view.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}
