//
//  TakeMoneyViewController.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/25.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit
//import GoogleMobileAds
class TakeMoneyViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
//    var interstitial = GADInterstitial.init(adUnitID: Aplication.sharedInstance.appModel.admob.admobTwoInter)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "红包明细"
        Aplication.sharedInstance.loadData()
        tableView.register(UINib.init(nibName: "MyMoneyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyMoneyTableViewCellID")
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        // Do any additional setup after loading the view.
//        self.interstitial.load(GADRequest())
//        self.interstitial.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Aplication.sharedInstance.myMoneyList == nil ? 0 : Aplication.sharedInstance.myMoneyList.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIn = tableView.dequeueReusableCell(withIdentifier: "MyMoneyTableViewCellID", for: indexPath) as! MyMoneyTableViewCell
        cellIn.loadData(money: Aplication.sharedInstance.myMoneyList.reversed()[indexPath.row])
        cellIn.selectionStyle = .none
        return cellIn
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
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
