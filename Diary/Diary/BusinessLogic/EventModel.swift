//
//  EventModel.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 06.03.2022.
//

import UIKit

protocol EventModel {
    var id: UUID { get }
    var dateStart: TimeInterval { get }
    var dateFinish: TimeInterval { get }
    var name: String { get }
    var description: String { get }
}

struct EventModelImpl: EventModel {
    var id: UUID = UUID()
    var dateStart: TimeInterval
    var dateFinish: TimeInterval
    var name: String
    var description: String
}
