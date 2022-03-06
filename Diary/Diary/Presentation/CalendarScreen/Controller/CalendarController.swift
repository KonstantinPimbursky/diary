//
//  CalendarController.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 03.03.2022.
//

import FSCalendar
import UIKit

/// Контроллер главного экрана приложения. С него запускается приложение.
/// На данном экране располагается календарь и список дел.
final class CalendarController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var mainView = CalendarView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setupMainView()
    }
    
    // MARK: - Private Methods
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonAction)
        )
    }
    
    private func setupMainView() {
        mainView.calendarView.delegate = self
        mainView.dailyEventsTableView.dataSource = self
        mainView.dailyEventsTableView.delegate = self
    }
    
}

// MARK: - FSCalendarDelegate

extension CalendarController: FSCalendarDelegate {
    func calendar(
        _ calendar: FSCalendar,
        didSelect date: Date,
        at monthPosition: FSCalendarMonthPosition
    ) {
        print("calendar didSelect")
    }
}

// MARK: - UITableViewDataSource

extension CalendarController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: DailyEventsCell.reuseIdentifier,
                for: indexPath
            ) as? DailyEventsCell
        else { return UITableViewCell() }
        
        var cellText = ""
        if indexPath.item < 10 {
            cellText = "0" + String(indexPath.item) + ":00"
        } else {
            cellText = String(indexPath.item) + ":00"
        }
        cell.timeText = cellText
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CalendarController: UITableViewDelegate {
    
}
