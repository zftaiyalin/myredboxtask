//
//  MyAccountViewController.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/28.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {
    @IBOutlet weak var zhifubao: UIButton!
    @IBOutlet weak var weixin: UIButton!

    @IBAction func tapZhifu(_ sender: Any) {
        let cr = SettingMyAccountViewController()
        cr.isWeiXin = false
        self.navigationController?.pushViewController(cr, animated: true)
    }

    @IBAction func tapWeixin(_ sender: Any) {
        
        let cr = SettingMyAccountViewController()
        cr.isWeiXin = true
        self.navigationController?.pushViewController(cr, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "账户设置"
        self.view.clipsToBounds = true
        self.zhifubao.layer.borderColor = UIColor.init(hexString: "#dfdfdf")?.cgColor
        self.weixin.layer.borderColor = UIColor.init(hexString: "#dfdfdf")?.cgColor
        self.zhifubao.layer.borderWidth = 0.3
        self.weixin.layer.borderWidth = 0.3
        
        // Do any additional setup after loading the view.
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
