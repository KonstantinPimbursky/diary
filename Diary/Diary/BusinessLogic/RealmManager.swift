//
//  RealmManager.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 10.03.2022.
//

import Foundation
import RealmSwift

// MARK: - PhotoRealmObject

class PhotoRealmObject: Object {
    @Persisted var id: String
    @Persisted var dateStart: Double
    @Persisted var dateFinish: Double
    @Persisted var eventName: String
    @Persisted var eventDescription: String
    
    convenience init(
        id: String,
        dateStart: Double,
        dateFinish: Double,
        eventName: String,
        eventDescription: String
    ) {
        self.init()
        self.id = id
        self.dateStart = dateStart
        self.dateFinish = dateFinish
        self.eventName = eventName
        self.eventDescription = eventDescription
    }
}

// MARK: - Realm Service

final class RealmManager {
    
    // MARK: - Private Properties
    // swiftlint:disable:next force_try
    private let localRealm = try! Realm()
    
    // MARK: - Public Properties
    
    public func saveEvent(
        id: String,
        dateStart: Double,
        dateFinish: Double,
        eventName: String,
        eventDescription: String
    ) {
        let photo = PhotoRealmObject(
            id: id,
            dateStart: dateStart,
            dateFinish: dateFinish,
            eventName: eventName,
            eventDescription: eventDescription
        )
        // swiftlint:disable:next force_try
        try! localRealm.write {
            localRealm.add(photo)
        }
    }
    
    public func getSavedEvents(per date: Date) -> [EventModel] {
        let savedEvents = localRealm.objects(PhotoRealmObject.self).toArray()
        let foundedEvents = savedEvents.filter({
            Calendar.current.isDate(Date(timeIntervalSince1970: $0.dateStart), inSameDayAs: date)
        })
        
        var outputEvents = [EventModel]()
        
        foundedEvents.forEach {
            outputEvents.append(EventModelImpl(
                id: UUID(uuidString: $0.id) ?? UUID(),
                dateStart: Date(timeIntervalSince1970: $0.dateStart),
                dateFinish: Date(timeIntervalSince1970: $0.dateFinish),
                name: $0.eventName,
                description: $0.eventDescription
            ))
        }
        
        return outputEvents
    }
    
    public func deletePhoto(id: String) {
        let savedPhotos = localRealm.objects(PhotoRealmObject.self)
        let predicate = NSPredicate(format: "id == %@", id)
        let findPhoto = savedPhotos.filter(predicate)
        // swiftlint:disable:next force_try
        try! localRealm.write {
            localRealm.delete(findPhoto)
        }
    }
    
}

// MARK: - Results Extension
extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
