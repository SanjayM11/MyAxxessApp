//
//  DatabaseManager.swift
//  MyAxxessApp
//
//  Created by Sanjay Mohnani on 28/07/20.
//  Copyright © 2020 Sanjay Mohnani. All rights reserved.
//

import Foundation
import RealmS

class DatabaseManager {
    static let shared = DatabaseManager()
    
    func deleteAllRecordsFromDb() {
        let realm = RealmS()
        realm.write {
            realm.deleteAll()
        }
    }
    
    func saveRecordsInDB(records : [Record]){
        let realm = RealmS()
        realm.write({
            for record in records{
                let realmInstance = RecordRealm()
                realmInstance.id = record.id
                realmInstance.type = record.type
                realmInstance.date = record.date
                realmInstance.data = record.data
                realm.add(realmInstance)
            }
        })
    }
    
    func getRecordsFromDB() -> [Record] {
        let realm = RealmS()
        let realmRecords = realm.objects(RecordRealm.self)
        var records = [Record]()
        for realmRecord in realmRecords{
            let record = Record.init(id: realmRecord.id, type: realmRecord.type, date: realmRecord.date, data: realmRecord.data)
            records.append(record)
        }
        return records
    }
}
