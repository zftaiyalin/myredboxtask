//
//  GameModel.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/9/7.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit

class GameModel: NSObject, NSCoding {
    
    var playGameNum = ""
    var playDate = ""
    
   
    required init(playGameNum:String="", playDate:String="") {
        self.playGameNum = playGameNum
        self.playDate = playDate
    }

    
    //从object解析回来
    required init(coder decoder: NSCoder) {
        self.playGameNum = decoder.decodeObject(forKey: "playGameNum") as? String ?? ""
        self.playDate = decoder.decodeObject(forKey: "playDate") as? String ?? ""
    }
    
    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(playGameNum, forKey:"playGameNum")
        coder.encode(playDate, forKey:"playDate")
    }

}
