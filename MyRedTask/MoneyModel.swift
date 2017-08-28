//
//  MoneyModel.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/25.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit

class MoneyModel: NSObject, NSCoding {
    
    var isTake = false
    var time = ""
    var price = ""
    //构造方法
    required init(isTake:Bool=false, time:String="", price:Double=0.0) {
        self.isTake = isTake
        self.time = time
        self.price = "\(price)"
    }

    //从object解析回来
    required init(coder decoder: NSCoder) {
        self.isTake = decoder.decodeObject(forKey: "isTake") as? Bool ?? false
        self.time = decoder.decodeObject(forKey: "time") as? String ?? ""
        self.price = decoder.decodeObject(forKey: "price") as? String ?? ""
    }
    
    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(isTake, forKey:"isTake")
        coder.encode(time, forKey:"time")
        coder.encode(price, forKey:"price")
    }
}
