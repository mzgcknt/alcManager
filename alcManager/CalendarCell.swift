//
//  CalendarCell.swift
//  alcManager
//
//  Created by 溝口健太 on 2016/10/27.
//  Copyright © 2016年 溝口健太. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {      //ここを自作セルにしないといけないっぽい
    
    var textLabel:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // UILabelを生成
        textLabel = UILabel(frame: CGRect(x:0, y:0, width:self.frame.width, height:self.frame.height))
        textLabel.font = UIFont(name: "HiraKakuProN-W3", size: 12)      //書式設定
        textLabel.textAlignment = NSTextAlignment.center
        // Cellに追加
        self.addSubview(textLabel!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
}
