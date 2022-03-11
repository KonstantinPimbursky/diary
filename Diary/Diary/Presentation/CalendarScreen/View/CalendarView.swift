//
//  CalendarView.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 03.03.2022.
//

import FSCalendar
import UIKit

final class CalendarView: UIView {
    
    // MARK: - Public Properties
    
    public let calendarView: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    public let dailyEventsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(DailyEventsCell.self, forCellReuseIdentifier: DailyEventsCell.reuseIdentifier)
        return table
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout

extension CalendarView {
    private func addSubviews() {
        [
            calendarView,
            dailyEventsTableView
        ].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            calendarView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        NSLayoutConstraint.activate([
            dailyEventsTableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 16),
            dailyEventsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            dailyEventsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            dailyEventsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
