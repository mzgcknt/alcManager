//
//  alcTypeCell.swift
//  alcManager
//
//  Created by 溝口健太 on 2016/12/10.
//  Copyright © 2016年 溝口健太. All rights reserved.
//

import UIKit

class alcTypeCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(imageNames:String,alcoholType:String,alcAmount:String){ //画像.タイトルの設定
        iconImage.image = UIImage(named: imageNames)
        name.text = alcoholType
        amount.text = alcAmount
     }
}
