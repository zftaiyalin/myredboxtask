//
//  SettingMyAccountViewController.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/28.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit

class SettingMyAccountViewController: UIViewController {
    var isWeiXin = false
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var contentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.clipsToBounds = true
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(title: "确定", style: .done, target: self, action: #selector(changeZhanghu)), animated: true)
        // Do any additional setup after loading the view.
        
        
        if !isWeiXin {
            self.title = "支付宝"
            self.contentLabel.text = "请输入已经实名认证的支付宝账户，未实名认证会导致转账提现失败。申请提现后，奖金会在3个工作日内转账到支付宝账户，请确保账号填写正确。"
            self.textField.placeholder = "填写正确的支付宝账号"
            if let weixin = UserDefaults.standard.string(forKey: "zhifubao") {
                
                self.textField.text = weixin
            }
        }else{
            self.title = "微信"
            self.contentLabel.text = "请输入正确的微信账号，申请提现后，工作人员会添加您为好友，请务必通过。奖金会在3个工作日内通过微信现金红包发放。"
            self.textField.placeholder = "填写正确的微信账号"
            if let zhifubao = UserDefaults.standard.string(forKey: "weixin") {
                
                self.textField.text = zhifubao
            }
        }
    }
    
    func changeZhanghu() {
        
        if (self.textField.text?.characters.count)! == 0{
            return
        }
        
        if self.isWeiXin {
            
            if let weixin = UserDefaults.standard.string(forKey: "weixin") {
                
                self.showSuccessText("微信账号修改成功")
            }else{
               
                self.showSuccessText("添加微信账号成功")
            }
            UserDefaults.standard.set(self.textField.text, forKey: "weixin")
            UserDefaults.standard.synchronize()
        }else{
            if let zhifubao = UserDefaults.standard.string(forKey: "zhifubao") {
                
                self.showSuccessText("支付宝账号修改成功")
            }else{
                
                self.showSuccessText("添加支付宝账号成功")
            }
            UserDefaults.standard.set(self.textField.text, forKey: "zhifubao")
            UserDefaults.standard.synchronize()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
