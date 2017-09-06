//
//  ViewController.swift
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/23.
//  Copyright © 2017年 曾富田. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mainButton.layer.borderColor = UIColor.white.cgColor
        mainButton.layer.borderWidth = 5
        mainButton.layer.cornerRadius = 60
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

