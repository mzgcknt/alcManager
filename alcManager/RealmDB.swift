//
//  RealmDB.swift
//  alcManager
//
//  Created by 溝口健太 on 2016/10/27.
//  Copyright © 2016年 溝口健太. All rights reserved.
//

import RealmSwift

class User:Object{
    
    dynamic var id = 0
    dynamic var name = ""
    
    /*override static func primaryKey() -> String? {    //とりあえずprimaryキーを付ける
        return "id"
    }*/
    
}
