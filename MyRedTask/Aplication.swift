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
        print("沙盒文件夹路径：\(documentsDirectory())")
        print("数据文件路径：\(dataFilePath())")
        if myMoneyList == nil {
            myMoneyList = [MoneyModel]()
        }
    }
    


    
    //保存数据
    func saveData() {
        let data = NSMutableData()
        //申明一个归档处理对象
        let archiver = NSKeyedArchiver(forWritingWith: data)
        //将lists以对应Checklist关键字进行编码
        archiver.encode(myMoneyList, forKey: "MoneyList")
        //编码结束
        archiver.finishEncoding()
        //数据写入
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    //读取数据
    func loadData() {
        //获取本地数据文件地址
        let path = self.dataFilePath()
        //声明文件管理器
        let defaultManager = FileManager()
        //通过文件地址判断数据文件是否存在
        if defaultManager.fileExists(atPath: path) {
            //读取文件数据
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            //解码器
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            //通过归档时设置的关键字Checklist还原lists
            myMoneyList = unarchiver.decodeObject(forKey: "MoneyList") as! Array
            //结束解码
            unarchiver.finishDecoding()
        }
    }
    
    //获取沙盒文件夹路径
    func documentsDirectory()->String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask, true)
        let documentsDirectory = paths.first!
        return documentsDirectory
    }
    
    //获取数据文件地址
    func dataFilePath ()->String{
        return self.documentsDirectory().appendingFormat("/userList.plist")
    }
    
    func myAllPrice() -> Float {
        
        self.loadData()
        var allMoney = 0.0
        for item in myMoneyList {
            if !item.isTake {
                allMoney += Double(item.price)!
            }
        }
        return Float(allMoney)
    }
    
    func myAllTodayPrice() -> Float {
        
        self.loadData()
        var allMoney = 0.0
        for item in myMoneyList {
            if !item.isTake && self.isToday(time: item.time){
                allMoney += Double(item.price)!
            }
        }
        return Float(allMoney)
    }
    
    func isToday(time: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: Date())
        let count = time.components(separatedBy: currentDateString).count
        if count > 1 {
            return true
        }else{
            return false
        }
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
