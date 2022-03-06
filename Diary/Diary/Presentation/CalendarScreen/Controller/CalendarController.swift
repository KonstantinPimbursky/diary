//
//  CalendarController.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 03.03.2022.
//

import UIKit

/// Контроллер главного экрана приложения. С него запускается приложение.
/// На данном экране располагается календарь и список дел.
final class CalendarController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var mainView = CalendarView(subscriber: self)
    
    private let testDays = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
        "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
        "21", "22", "23", "24", "25", "26", "27", "28"
    ]
    private var selectedDate = Date()
    private var monthDays = [String]()
    private let calendarHelper = CalendarHelper()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupMainView()
        setMonthCollection()
    }
    
    // MARK: - Private Methods
    
    private func setupMainView() {
        mainView.monthCollectionView.dataSource = self
        mainView.monthCollectionView.delegate = self
    }
    
    private func setMonthCollection() {
        monthDays.removeAll()
        
        let daysInMonth = calendarHelper.daysInMonth(date: selectedDate)
        let firstDayOfMonth = calendarHelper.firstOfMonth(date: selectedDate)
        let startingSpaces = calendarHelper.weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        while count <= 42 {
            if count <= startingSpaces || count - startingSpaces > daysInMonth {
                monthDays.append("")
            } else {
                monthDays.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        mainView.monthLabel.text = calendarHelper.monthString(date: selectedDate).capitalizingFirstLetter()
        mainView.monthCollectionView.reloadData()
    }
    
}

// MARK: - CalendarViewDelegate

extension CalendarController: CalendarViewDelegate {
    func previousMonthButtonTapped() {
        selectedDate = calendarHelper.minusMonth(date: selectedDate)
        setMonthCollection()
    }
    
    func nextMonthButtonTapped() {
        selectedDate = calendarHelper.plusMonth(date: selectedDate)
        setMonthCollection()
    }
}

// MARK: - UICollectionViewDataSource

extension CalendarController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthDays.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarCell.reuseIdentifier,
            for: indexPath
        ) as? CalendarCell else { return UICollectionViewCell() }
        
        cell.text = monthDays[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalendarController: UICollectionViewDelegate {
    
}
