//
//  MyMoneyTableViewCell.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/25.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit

class MyMoneyTableViewCell: UITableViewCell {

    @IBOutlet weak var duiLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadData(money: MoneyModel) {
        self.priceLabel.text = "+ \(money.price)"
        self.timeLabel.text = money.time
        if money.isTake {
            duiLabel.text = "已兑换"
            duiLabel.textColor = UIColor.red
        }else{
            duiLabel.text = "未兑换"
            duiLabel.textColor = UIColor.init(hexString: "#00BE00")
        }
    }
    
}
