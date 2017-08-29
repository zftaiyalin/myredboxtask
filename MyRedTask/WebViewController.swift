//
//  WebViewController.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/29.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit
import GoogleMobileAds
class WebViewController: UIViewController,GADInterstitialDelegate {

    @IBOutlet weak var webView: UIWebView!
//    ca-app-pub-3676267735536366/7929955336
    var interstitial = GADInterstitial.init(adUnitID: Aplication.sharedInstance.appModel.admob.admobOneInter)
//    ca-app-pub-3676267735536366/2147365744
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        // Do any additional setup after loading the view.
        
        self.title = "许可协议"
        self.webView.loadRequest(URLRequest.init(url: URL.init(string: "http://ovfte6tum.bkt.clouddn.com/index.html")!))
        self.interstitial.load(GADRequest())
        self.interstitial.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if self.interstitial.isReady {
            self.interstitial.present(fromRootViewController: self)
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
