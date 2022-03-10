//
//  File.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 10.03.2022.
//

import Foundation

protocol DayOfMonth {
    /// Число дня
    var number: String { get }
    /// Отметка, что этот день соответствует сегодняшнему дню
    ///
    /// Необходимо для коллекции календаря, чтобы отметить сегодняшний день
    var isToday: Bool { get }
}

struct DayOfMonthImpl: DayOfMonth {
    var number: String = ""
    var isToday: Bool = false
}
