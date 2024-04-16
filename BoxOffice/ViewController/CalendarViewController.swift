//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/16/24.
//

import UIKit

final class CalendarViewController: UIViewController, UICalendarSelectionSingleDateDelegate {

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
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents else {
            return
        }
        let date = Calendar.autoupdatingCurrent.date(from: dateComponents)
        
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(calendarView)
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: self.view.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}
