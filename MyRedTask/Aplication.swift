//
//  Aplication.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/25.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit

class Aplication: NSObject {
   
        // 单例  全局的数据访问接口
    static let sharedInstance = Aplication()
    var myMoneyList: [MoneyModel]!
    
    override init() {
        super.init()
        if myMoneyList == nil {
            myMoneyList = [MoneyModel]()
        }
    }
    
    
    func saveMoneyList() {
        
    }
    
    func getMoneyList() {
        
    }
    
    
    func myAllPrice() -> Float {
        var allMoney = 0.0
        for item in myMoneyList {
            if !item.isTake {
                allMoney += item.price
            }
        }
        return Float(allMoney)
    }
    
    func backSuijiMoney() -> Float {
        if self.myAllPrice() < 10.0 {
            let temp = Int(arc4random_uniform(100))+1
            
            if temp < 75 {
                return 0.25
            }else{
                return 0.5
            }
            
        }else if self.myAllPrice() < 15.0 {
           
            let temp = Int(arc4random_uniform(100))+1
            
            if temp < 85 {
                return 0.25
            }else{
                return 0.5
            }
        
            
        }else if self.myAllPrice() < 20.0 {
            
            let temp = Int(arc4random_uniform(100))+1
            
            if temp < 90 {
                return 0.25
            }else{
                return 0.5
            }
            
            
        }else if self.myAllPrice() < 25.0 {
            
            let temp = Int(arc4random_uniform(100))+1
            
            if temp < 90 {
                return 0.15
            }else{
                return 0.25
            }
            
            
        }else {
            
          if self.myAllPrice() < 26.0 {
                return 0.1
                
                
          }else if self.myAllPrice() < 27.0 {
            
            return 0.05
            
          } else{
                return 0.01
        }
     }
    }
    
    
}
