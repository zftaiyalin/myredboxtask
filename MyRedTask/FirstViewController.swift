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
            self.requestRewardedVideo()
        }
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
    }
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
//        NSLog(@"admob奖励视频开始播放");
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
//        NSLog(@"Reward based video ad failed to load.");
//        NSLog(@"admob奖励视频加载失败");
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
//        NSLog(@"有效的播放admob奖励视频");
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
//        NSLog(@"点击admo奖励视频准备离开app");
    }
}
