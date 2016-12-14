//
//  RealmDB.swift
//  alcManager
//
//  Created by 溝口健太 on 2016/10/27.
//  Copyright © 2016年 溝口健太. All rights reserved.
//

import RealmSwift

class User:Object{
    
    dynamic var id = 0      //オブジェクトの初期値
    dynamic var day = ""
    dynamic var value = 0.0
    
    override static func primaryKey() -> String? {    //primaryキーの設定
        return "id"
    }
    
    func createNewUser(day: String, value: Double, id: Int) {
        let realm = try! Realm()
        let user = User()
        let search = realm.objects(User.self).filter("day = %@",day)
        //var b = 0.0
        print("searchの結果 ",search)
        //print("search.last",search.last)
        /*for a in search{
            print("aの中身",a)
            if realm.object(ofType: User.self, forPrimaryKey: a.id)?.day == a.day{
                print("a.dayを発見",a.day)
                b = a.value
                user.value = value + b
            }else{
                user.value = value
            }
        }
        print("user.value = ",user.value)*/
        user.day = day
        user.value = value
        print("add後のuser.value",user.value)
        user.id = id
        print("addするuser",user)
        //let realm = try! Realm()
            try! realm.write{ realm.add(user, update: true) }
    }
    
    func deleteUser(id: Int){
        let realm = try! Realm()
        let user = realm.object(ofType: User.self, forPrimaryKey: id)
        print("id = ",id)
        print("消されちゃうuser",user)
        if id >= 0{
            try! realm.write{ realm.delete(user!) }
        }
    }
}
