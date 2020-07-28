//
//  Model.swift
//  MyAxxessApp
//
//  Created by Sanjay Mohnani on 27/07/20.
//  Copyright © 2020 Sanjay Mohnani. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmS
import RealmSwift

struct Record:  Codable{
    let id : String?
    let type : String?
    let date : String?
    let data : String?
}

class RecordRealm: Object {
    @objc dynamic var id : String? = nil
    @objc dynamic var type : String? = nil
    @objc dynamic var date : String? = nil
    @objc dynamic var data : String? = nil
}
