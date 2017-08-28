//
//  FirstViewController.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/23.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FirstViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var mainButton: UIButton!
    
    var isReward = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "抢红包"
        // Do any additional setup after loading the view.
    
        mainButton.layer.borderColor = UIColor.white.cgColor
        mainButton.layer.borderWidth = 5
        mainButton.layer.cornerRadius = 60
//        "ca-app-pub-3676267735536366/8592596428"
        
        bannerView.adUnitID = "ca-app-pub-3676267735536366/4223695332"
        bannerView.rootViewController = self

        let request: GADRequest = GADRequest()
        request.testDevices = [""]
        bannerView.load(request)
        
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        
//        self.requestRewardedVideo()
        
        priceLabel.text = "今日共抢：￥ \(Aplication.sharedInstance.myAllTodayPrice())"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        
        
      
    }
    
    func openReward() {
        
        let queue = DispatchQueue.global(qos: .default)
        
        queue.async(execute: {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let currentDateString = dateFormatter.string(from: Date())
            
            let money = MoneyModel.init(isTake: false, time: currentDateString, price: Double(Aplication.sharedInstance.backSuijiMoney()))
            Aplication.sharedInstance.myMoneyList.append(money)
            Aplication.sharedInstance.saveData()
            let price = Aplication.sharedInstance.myAllTodayPrice()
            
            DispatchQueue.main.sync(execute: {
                
                 self.priceLabel.text = "今日共抢：￥ \(price)"
            })
        })
    }
    
    func shareButtonPress() {
        self.cancelButtonClicked()
        if GADRewardBasedVideoAd.sharedInstance().isReady {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }else{
            self.showText("正在获取红包视频...")
            self.requestRewardedVideo()
        }
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
        if GADRewardBasedVideoAd.sharedInstance().isReady {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }else{
            self.showText("正在获取红包视频...")
            self.requestRewardedVideo()
        }
    }
    @IBAction func pushMyMoney(_ sender: Any) {
        self.navigationController?.pushViewController(MyMoneyViewController(), animated: true)
    }
    @IBOutlet weak var pushRedBox: UIButton!

    @IBAction func shareGame(_ sender: Any) {
    }
    @IBAction func pushGame(_ sender: Any) {
        
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        //将取出的storyboard里面的控制器被所需的控制器指着。
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "StickHeroBoard")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func requestRewardedVideo() {
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest()
            , withAdUnitID: "ca-app-pub-3676267735536366/3810493335")
    }
}

extension FirstViewController:GADRewardBasedVideoAdDelegate{
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
//        NSLog(@"Opened reward based video ad.");
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
//        NSLog(@"关闭admob奖励视频");
        
        if isReward == true {
            isReward = false
            
            let info = RewardInfo.init()
            info.money         = Float((Aplication.sharedInstance.myMoneyList.last?.price)!)!;
            info.rewardName    = "获得红包了！😊😊";
            info.rewardContent = "恭喜你得到红包~";
            info.rewardStatus  = 0;
            
            self.initRedPacketWindow(info)
            
        }
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
//        NSLog(@"Reward based video ad is received.");
        self.dismissLoading()
        if GADRewardBasedVideoAd.sharedInstance().isReady {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }else{
            self.showText("正在获取红包视频...")
            self.requestRewardedVideo()
        }
    }
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
//        NSLog(@"admob奖励视频开始播放");
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
//        NSLog(@"Reward based video ad failed to load.");
//        NSLog(@"admob奖励视频加载失败");
        self.showErrorText("视频加载失败")
     
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
//        NSLog(@"有效的播放admob奖励视频");
  
       
        
        isReward = true
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
//        NSLog(@"点击admo奖励视频准备离开app");
    }
}
