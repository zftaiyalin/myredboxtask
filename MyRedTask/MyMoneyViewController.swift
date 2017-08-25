//
//  MyMoneyViewController.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/25.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit

class MyMoneyViewController: UIViewController {
    @IBOutlet weak var OneYuan: UIView!
    @IBOutlet weak var twoYuan: UIView!
    @IBOutlet weak var tishiLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var TakeButton: UIButton!
    @IBOutlet weak var MoneyButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的奖金"
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]

        
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(title: "奖金明细", style: .done, target: self, action: #selector(pushTakeView)), animated: true)
        
        self.OneYuan.layer.cornerRadius = 54
            
        self.twoYuan.layer.cornerRadius = 42
        
        
        TakeButton.layer.cornerRadius = 4
        MoneyButton.layer.cornerRadius = 4
        
        
        TakeButton.layer.borderColor = UIColor.init(hexString: "#209e1f")?.cgColor
        
        TakeButton.layer.borderWidth = 0.5
        
        MoneyButton.layer.borderColor = UIColor.init(hexString: "#dfdfdf")?.cgColor
        
        MoneyButton.layer.borderWidth = 0.5
        
        
        // Do any additional setup after loading the view.
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
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
