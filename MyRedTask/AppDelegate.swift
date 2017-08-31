//
//  AppDelegate.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/23.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,ScrollViewControllerDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        UMSocialManager.default().openLog(true)
        
        UMSocialManager.default().umSocialAppkey = "59a76d0c4ad1562e4b000053"
        
        self.confitUShareSettings()
        
                TGSDK.initialize("d9m7OVx521c2651OX0YM") { ( success, tag, dic) in
                    if success {
                        print("yomob注册成功")
                    }else{
                     print("yomob注册失败")
                    }
                }
    
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let currentDateString = dateFormatter.string(from: Date.init())
        let ss = "http://ovfte6tum.bkt.clouddn.com/myredtask.json?v=" + currentDateString
        let xcfURL = URL.init(string: ss)
        
        var content:String!
        do {
            content = try String(contentsOf:xcfURL!)
        }
        catch let error {
            // Error handling
            print(error)
        }
        if content != nil {
            let model = AppModel.yy_model(withJSON: content)
            Aplication.sharedInstance.appModel = model
        }
        
        let userDefaults = UserDefaults.standard
        
        if !userDefaults.bool(forKey: "isNoFirstLaunch"){
            userDefaults.set(true, forKey: "isNoFirstLaunch")
            setFirstView()
            }else{
                    let nvc = UINavigationController.init(rootViewController: FirstViewController())
                    window?.rootViewController = nvc
                    window?.makeKeyAndVisible()
                }
        
        
        return true
    }
    
    func confitUShareSettings() {
        UMSocialManager.default().setPlaform(.wechatSession, appKey: "wx4c4063090a2eff0a", appSecret: "wx4c4063090a2eff0a", redirectURL: nil)
    }
    
    func setFirstView() {
        let vc = ScrollViewController()
        vc.delegate = self
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
    }
    
    func pushMainView(){
        let nvc = UINavigationController.init(rootViewController: FirstViewController())
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = UMSocialManager.default().handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
        
        if !result {
            // 其他如支付等SDK的回调
        }
        
        return result
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

