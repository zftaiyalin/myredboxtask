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

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var mainButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        self.requestRewardedVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
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
//        NSLog(@"中途关闭admob奖励视频");
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
        
        let money = MoneyModel()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDateString = dateFormatter.string(from: Date.init())
        money.time = currentDateString
        money.price = Double(Aplication.sharedInstance.backSuijiMoney())
        
        Aplication.sharedInstance.myMoneyList.append(money)
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
//        NSLog(@"有效的播放admob奖励视频");
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
//        NSLog(@"点击admo奖励视频准备离开app");
    }
}
