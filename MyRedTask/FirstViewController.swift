//
//  FirstViewController.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/23.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit
//import GoogleMobileAds

class FirstViewController: UIViewController,UIAlertViewDelegate {

    @IBOutlet weak var yindaoView: UIView!
    @IBOutlet weak var xieyiTLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var xieyiLabel: UILabel!
    @IBOutlet weak var xieyiButton: UIButton!
    @IBOutlet weak var lastLine: UIView!
    var timeIndex = 0
    var currentPrice = 0.0
    var isReward = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yindaoView.isHidden = true
        if Aplication.sharedInstance.appModel.admob.isComment {
            self.title = "抢红包"
        }else{
            self.title = "得积分"
            xieyiTLabel.isHidden = true
            xieyiLabel.isHidden = true
            xieyiButton.isHidden = true
        }
        
        // Do any additional setup after loading the view.
        
        let userDefaults = UserDefaults.standard
    
        if !userDefaults.bool(forKey: "yindao") && Aplication.sharedInstance.appModel.admob.isComment{
                userDefaults.set(true, forKey: "yindao")
                self.yindaoView.isHidden = false
        }
        
    
        mainButton.layer.borderColor = UIColor.white.cgColor
        mainButton.layer.borderWidth = 5
        mainButton.layer.cornerRadius = 60
//        "ca-app-pub-3676267735536366/8592596428"
        
//        bannerView.adUnitID = Aplication.sharedInstance.appModel.admob.admobBanr
//        bannerView.rootViewController = self
//
//        let request: GADRequest = GADRequest()
//        request.testDevices = [""]
//        bannerView.load(request)
        if Aplication.sharedInstance.appModel.admob.isComment {
            priceLabel.text = "今日共抢：￥ \(Aplication.sharedInstance.myAllTodayPrice())"
           
        }else{
            priceLabel.text = "今日共得：\(Aplication.sharedInstance.myAllTodayPrice())分"
             mainButton.setTitle("玩", for: .normal)
            shareButton.setTitle("分享游戏", for: .normal)
            gameButton.setTitle("游戏得分", for: .normal)
            pushRedBox.setTitle("游戏得分", for: .normal)
            pushRedBox.isHidden = true
            twoLabel.text = "点击上方按钮开始游戏吧。"
            lastLine.isHidden = true
        }
        
        TGSDK.setDebugModel(true)
        TGSDK.preloadAd(self)
        TGSDK.setADDelegate(self)
        TGSDK.setRewardVideoADDelegate(self)
//        TGSDK.
    }

    @IBAction func shareWeiXin(_ sender: Any) {
        
        self.showShareView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tapXiexi(_ sender: Any) {
        self.navigationController?.pushViewController(WebViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        
        if Aplication.sharedInstance.appModel.admob.isComment {
            priceLabel.text = "今日共抢：￥ \(Aplication.sharedInstance.myAllTodayPrice())"
            
        }else{
            priceLabel.text = "今日共得：\(Aplication.sharedInstance.myAllTodayPrice())分"
       
            
            Aplication.sharedInstance.maxGameNum()
            
            
            oneLabel.text = "你还有\(Aplication.sharedInstance.gameModel.playGameNum)次游戏机会，每隔10分钟自动增加1次游戏机会哦。"
        }
        
        
    }
    
    
    public func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int){
        
        if alertView.tag == 10000{
            if buttonIndex == 1 {
                let userDefaults = UserDefaults.standard
                userDefaults.set(true, forKey: "tishi")
            }
            if TGSDK.couldShowAd(Aplication.sharedInstance.appModel.admob.admobReVideo) {
                TGSDK.showAd(Aplication.sharedInstance.appModel.admob.admobReVideo)
            }else{
                TGSDK.showAd(Aplication.sharedInstance.appModel.admob.admobReVideo)
                self.showText("正在加载任务视频~~")
            }
        }else if alertView.tag == 10010{
            if buttonIndex == 1 {
            if TGSDK.couldShowAd(Aplication.sharedInstance.appModel.admob.admobReVideo) {
                TGSDK.showAd(Aplication.sharedInstance.appModel.admob.admobReVideo)
            }else{
                TGSDK.showAd(Aplication.sharedInstance.appModel.admob.admobReVideo)
                self.showText("正在加载任务视频~~")
            }
            }
        }else{
            if buttonIndex == 1 {
                
                let str = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1276938626&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
                
                UIApplication.shared.openURL(URL.init(string: str)!)
                
                
                Aplication.sharedInstance.pinglundate = Date()
                
            }
        }
        
    }

    
    func openReward() {
        
        let queue = DispatchQueue.global(qos: .default)
        
        queue.async(execute: {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let currentDateString = dateFormatter.string(from: Date())
            
            let money = MoneyModel.init(isTake: false, time: currentDateString, price: self.currentPrice)
            Aplication.sharedInstance.myMoneyList.append(money)
            Aplication.sharedInstance.saveData()
            let price = Aplication.sharedInstance.myAllTodayPrice()
            
            DispatchQueue.main.sync(execute: {
                
                 self.currentPrice = 0.0
                 self.priceLabel.text = "今日共抢：￥ \(price)"
            })
        })
    }
    
    
    func shareSuccess() {
        
        //分享成功
        let userDefaults = UserDefaults.standard
        
        if !userDefaults.bool(forKey: "share"){
                userDefaults.set(true, forKey: "share")

            let info = RewardInfo.init()
            currentPrice = Double(2.0)
            info.money         = Float(currentPrice);
            info.rewardName    = "获得分享红包了！😊😊";
            info.rewardContent = "恭喜你得到红包~";
            info.rewardStatus  = 0;
            
            self.initRedPacketWindow(info)
            
        }

        
       
        
    }
    func shareButtonPress() {
        self.cancelButtonClicked()
        if !UserDefaults.standard.bool(forKey: "pinglun" ) && Aplication.sharedInstance.appModel.admob.isComment
        {
            let infoAlert = UIAlertView.init(title: "五星好评", message: "五星好评开启任务权限，即可享受随时随地做任务赚零用钱。", delegate: self, cancelButtonTitle: "取消")
            infoAlert.addButton(withTitle: "去评价")
            infoAlert.tag = 10086
            infoAlert.show()
            return
        }
        
        
        let userDefaults = UserDefaults.standard
        if !userDefaults.bool(forKey: "tishi"){
            let infoAlert = UIAlertView.init(title: "提示", message: "请您完整观看即将播出的视频，不要快进/快退或则中退出，否则您将无法获得相应的奖励", delegate: self, cancelButtonTitle: "好")
            infoAlert.tag = 10000
            infoAlert.addButton(withTitle: "不再提示")
            infoAlert.show()
            
            
        }else{
            if TGSDK.couldShowAd(Aplication.sharedInstance.appModel.admob.admobReVideo) {
                TGSDK.showAd(Aplication.sharedInstance.appModel.admob.admobReVideo)
            }else{
                TGSDK.showAd(Aplication.sharedInstance.appModel.admob.admobReVideo)
                self.showText("正在加载任务视频~~")
            }
        }
        
    }
    
    @IBAction func guanbiyindao(_ sender: Any) {
        
        self.yindaoView.isHidden = true
        
        let info = RewardInfo.init()
        currentPrice = Double(3.0)
        info.money         = Float(currentPrice);
        info.rewardName    = "获得首次登录红包了！😊😊";
        info.rewardContent = "恭喜你得到红包~";
        info.rewardStatus  = 0;
        
        self.initRedPacketWindow(info)
    }
//    广告单元名称： 激励
//    广告单元 ID： ca-app-pub-3676267735536366/8535443029
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func tapQiang(_ sender: Any) {
        
        if !Aplication.sharedInstance.appModel.admob.isComment {
            
            if Aplication.sharedInstance.judgmentGameMin()  {

                let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                //将取出的storyboard里面的控制器被所需的控制器指着。
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "StickHeroBoard")
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let infoAlert = UIAlertView.init(title: "提示", message: "没有游戏次数了，您可以选择观看广告马上获取一次生命，或则稍等几分钟再来游戏", delegate: self, cancelButtonTitle: "等待")
                infoAlert.addButton(withTitle: "看广告")
                infoAlert.tag = 10010
                infoAlert.show()
            }
            return
        }
        
        
        if !UserDefaults.standard.bool(forKey: "pinglun" ) && Aplication.sharedInstance.appModel.admob.isComment
        {
            let infoAlert = UIAlertView.init(title: "五星好评", message: "五星好评开启任务权限，即可享受随时随地做任务赚零用钱。", delegate: self, cancelButtonTitle: "取消")
            infoAlert.addButton(withTitle: "去评价")
            infoAlert.tag = 10086
            infoAlert.show()
            return
        }
        
        
        let userDefaults = UserDefaults.standard
        if !userDefaults.bool(forKey: "tishi"){
            let infoAlert = UIAlertView.init(title: "提示", message: "请您完整观看即将播出的视频，不要快进/快退或则中退出，否则您将无法获得相应的奖励", delegate: self, cancelButtonTitle: "好")
            infoAlert.tag = 10000
            infoAlert.addButton(withTitle: "不再提示")
            infoAlert.show()
            
            
        }else{
            if Aplication.sharedInstance.appModel != nil {
            if TGSDK.couldShowAd(Aplication.sharedInstance.appModel.admob.admobReVideo) {
                TGSDK.showAd(Aplication.sharedInstance.appModel.admob.admobReVideo)
            }else{
                TGSDK.showAd(Aplication.sharedInstance.appModel.admob.admobReVideo)
                self.showText("正在加载任务视频~~")
            }
            }
        }
        

    }
    @IBAction func pushMyMoney(_ sender: Any) {
        self.navigationController?.pushViewController(MyMoneyViewController(), animated: true)
    }
    @IBOutlet weak var pushRedBox: UIButton!

    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var gameButton: UIButton!
    @IBAction func pushGame(_ sender: Any) {
        if Aplication.sharedInstance.appModel.admob.isComment {
          
                let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                //将取出的storyboard里面的控制器被所需的控制器指着。
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "StickHeroBoard")
                self.navigationController?.pushViewController(vc, animated: true)
           
        }else{
            
            self.navigationController?.pushViewController(MyMoneyViewController(), animated: true)
            
        }
        
        
        
    }
    
}
extension FirstViewController:TGPreloadADDelegate,TGRewardVideoADDelegate,TGADDelegate{
    
    func onPreloadSuccess(_ result: String?) {
        // 广告预加载调用成功
    }
    
    func onPreloadFailed(_ result: String?, withError error: Error?) {
        // 广告预加载调用失败
    }
    
    func onCPADLoaded(_ result: String) {
        // 静态插屏广告已就绪
        
    }
    
    
    func onVideoADLoaded(_ result: String) {
        // 视频广告已就绪
//         self.dismissLoading()
//        TGSDK.showAd("Wk3OlqsRSBddoQY4LzP")
    }
    func onShowSuccess(_ result: String) {
        // 广告开始播放
        self.dismissLoading()
    }
    
    func onShowFailed(_ result: String, withError error: Error?) {
        // 广告播放失败
        if Aplication.sharedInstance.appModel.admob.isComment {
            self.showErrorText("任务正在加载中请重新点击")
        }else{
            self.showErrorText("正在加载中请重新点击")
        }
    }
    func onADComplete(_ result: String) {
        // 广告播放完成
    }
    
    func onADClose(_ result: String) {
        // 广告关闭
        if Aplication.sharedInstance.appModel.admob.isComment {
            if isReward == true {
                isReward = false
            
                let info = RewardInfo.init()
                currentPrice = Double(Aplication.sharedInstance.backSuijiMoney())
                info.money         = Float(currentPrice);
                info.rewardName    = "获得红包了！😊😊";
                info.rewardContent = "恭喜你得到红包~";
                info.rewardStatus  = 0;
            
                self.initRedPacketWindow(info)
            }
        }

    }
    func onADClick(_ result: String) {
        // 用户点击了广告，正在跳转到其他页面
    }
    
    func onADAwardSuccess(_ result: String) {
        // 奖励广告条件达成，可以向用户发放奖励
        if Aplication.sharedInstance.appModel.admob.isComment {
            isReward = true
        }else{
            self.showSuccessText("获得1次游戏次数")
//            var highScore = UserDefaults.standard.integer(forKey: gameNum)
//        
//            highScore = highScore + 1
//            UserDefaults.standard.set(highScore, forKey: gameNum)
//            UserDefaults.standard.synchronize()
            
            Aplication.sharedInstance.loadGameData()
            if Aplication.sharedInstance.gameModel.playGameNum.toInt() < 5 {
                Aplication.sharedInstance.gameModel.playGameNum = (Aplication.sharedInstance.gameModel.playGameNum.toInt() + 1).toString()
                Aplication.sharedInstance.saveGameData()
            }else{
                self.showErrorText("您的游戏次数已经是最大值了不能再增加了。")
            }
            
            
            oneLabel.text = "你还有\(Aplication.sharedInstance.gameModel.playGameNum)次游戏机会，每隔10分钟自动增加1次游戏机会哦。"

        }
    }
    
    func onADAwardFailed(_ result: String, withError error: Error?) {
        // 奖励广告条件未达成，无法向用户发放奖励
         self.showErrorText("红包任务失败")
    }
    

}
//extension FirstViewController:GADRewardBasedVideoAdDelegate{
//    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
////        NSLog(@"Opened reward based video ad.");
//    }
//    
//    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
////        NSLog(@"关闭admob奖励视频");
//        
//        if isReward == true {
//            isReward = false
//            
//            let info = RewardInfo.init()
//            currentPrice = Double(Aplication.sharedInstance.backSuijiMoney())
//            info.money         = Float(currentPrice);
//            info.rewardName    = "获得红包了！😊😊";
//            info.rewardContent = "恭喜你得到红包~";
//            info.rewardStatus  = 0;
//            
//            self.initRedPacketWindow(info)
//            
//        }
//    }
//    
//    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
////        NSLog(@"Reward based video ad is received.");
//        self.dismissLoading()
//        if GADRewardBasedVideoAd.sharedInstance().isReady {
//            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
//        }else{
//            self.showText("正在获取红包视频...")
//            self.requestRewardedVideo()
//        }
//    }
//    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
////        NSLog(@"admob奖励视频开始播放");
//    }
//    
//    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
////        NSLog(@"Reward based video ad failed to load.");
////        NSLog(@"admob奖励视频加载失败");
//        self.showErrorText("视频加载失败")
//     
//    }
//    
//    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
////        NSLog(@"有效的播放admob奖励视频");
//  
//       
//        
//        isReward = true
//    }
//    
//    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
////        NSLog(@"点击admo奖励视频准备离开app");
//    }
//}
