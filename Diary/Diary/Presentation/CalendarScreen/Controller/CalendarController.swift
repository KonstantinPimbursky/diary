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
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupMainView()
    }
    
    private func setupMainView() {
        mainView.monthCollectionView.dataSource = self
        mainView.monthCollectionView.delegate = self
    }
    
}

// MARK: - CalendarViewDelegate

extension CalendarController: CalendarViewDelegate {
    func previousMonthButtonTapped() {
        print("previousMonthButtonTapped")
    }
    
    func nextMonthButtonTapped() {
        print("nextMonthButtonTapped")
    }
}

// MARK: - UICollectionViewDataSource

extension CalendarController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testDays.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarCell.reuseIdentifier,
            for: indexPath
        ) as? CalendarCell else { return UICollectionViewCell() }
        
        cell.text = testDays[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalendarController: UICollectionViewDelegate {
    
}
