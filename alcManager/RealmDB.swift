//
//  RealmDB.swift
//  alcManager
//
//  Created by 溝口健太 on 2016/10/27.
//  Copyright © 2016年 溝口健太. All rights reserved.
//

import RealmSwift

class User:Object{      //間に合えばマイグレーションの処理
    
    dynamic var id = 0
    dynamic var day = ""
    dynamic var value = 0.0
    
    override static func primaryKey() -> String? {    //primaryキーの設定
        return "id"
    }
    
    func createNewUser(day: String, value: Double, id: Int) {
        
        let user = User()
        user.day = day
        user.value = value
        user.id = id
        
        let realm = try! Realm()
        try! realm.write{ realm.add(user, update: true) }
    }
}
