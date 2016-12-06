//
//  DateManager.swift
//  
//
//  Created by 溝口健太 on 2016/11/09.
//
//

import UIKit

extension NSDate {
    func monthAgoDate() -> NSDate {
        let addValue = -1
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        let dateComponents = NSDateComponents()
        dateComponents.month = addValue
        return calendar.date(byAdding: dateComponents as DateComponents, to: self as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
    }
    
    func monthLaterDate() -> NSDate {
        let addValue: Int = 1
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        let dateComponents = NSDateComponents()
        dateComponents.month = addValue
        return calendar.date(byAdding: dateComponents as DateComponents, to: self as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
    }
    
}

class DateManager: NSObject {   //ここのコード不安

    var currentMonthOfDates = [NSDate]() //表記する月の配列
    var selectedDate = NSDate()
    let daysPerWeek: Int = 7
    var numberOfItems: Int!
    
    //月ごとのセルの数を返すメソッド
    func daysAcquisition() -> Int {
        let rangeOfWeeks = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth() as Date) //currentは使わなくていいのか？ → currentは言語設定のカレンダーを返す
        let numberOfWeeks = rangeOfWeeks.length //月が持つ週の数
        numberOfItems = numberOfWeeks * daysPerWeek //週の数×列の数
        return numberOfItems
    }
    
    //月の初日を取得
    func firstDateOfMonth() -> NSDate {
        var components = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.components([.year,.month,.day], from: selectedDate as Date)    //as Dateは付けないと通らん letからvarに変更 currentどこいった？
        components.day = 1
        let firstDateMonth = NSCalendar.current.date(from: components)!
        return firstDateMonth as NSDate //NSData型に変えた
    }
    
    func dateForCellAtIndexPath(numberOfItems: Int) {
        // ①「月の初日が週の何日目か」を計算する
        let ordinalityOfFirstDay = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.ordinality(of: .day, in: .weekOfMonth, for: firstDateOfMonth() as Date)  //as Dateは付けないと通らん
        for i in 0 ..< numberOfItems {  //Swift3.0からの変更
            // ②「月の初日」と「indexPath.item番目のセルに表示する日」の差を計算する
            let dateComponents = NSDateComponents()
            dateComponents.day = i - (ordinalityOfFirstDay - 1)
            // ③ 表示する月の初日から②で計算した差を引いた日付を取得
            let date = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.date(byAdding: dateComponents as DateComponents, to: firstDateOfMonth() as Date, options: NSCalendar.Options.init(rawValue: 0))!
            // ④配列に追加
            currentMonthOfDates.append(date as NSDate)  //as NSDate付けてるのは補完
        } 
    }
    
    // ⑵表記の変更
    func conversionDateFormat(indexPath: NSIndexPath) -> String {
        dateForCellAtIndexPath(numberOfItems: numberOfItems)
        let formatter = DateFormatter()     //NSdateFormatterからの変更
        formatter.dateFormat = "d"
        return formatter.string(from: currentMonthOfDates[indexPath.row] as Date)
    }
    
    //前月の表示
    func prevMonth(date: NSDate) -> NSDate {
        currentMonthOfDates = []
        selectedDate = date.monthAgoDate()
        return selectedDate
    }
    //次月の表示
    func nextMonth(date: NSDate) -> NSDate {
        currentMonthOfDates = []
        selectedDate = date.monthLaterDate()
        return selectedDate
    }
}
