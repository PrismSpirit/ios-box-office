//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/16/24.
//

import UIKit

protocol CalendarViewDelegate: AnyObject {
    func changeSelectedDate(date: Date)
}

final class CalendarViewController: UIViewController {
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .autoupdatingCurrent
        calendarView.locale = .autoupdatingCurrent
        calendarView.timeZone = .autoupdatingCurrent
        calendarView.availableDateRange = DateInterval(start: Date(timeIntervalSince1970: .zero), end: Date())
        return calendarView
    }()
    
    weak var delegate: CalendarViewDelegate?
    private let selectedDate: Date
    
    init(selectedDate: Date) {
        self.selectedDate = selectedDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateSelection.selectedDate = Calendar.autoupdatingCurrent.dateComponents(in: .autoupdatingCurrent, from: selectedDate) 
        calendarView.selectionBehavior = dateSelection
        
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

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents,
              let date = Calendar.autoupdatingCurrent.date(from: dateComponents) else {
            return
        }
        
        delegate?.changeSelectedDate(date: date)
        self.dismiss(animated: true)
    }
}
