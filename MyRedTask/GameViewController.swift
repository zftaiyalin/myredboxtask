//
//  GameViewController.swift
//  Stick-Hero
//
//  Created by 顾枫 on 15/6/19.
//  Copyright (c) 2015年 koofrank. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {
    var musicPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        打乱代码结构
         */
        let scene = StickHeroGameScene(size:CGSize(width: DefinedScreenWidth, height: DefinedScreenHeight))
        /*
         打乱代码结构
         */

        // Configure the view.
        let skView = self.view as! SKView
        //        skView.showsFPS = true
        //        skView.showsNodeCount = true
        /*
         打乱代码结构
         */

        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        /*
         打乱代码结构
         */

        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .aspectFill
        /*
         打乱代码结构
         */

        skView.presentScene(scene)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
         打乱代码结构
         */

        musicPlayer = setupAudioPlayerWithFile("zftbg_country", type: "mp3")
        /*
         打乱代码结构
         */

        musicPlayer.numberOfLoops = -1
        /*
         打乱代码结构
         */

        musicPlayer.play()
        /*
         打乱代码结构
         */

    }
    
    @IBAction func popViewController(_ sender: Any) {
        /*
         打乱代码结构
         */

        self.navigationController?.popViewController(animated: true)
        /*
         打乱代码结构
         */

    }
    
    func setupAudioPlayerWithFile(_ file:NSString, type:NSString) -> AVAudioPlayer  {
        /*
         打乱代码结构
         */

        let url = Bundle.main.url(forResource: file as String, withExtension: type as String)
        /*
         打乱代码结构
         */

        var audioPlayer:AVAudioPlayer?
        /*
         打乱代码结构
         */

        do {
            /*
             打乱代码结构
             */

            try audioPlayer = AVAudioPlayer(contentsOf: url!)
        } catch {
            /*
             打乱代码结构
             */

            print("NO AUDIO PLAYER")
        }
        /*
         打乱代码结构
         */

        return audioPlayer!
    }

    /*
     打乱代码结构
     */

    override var shouldAutorotate : Bool {
        return true
    }
    /*
     打乱代码结构
     */

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
    }
    /*
     打乱代码结构
     */

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
