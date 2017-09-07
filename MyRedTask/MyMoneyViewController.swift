//
//  MyMoneyViewController.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/25.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit
//import GoogleMobileAds


class MyMoneyViewController: UIViewController {
    @IBOutlet weak var OneYuan: UIView!
    @IBOutlet weak var twoYuan: UIView!
    @IBOutlet weak var tishiLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var TakeButton: UIButton!
    @IBOutlet weak var MoneyButton: UIButton!
    @IBOutlet weak var setButton: UIButton!
    
//    var interstitial = GADInterstitial.init(adUnitID: Aplication.sharedInstance.appModel.admob.admobOneInter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Aplication.sharedInstance.appModel.admob.isComment {
            self.title = "我的红包"
            self.navigationItem.setRightBarButton(UIBarButtonItem.init(title: "红包明细", style: .done, target: self, action: #selector(pushTakeView)), animated: true)
            priceLabel.text = "￥ \(Aplication.sharedInstance.myAllPrice())"
        }else{
            self.title = "我的积分"
            priceLabel.text = "\(Aplication.sharedInstance.myAllPrice())"
        }
        
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]

        
        
        
        if !Aplication.sharedInstance.appModel.admob.isComment {
            setButton.isHidden = true
            tishiLabel.text = "我的游戏总积分"
            TakeButton.setTitle("继续玩游戏", for: .normal)
            MoneyButton.setTitle("积分详情", for: .normal)
        }
        
        self.OneYuan.layer.cornerRadius = 54
            
        self.twoYuan.layer.cornerRadius = 42
        
        
        TakeButton.layer.cornerRadius = 4
        MoneyButton.layer.cornerRadius = 4
        
        
        TakeButton.layer.borderColor = UIColor(rgba: "#209e1f").cgColor
        
        TakeButton.layer.borderWidth = 0.5
        
        MoneyButton.layer.borderColor = UIColor(rgba: "#dfdfdf").cgColor
        
        MoneyButton.layer.borderWidth = 0.5
        
        
        // Do any additional setup after loading the view.
        
//        self.interstitial.load(GADRequest())
//        self.interstitial.delegate = self
    }
    

    
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func pushTakeView() {
        self.navigationController?.pushViewController(TakeMoneyViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tixian(_ sender: Any) {
        if Aplication.sharedInstance.appModel.admob.isComment {
            if Aplication.sharedInstance.myAllPrice() > 30 {
                self.showSuccessText("大神,添加工作微信\(Aplication.sharedInstance.appModel.admob.weixin)提现！")
                
            }else{
                self.showErrorText("超过30元方可提现哦！")
            }
        }else{
            self.navigationController?.pushViewController(TakeMoneyViewController(), animated: true)

        }
        
    }
    
    @IBAction func pushAccount(_ sender: Any) {
        self.navigationController?.pushViewController(MyAccountViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func takeReward(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
//    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
//        if self.interstitial.isReady {
//            self.interstitial.present(fromRootViewController: self)
//        }
//    }
//    
//    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
//        
//    }
//    
//    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
//        
//    }
//    
//    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
//        
//    }
//    
//    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
//        
//    }
//    
//    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
//        
//    }
//    
//    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
//        
//    }

}
