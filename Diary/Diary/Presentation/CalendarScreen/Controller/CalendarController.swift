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
    
    private let mainView = CalendarView()
    private var dailyEvents = [EventModel]()
    private let realmManager = RealmManager()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        fillTodayEvents()
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
    
    private func fillTodayEvents() {
        dailyEvents = realmManager.getSavedEvents(per: Date())
    }
    
    private func setupMainView() {
        mainView.calendarView.select(Date())
        mainView.calendarView.delegate = self
        mainView.dailyEventsTableView.dataSource = self
    }
    
    @objc private func addButtonAction() {
        let storyBoard = UIStoryboard(name: "CreateEventController", bundle: nil)
        guard let createEventController = storyBoard.instantiateViewController(
            withIdentifier: "CreateEventController"
        ) as? CreateEventController else { return }
        createEventController.delegate = self
        if var selectedDate = mainView.calendarView.selectedDate {
            let currentHour = Calendar.current.component(.hour, from: Date())
            let currentMinute = Calendar.current.component(.minute, from: Date())
            selectedDate = Calendar.current.date(
                byAdding: .hour,
                value: currentHour,
                to: selectedDate
            ) ?? selectedDate
            selectedDate = Calendar.current.date(
                byAdding: .minute,
                value: currentMinute,
                to: selectedDate
            ) ?? selectedDate
            createEventController.selectedDate(selectedDate)
        }
        navigationController?.pushViewController(createEventController, animated: true)
    }
    
    @objc private func eventTapAction(_ sender: UIButton) {
        let detailsController = DetailsScreenController(eventModel: dailyEvents[sender.tag], delegate: self)
        navigationController?.pushViewController(detailsController, animated: true)
    }
}

// MARK: - CreateEventScreenControllerDelegate

extension CalendarController: CreateEventControllerDelegate {
    func eventWasSaved() {
        mainView.calendarView.select(Date())
        fillTodayEvents()
        mainView.dailyEventsTableView.reloadData()
    }
}

// MARK: - FSCalendarDelegate

extension CalendarController: FSCalendarDelegate {
    func calendar(
        _ calendar: FSCalendar,
        didSelect date: Date,
        at monthPosition: FSCalendarMonthPosition
    ) {
        dailyEvents = realmManager.getSavedEvents(per: date)
        mainView.dailyEventsTableView.reloadData()
    }
}

// MARK: - DetailsScreenControllerDelegate

extension CalendarController: DetailsScreenControllerDelegate {
    func deleteButtonWasTapped() {
        print("deleteButtonWasTapped")
        fillTodayEvents()
        mainView.dailyEventsTableView.reloadData()
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
        for (index, event) in dailyEvents.enumerated() {
            let startHour = Calendar.current.component(.hour, from: event.dateStart)
            let endHour = Calendar.current.component(.hour, from: event.dateFinish)
            if indexPath.item >= startHour && indexPath.item <= endHour {
                cell.addEvent(
                    event,
                    tag: index,
                    target: self,
                    action: #selector(eventTapAction(_:)),
                    control: .touchUpInside
                )
            }
        }
        
        return cell
    }
}
