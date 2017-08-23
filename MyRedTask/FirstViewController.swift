//
//  FirstViewController.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/23.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var mainButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mainButton.layer.borderColor = UIColor.white.cgColor
        mainButton.layer.borderWidth = 5
        mainButton.layer.cornerRadius = 60
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
