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
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
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
