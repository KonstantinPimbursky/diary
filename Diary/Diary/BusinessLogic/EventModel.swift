//
//  EventModel.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 06.03.2022.
//

import UIKit

protocol EventModel {
    var id: UUID { get }
    var dateStart: Date { get set }
    var dateFinish: Date { get set }
    var name: String { get set }
    var description: String { get set }
}

struct EventModelImpl: EventModel {
    var id: UUID = UUID()
    var dateStart: Date = Date()
    var dateFinish: Date = Date()
    var name: String = ""
    var description: String = ""
}
