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
    var gameModel: GameModel!
    var navigation: UINavigationController!
    var pinglundate: Date!
    var jifen = 0
    var isCommnet = false
    
    
    var appModel: AppModel!
    override init() {
        super.init()
        print("沙盒文件夹路径：\(documentsDirectory())")
        print("数据文件路径：\(dataFilePath())")
        if myMoneyList == nil {
           self.loadData()
        }
    }
    

    func setPinglunStatus() {
        if pinglundate != nil {
            
            let timeOld = pinglundate.timeIntervalSince1970
            let timeNow = Date.init().timeIntervalSince1970
            
            if ( timeNow - timeOld ) > 15 {
                Aplication.sharedInstance.navigation.showSuccessText("权限开启成功")
                UserDefaults.standard.set(true, forKey: "pinglun")
            }else{
                Aplication.sharedInstance.navigation.showErrorText("请认真评论开启权限")
                
            }
            pinglundate = nil
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
        
        if myMoneyList == nil {
            myMoneyList = [MoneyModel]()
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
    
    //获取数据文件地址
    func dataDataFilePath ()->String{
        return self.documentsDirectory().appendingFormat("/gameData.plist")
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
    
    func setNoTake() {
        for item in myMoneyList {
            if !item.isTake {
                item.isTake = true
            }
        }
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
        if self.myAllPrice() < Float(self.appModel.taskLevel.one) {
            let temp = Int(arc4random_uniform(100))+1
            
            if temp < 50 {
                return 0.25
            }else{
                return 0.5
            }
            
        }else if self.myAllPrice() < Float(self.appModel.taskLevel.two) {
           
            let temp = Int(arc4random_uniform(100))+1
            
            if temp < 75 {
                return 0.25
            }else{
                return 0.4
            }
        
            
        }else if self.myAllPrice() < Float(self.appModel.taskLevel.three) {
            
            let temp = Int(arc4random_uniform(100))+1
            
            if temp < 85 {
                return 0.15
            }else{
                return 0.3
            }
            
            
        }else if self.myAllPrice() < Float(self.appModel.taskLevel.four) {
            
            let temp = Int(arc4random_uniform(100))+1
            
            if temp < 90 {
                return 0.15
            }else{
                return 0.25
            }
            
            
        }else {
            
          if self.myAllPrice() < Float(self.appModel.taskLevel.five) {
                return 0.1
                
                
          }else if self.myAllPrice() < Float(self.appModel.taskLevel.six) {
            
            return 0.05
            
          } else{
                return 0.01
        }
     }
    }
    
    
    //保存数据
    func saveGameData() {
        let data = NSMutableData()
        //申明一个归档处理对象
        let archiver = NSKeyedArchiver(forWritingWith: data)
        //将lists以对应Checklist关键字进行编码
        archiver.encode(gameModel, forKey: "GameData")
        //编码结束
        archiver.finishEncoding()
        //数据写入
        data.write(toFile: dataDataFilePath(), atomically: true)
    }
    
    //读取数据
    func loadGameData() {
        //获取本地数据文件地址
        let path = self.dataDataFilePath()
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
            gameModel = unarchiver.decodeObject(forKey: "GameData") as! GameModel
            
            
            //结束解码
            unarchiver.finishDecoding()
        }
        
        if gameModel == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            gameModel = GameModel.init(playGameNum: "5", playDate:  dateFormatter.string(from: Date()))

            self.saveGameData()
        }
    }
  
    func maxGameNum() {
        self.loadGameData()
        if self.gameModel.playGameNum.toInt() < 5 {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let currentDate = dateFormatter.date(from: self.gameModel.playDate)
            
            let old = currentDate?.timeIntervalSince1970
            let now = Date().timeIntervalSince1970
            
            let num: Int = Int( (now - old!) / 600 )
            if (self.gameModel.playGameNum.toInt() + num) > 5 {
                self.gameModel.playGameNum = "5"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                self.gameModel.playDate = dateFormatter.string(from: Date())
            }else{
                self.gameModel.playGameNum = (self.gameModel.playGameNum.toInt() + num).toString()
                self.gameModel.playDate = dateFormatter.string(from: Date())
            }
            
        }
        self.saveGameData()
    }
    
    func judgmentGameMin() -> Bool {

        self.maxGameNum()
        
        if self.gameModel.playGameNum.toInt() > 0  {
            self.gameModel.playGameNum = (self.gameModel.playGameNum.toInt() - 1).toString()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            self.gameModel.playDate = dateFormatter.string(from: Date())
            self.saveGameData()
            return true
        }else{
            return false
        }
    }
}
