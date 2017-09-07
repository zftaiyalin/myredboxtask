//
//  StickHeroGameScene.swift
//  Stick-Hero
//
//  Created by 顾枫 on 15/6/19.
//  Copyright © 2015年 koofrank. All rights reserved.
//

import SpriteKit

let StoreScoreName = "com.stickHero.score"
let gameNum = "com.stickHero.gameNum"

class StickHeroGameScene: SKScene, SKPhysicsContactDelegate {
    struct GAP { /*
         打乱代码结构
         */

        static let XGAP:CGFloat = 20
        /*
         打乱代码结构
         */

        static let YGAP:CGFloat = 4
    }
    /*
     打乱代码结构
     */

    var gameOver = false {
        willSet {
            /*
             打乱代码结构
             */

            if (newValue) {
                /*
                 打乱代码结构
                 */

                
                
                zftcheckHighScoreAndStore()
                /*
                 打乱代码结构
                 */

                let gameOverLayer = childNode(withName:
                    StickHeroGameSceneChildName.GameOverLayerName.rawValue) as SKNode?
                /*
                 打乱代码结构
                 */

                gameOverLayer?.run(SKAction.moveDistance(CGVector(dx: 0, dy: 100), fadeInWithDuration: 0.2))
                /*
                 打乱代码结构
                 */

            }
            
        }
    }
    /*
     打乱代码结构
     */

    let StackHeight:CGFloat = 400.0
    /*
     打乱代码结构
     */

    let StackMaxWidth:CGFloat = 300.0
    /*
     打乱代码结构
     */

    let StackMinWidth:CGFloat = 100.0
    /*
     打乱代码结构
     */

    let gravity:CGFloat = -100.0
    /*
     打乱代码结构
     */

    let StackGapMinWidth:Int = 80
    /*
     打乱代码结构
     */

    let HeroSpeed:CGFloat = 760
    /*
     打乱代码结构
     */

    
    /*
     打乱代码结构
     */

    var isBegin = false
    /*
     打乱代码结构
     */
    var isEnd = false
    /*
     打乱代码结构
     */
    var leftStack:SKShapeNode?
    /*
     打乱代码结构
     */
    var rightStack:SKShapeNode?
    /*
     打乱代码结构
     */
    var nextLeftStartX:CGFloat = 0
    /*
     打乱代码结构
     */
    var stickHeight:CGFloat = 0
    /*
     打乱代码结构
     */
    var score:Int = 0 {
        willSet {
            /*
             打乱代码结构
             */
            let scoreBand = childNode(withName: StickHeroGameSceneChildName.ScoreName.rawValue) as? SKLabelNode
            /*
             打乱代码结构
             */
            scoreBand?.text = "\(newValue)"
            /*
             打乱代码结构
             */
            scoreBand?.run(SKAction.sequence([SKAction.scale(to: 1.5, duration: 0.1), SKAction.scale(to: 1, duration: 0.1)]))
            /*
             打乱代码结构
             */
            if (newValue == 1) {
                let tip = childNode(withName: StickHeroGameSceneChildName.TipName.rawValue) as? SKLabelNode
                tip?.run(SKAction.fadeAlpha(to: 0, duration: 0.4))
            }
            /*
             打乱代码结构
             */
        }
    }
    
    lazy var playAbleRect:CGRect = {
        /*
         打乱代码结构
         */
        let maxAspectRatio:CGFloat = 16.0/9.0 // iPhone 5"
        let maxAspectRatioWidth = self.size.height / maxAspectRatio
        /*
         打乱代码结构
         */
        let playableMargin = (self.size.width - maxAspectRatioWidth) / 2.0
        /*
         打乱代码结构
         */
        return CGRect(x: playableMargin, y: 0, width: maxAspectRatioWidth, height: self.size.height)
        }()
    /*
     打乱代码结构
     */
    lazy var walkAction:SKAction = {
        var textures:[SKTexture] = []
        for i in 0...1 {
            /*
             打乱代码结构
             */
            let texture = SKTexture(imageNamed: "human\(i + 1).png")
            /*
             打乱代码结构
             */
            textures.append(texture)
            /*
             打乱代码结构
             */
        }
        /*
         打乱代码结构
         */
        let action = SKAction.animate(with: textures, timePerFrame: 0.15, resize: true, restore: true)
        /*
         打乱代码结构
         */
        return SKAction.repeatForever(action)
        }()
    /*
     打乱代码结构
     */
    //MARK: - override
    override init(size: CGSize) {
        super.init(size: size)
        /*
         打乱代码结构
         */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        /*
         打乱代码结构
         */
        physicsWorld.contactDelegate = self
        /*
         打乱代码结构
         */
    }

    override func didMove(to view: SKView) {
        /*
         打乱代码结构
         */
        zftstart()
        /*
         打乱代码结构
         */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !gameOver else {
            /*
             打乱代码结构
             */
            let gameOverLayer = childNode(withName: StickHeroGameSceneChildName.GameOverLayerName.rawValue) as SKNode?
            /*
             打乱代码结构
             */
            let location = touches.first?.location(in: gameOverLayer!)
            let retry = gameOverLayer!.atPoint(location!)
            /*
             打乱代码结构
             */
        
            if (retry.name == StickHeroGameSceneChildName.RetryButtonName.rawValue) {
                retry.run(SKAction.sequence([SKAction.setTexture(SKTexture(imageNamed: "button_retry_down"), resize: false), SKAction.wait(forDuration: 0.3)]), completion: {[unowned self] () -> Void in
                    /*
                     打乱代码结构
                     */
                    self.zftrestart()
                })
            }
            return
        }
        /*
         打乱代码结构
         */
        if !isBegin && !isEnd {
            isBegin = true
            /*
             打乱代码结构
             */
            let stick = zftloadStick()
            /*
             打乱代码结构
             */
            let hero = childNode(withName: StickHeroGameSceneChildName.HeroName.rawValue) as! SKSpriteNode
            /*
             打乱代码结构
             */
            let action = SKAction.resize(toHeight: CGFloat(DefinedScreenHeight - StackHeight), duration: 1.5)
            /*
             打乱代码结构
             */stick.run(action, withKey:StickHeroGameSceneActionKey.StickGrowAction.rawValue)
            
            /*
             打乱代码结构
             */ let scaleAction = SKAction.sequence([SKAction.scaleY(to: 0.9, duration: 0.05), SKAction.scaleY(to: 1, duration: 0.05)])
            /*
             打乱代码结构
             */let loopAction = SKAction.group([SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.StickGrowAudioName.rawValue, waitForCompletion: true)])
            /*
             打乱代码结构
             */stick.run(SKAction.repeatForever(loopAction), withKey: StickHeroGameSceneActionKey.StickGrowAudioAction.rawValue)
            /*
             打乱代码结构
             */hero.run(SKAction.repeatForever(scaleAction), withKey: StickHeroGameSceneActionKey.HeroScaleAction.rawValue)
            
            return
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isBegin && !isEnd {
            isEnd  = true
            
            /*
             打乱代码结构
             */let hero = childNode(withName: StickHeroGameSceneChildName.HeroName.rawValue) as! SKSpriteNode
            /*
             打乱代码结构
             */ hero.removeAction(forKey: StickHeroGameSceneActionKey.HeroScaleAction.rawValue)
            hero.run(SKAction.scaleY(to: 1, duration: 0.04))
            /*
             打乱代码结构
             */
            let stick = childNode(withName: StickHeroGameSceneChildName.StickName.rawValue) as! SKSpriteNode
            stick.removeAction(forKey: StickHeroGameSceneActionKey.StickGrowAction.rawValue)
            stick.removeAction(forKey: StickHeroGameSceneActionKey.StickGrowAudioAction.rawValue)
            stick.run(SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.StickGrowOverAudioName.rawValue, waitForCompletion: false))
            /*
             打乱代码结构
             */
            stickHeight = stick.size.height;
            /*
             打乱代码结构
             */
            let action = SKAction.rotate(toAngle: CGFloat(-M_PI / 2), duration: 0.4, shortestUnitArc: true)
            let playFall = SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.StickFallAudioName.rawValue, waitForCompletion: false)
            /*
             打乱代码结构
             */
            stick.run(SKAction.sequence([SKAction.wait(forDuration: 0.2), action, playFall]), completion: {[unowned self] () -> Void in
                self.zftheroGo(self.zftcheckPass())
            })
        }
    }
    
    func zftstart() {
        zftloadBackground()
        zftloadScoreBackground()
        zftloadScore()
        zftloadTip()
        zftloadGameOverLayer()
        /*
         打乱代码结构
         */
        leftStack = zftloadStacks(false, startLeftPoint: playAbleRect.origin.x)
        self.zftremoveMidTouch(false, left:true)
        zftloadHero()
        /*
         打乱代码结构
         */
        let maxGap = Int(playAbleRect.width - StackMaxWidth - (leftStack?.frame.size.width)!)
        
        let gap = CGFloat(randomInRange(StackGapMinWidth...maxGap))
        rightStack = zftloadStacks(false, startLeftPoint: nextLeftStartX + gap)
        
        gameOver = false
    }
    
    func zftrestart() {
        
        if Aplication.sharedInstance.appModel.admob.isComment {
            //记录分数
            isBegin = false
            isEnd = false
            /*
             打乱代码结构
             */
            score = 0
            nextLeftStartX = 0
            /*
             打乱代码结构
             */
            removeAllChildren()
            zftstart()
        }else{
            if Aplication.sharedInstance.judgmentGameMin(){
                
                //记录分数
                isBegin = false
                isEnd = false
                /*
                 打乱代码结构
                 */
                score = 0
                nextLeftStartX = 0
                /*
                 打乱代码结构
                 */
                removeAllChildren()
                zftstart()
            }else{
                self.showErrorText("没有游戏次数了")
            }
            
        }
        
    }
    
    fileprivate func zftcheckPass() -> Bool {
        let stick = childNode(withName: StickHeroGameSceneChildName.StickName.rawValue) as! SKSpriteNode
        /*
         打乱代码结构
         */
        let rightPoint = DefinedScreenWidth / 2 + stick.position.x + self.stickHeight
        /*
         打乱代码结构
         */
        guard rightPoint < self.nextLeftStartX else {
            return false
        }
        /*
         打乱代码结构
         */
        guard ((leftStack?.frame)!.intersects(stick.frame) && (rightStack?.frame)!.intersects(stick.frame)) else {
            return false
        }
        /*
         打乱代码结构
         */
        self.zftcheckTouchMidStack()
        
        return true
    }
    
    fileprivate func zftcheckTouchMidStack() {
        let stick = childNode(withName: StickHeroGameSceneChildName.StickName.rawValue) as! SKSpriteNode
        let stackMid = rightStack!.childNode(withName: StickHeroGameSceneChildName.StackMidName.rawValue) as! SKShapeNode
        /*
         打乱代码结构
         */
        let newPoint = stackMid.convert(CGPoint(x: -10, y: 10), to: self)
        /*
         打乱代码结构
         */
        if ((stick.position.x + self.stickHeight) >= newPoint.x  && (stick.position.x + self.stickHeight) <= newPoint.x + 20) {
            zftloadPerfect()
            /*
             打乱代码结构
             */
            self.run(SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.StickTouchMidAudioName.rawValue, waitForCompletion: false))
            score += 1
            /*
             打乱代码结构
             */
        }
 
    }
    
    fileprivate func zftremoveMidTouch(_ animate:Bool, left:Bool) {
        let stack = left ? leftStack : rightStack
        /*
         打乱代码结构
         */
        let mid = stack!.childNode(withName: StickHeroGameSceneChildName.StackMidName.rawValue) as! SKShapeNode
        if (animate) {
            mid.run(SKAction.fadeAlpha(to: 0, duration: 0.3))
        }
            /*
             打乱代码结构
             */
        else {
            mid.removeFromParent()
        }
    }
    
    fileprivate func zftheroGo(_ pass:Bool) {
        let hero = childNode(withName: StickHeroGameSceneChildName.HeroName.rawValue) as! SKSpriteNode
        /*
         打乱代码结构
         */
        guard pass else {
            let stick = childNode(withName: StickHeroGameSceneChildName.StickName.rawValue) as! SKSpriteNode
            
            let dis:CGFloat = stick.position.x + self.stickHeight
            /*
             打乱代码结构
             */
            let overGap = DefinedScreenWidth / 2 - abs(hero.position.x)
            let disGap = nextLeftStartX - overGap - (rightStack?.frame.size.width)! / 2
            /*
             打乱代码结构
             */
            let move = SKAction.moveTo(x: dis, duration: TimeInterval(abs(disGap / HeroSpeed)))
            /*
             打乱代码结构
             */
            hero.run(walkAction, withKey: StickHeroGameSceneActionKey.WalkAction.rawValue)
            hero.run(move, completion: {[unowned self] () -> Void in
                stick.run(SKAction.rotate(toAngle: CGFloat(-M_PI), duration: 0.4))
                
                hero.physicsBody!.affectedByGravity = true
                hero.run(SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.DeadAudioName.rawValue, waitForCompletion: false))
                hero.removeAction(forKey: StickHeroGameSceneActionKey.WalkAction.rawValue)
                self.run(SKAction.wait(forDuration: 0.5), completion: {[unowned self] () -> Void in
                    self.gameOver = true
                })
            })

            return
        }
        /*
         打乱代码结构
         */
        let dis:CGFloat = nextLeftStartX - DefinedScreenWidth / 2 - hero.size.width / 2 - GAP.XGAP
        /*
         打乱代码结构
         */
        let overGap = DefinedScreenWidth / 2 - abs(hero.position.x)
        let disGap = nextLeftStartX - overGap - (rightStack?.frame.size.width)! / 2
        /*
         打乱代码结构
         */
        let move = SKAction.moveTo(x: dis, duration: TimeInterval(abs(disGap / HeroSpeed)))
        /*
         打乱代码结构
         */
        hero.run(walkAction, withKey: StickHeroGameSceneActionKey.WalkAction.rawValue)
        hero.run(move, completion: { [unowned self]() -> Void in
            self.score += 1
            /*
             打乱代码结构
             */
            hero.run(SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.VictoryAudioName.rawValue, waitForCompletion: false))
            hero.removeAction(forKey: StickHeroGameSceneActionKey.WalkAction.rawValue)
            self.zftmoveStackAndCreateNew()
        }) 
    }
    /*
     打乱代码结构
     */
    fileprivate func zftcheckHighScoreAndStore() {
        let highScore = UserDefaults.standard.integer(forKey: StoreScoreName)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDateString = dateFormatter.string(from: Date())
        
        let money = MoneyModel.init(isTake: false, time: currentDateString, price: Double(score))
        Aplication.sharedInstance.myMoneyList.append(money)
        Aplication.sharedInstance.saveData()
    
            if (score > Int(highScore)) {
                zftzftshowHighScore()
                /*
                 打乱代码结构
                 */
                UserDefaults.standard.set(score, forKey: StoreScoreName)
                UserDefaults.standard.synchronize()
            }
        
        
    }
    /*
     打乱代码结构
     */
    fileprivate func zftzftshowHighScore() {
        self.run(SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.HighScoreAudioName.rawValue, waitForCompletion: false))
        /*
         打乱代码结构
         */
        let wait = SKAction.wait(forDuration: 0.4)
        /*
         打乱代码结构
         */
        let grow = SKAction.scale(to: 1.5, duration: 0.4)
        /*
         打乱代码结构
         */
        grow.timingMode = .easeInEaseOut
        /*
         打乱代码结构
         */
        let explosion = zftstarEmitterActionAtPosition(CGPoint(x: 0, y: 300))
        /*
         打乱代码结构
         */
        let shrink = SKAction.scale(to: 1, duration: 0.2)
        /*
         打乱代码结构
         */
        let idleGrow = SKAction.scale(to: 1.2, duration: 0.4)
        idleGrow.timingMode = .easeInEaseOut
        let idleShrink = SKAction.scale(to: 1, duration: 0.4)
        let pulsate = SKAction.repeatForever(SKAction.sequence([idleGrow, idleShrink]))
        /*
         打乱代码结构
         */
        let gameOverLayer = childNode(withName: StickHeroGameSceneChildName.GameOverLayerName.rawValue) as SKNode?
        /*
         打乱代码结构
         */
        let highScoreLabel = gameOverLayer?.childNode(withName: StickHeroGameSceneChildName.HighScoreName.rawValue) as SKNode?
        /*
         打乱代码结构
         */
        highScoreLabel?.run(SKAction.sequence([wait, explosion, grow, shrink]), completion: { () -> Void in
            highScoreLabel?.run(pulsate)
        })
        /*
         打乱代码结构
         */
    }
    /*
     打乱代码结构
     */
    fileprivate func zftmoveStackAndCreateNew() {
        let action = SKAction.move(by: CGVector(dx: -nextLeftStartX + (rightStack?.frame.size.width)! + playAbleRect.origin.x - 2, dy: 0), duration: 0.3)
        /*
         打乱代码结构
         */
        rightStack?.run(action)
        /*
         打乱代码结构
         */
        self.zftremoveMidTouch(true, left:false)
        /*
         打乱代码结构
         */
        let hero = childNode(withName: StickHeroGameSceneChildName.HeroName.rawValue) as! SKSpriteNode
        /*
         打乱代码结构
         */
        let stick = childNode(withName: StickHeroGameSceneChildName.StickName.rawValue) as! SKSpriteNode
        /*
         打乱代码结构
         */
        /*
         打乱代码结构
         */
        hero.run(action)
        /*
         打乱代码结构
         */
        stick.run(SKAction.group([SKAction.move(by: CGVector(dx: -DefinedScreenWidth, dy: 0), duration: 0.5), SKAction.fadeAlpha(to: 0, duration: 0.3)]), completion: { () -> Void in
            /*
             打乱代码结构
             */
            stick.removeFromParent()
            /*
             打乱代码结构
             */
        }) 
        /*
         打乱代码结构
         */
        leftStack?.run(SKAction.move(by: CGVector(dx: -DefinedScreenWidth, dy: 0), duration: 0.5), completion: {[unowned self] () -> Void in
            self.leftStack?.removeFromParent()
            /*
             打乱代码结构
             */
            let maxGap = Int(self.playAbleRect.width - (self.rightStack?.frame.size.width)! - self.StackMaxWidth)
            let gap = CGFloat(randomInRange(self.StackGapMinWidth...maxGap))
            /*
             打乱代码结构
             */
            self.leftStack = self.rightStack
            /*
             打乱代码结构
             */
            self.rightStack = self.zftloadStacks(true, startLeftPoint:self.playAbleRect.origin.x + (self.rightStack?.frame.size.width)! + gap)
            /*
             打乱代码结构
             */
        })
    }
    /*
     打乱代码结构
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - load node
private extension StickHeroGameScene {
    func zftloadBackground() {
        guard let _ = childNode(withName: "background") as! SKSpriteNode? else {
            /*
             打乱代码结构
             */
            let texture = SKTexture(image: UIImage(named: "stick_background.jpg")!)
            /*
             打乱代码结构
             */
            let node = SKSpriteNode(texture: texture)
            /*
             打乱代码结构
             */
            node.size = (self.view?.scene?.size)!
            /*
             打乱代码结构
             */
            node.zPosition = StickHeroGameSceneZposition.backgroundZposition.rawValue
            /*
             打乱代码结构
             */
            self.physicsWorld.gravity = CGVector(dx: 0, dy: gravity)
            /*
             打乱代码结构
             */
            addChild(node)
            return
        }
    }
    /*
     打乱代码结构
     */
    func zftloadScore() {
        let scoreBandzft = SKLabelNode(fontNamed: "Arial")
        /*
         打乱代码结构
         */
        scoreBandzft.name = StickHeroGameSceneChildName.ScoreName.rawValue
        /*
         打乱代码结构
         */
        scoreBandzft.text = "0"
        /*
         打乱代码结构
         */
        scoreBandzft.position = CGPoint(x: 0, y: DefinedScreenHeight / 2 - 200)
        /*
         打乱代码结构
         */
        scoreBandzft.fontColor = SKColor.white
        /*
         打乱代码结构
         */
        scoreBandzft.fontSize = 100
        /*
         打乱代码结构
         */
        scoreBandzft.zPosition = StickHeroGameSceneZposition.scoreZposition.rawValue
        /*
         打乱代码结构
         */
        scoreBandzft.horizontalAlignmentMode = .center
        /*
         打乱代码结构
         */
        addChild(scoreBandzft)
        /*
         打乱代码结构
         */
    }
    /*
     打乱代码结构
     */
    func zftloadScoreBackground() {
        let zftback = SKShapeNode(rect: CGRect(x: 0-120, y: 1024-200-30, width: 240, height: 140), cornerRadius: 20)
        /*
         打乱代码结构
         */
        zftback.zPosition = StickHeroGameSceneZposition.scoreBackgroundZposition.rawValue
        /*
         打乱代码结构
         */
        zftback.fillColor = SKColor.black.withAlphaComponent(0.3)
        /*
         打乱代码结构
         */
        zftback.strokeColor = SKColor.black.withAlphaComponent(0.3)
        /*
         打乱代码结构
         */
        addChild(zftback)
        /*
         打乱代码结构
         */
    }
    /*
     打乱代码结构
     */
    func zftloadHero() {
        /*
         打乱代码结构
         */
        let zfthero = SKSpriteNode(imageNamed: "human1")
        /*
         打乱代码结构
         */
        zfthero.name = StickHeroGameSceneChildName.HeroName.rawValue
        /*
         打乱代码结构
         */
        let x:CGFloat = nextLeftStartX - DefinedScreenWidth / 2 - zfthero.size.width / 2 - GAP.XGAP
        /*
         打乱代码结构
         */
        let y:CGFloat = StackHeight + zfthero.size.height / 2 - DefinedScreenHeight / 2 - GAP.YGAP
        /*
         打乱代码结构
         */
        zfthero.position = CGPoint(x: x, y: y)
        /*
         打乱代码结构
         */
        zfthero.zPosition = StickHeroGameSceneZposition.heroZposition.rawValue
        /*
         打乱代码结构
         */
        zfthero.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 16, height: 18))
        /*
         打乱代码结构
         */
        zfthero.physicsBody?.affectedByGravity = false
        /*
         打乱代码结构
         */
        zfthero.physicsBody?.allowsRotation = false
        /*
         打乱代码结构
         */
        addChild(zfthero)
        /*
         打乱代码结构
         */
    }
    /*
     打乱代码结构
     */
    func zftloadTip() {
        let tipzft = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        /*
         打乱代码结构
         */
        tipzft.name = StickHeroGameSceneChildName.TipName.rawValue
        tipzft.text = "将手放在屏幕使竿变长"
        /*
         打乱代码结构
         */
        tipzft.position = CGPoint(x: 0, y: DefinedScreenHeight / 2 - 350)
        /*
         打乱代码结构
         */
        tipzft.fontColor = SKColor.black
        tipzft.fontSize = 52
        /*
         打乱代码结构
         */
        tipzft.zPosition = StickHeroGameSceneZposition.tipZposition.rawValue
        /*
         打乱代码结构
         */
        tipzft.horizontalAlignmentMode = .center
    
        addChild(tipzft)
    }
    /*
     打乱代码结构
     */
    func zftloadPerfect() {
        defer {
            /*
             打乱代码结构
             */
            let perfect = childNode(withName: StickHeroGameSceneChildName.PerfectName.rawValue) as! SKLabelNode?
            /*
             打乱代码结构
             */
            let sequence = SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: 0.3), SKAction.fadeAlpha(to: 0, duration: 0.3)])
            /*
             打乱代码结构
             */
            let scale = SKAction.sequence([SKAction.scale(to: 1.4, duration: 0.3), SKAction.scale(to: 1, duration: 0.3)])
            /*
             打乱代码结构
             */
            perfect!.run(SKAction.group([sequence, scale]))
            /*
             打乱代码结构
             */
        }

        guard let _ = childNode(withName: StickHeroGameSceneChildName.PerfectName.rawValue) as! SKLabelNode? else {
            let perfect = SKLabelNode(fontNamed: "Arial")
            /*
             打乱代码结构
             */
            perfect.text = "Perfect +1"
            /*
             打乱代码结构
             */
            perfect.name = StickHeroGameSceneChildName.PerfectName.rawValue
            /*
             打乱代码结构
             */
            perfect.position = CGPoint(x: 0, y: -100)
            /*
             打乱代码结构
             */
            perfect.fontColor = SKColor.black
            /*
             打乱代码结构
             */
            perfect.fontSize = 50
            /*
             打乱代码结构
             */
            perfect.zPosition = StickHeroGameSceneZposition.perfectZposition.rawValue
            /*
             打乱代码结构
             */
            perfect.horizontalAlignmentMode = .center
            /*
             打乱代码结构
             */
            perfect.alpha = 0
            
            addChild(perfect)
            
            return
        }
       
    }
    
    func zftloadStick() -> SKSpriteNode {
        let hero = childNode(withName: StickHeroGameSceneChildName.HeroName.rawValue) as! SKSpriteNode
        /*
         打乱代码结构
         */
        let stick = SKSpriteNode(color: SKColor.black, size: CGSize(width: 12, height: 1))
        /*
         打乱代码结构
         */
        stick.zPosition = StickHeroGameSceneZposition.stickZposition.rawValue
        /*
         打乱代码结构
         */
        stick.name = StickHeroGameSceneChildName.StickName.rawValue
        stick.anchorPoint = CGPoint(x: 0.5, y: 0);
        /*
         打乱代码结构
         */
        stick.position = CGPoint(x: hero.position.x + hero.size.width / 2 + 18, y: hero.position.y - hero.size.height / 2)
        /*
         打乱代码结构
         */
        addChild(stick)
        /*
         打乱代码结构
         */
        return stick
    }
    
    func zftloadStacks(_ animate: Bool, startLeftPoint: CGFloat) -> SKShapeNode {
        /*
         打乱代码结构
         */
        let max:Int = Int(StackMaxWidth / 10)
        /*
         打乱代码结构
         */
        let min:Int = Int(StackMinWidth / 10)
        let width:CGFloat = CGFloat(randomInRange(min...max) * 10)
        /*
         打乱代码结构
         */
        let height:CGFloat = StackHeight
        /*
         打乱代码结构
         */
        let stack = SKShapeNode(rectOf: CGSize(width: width, height: height))
        stack.fillColor = SKColor.black
        /*
         打乱代码结构
         */
        stack.strokeColor = SKColor.black
        /*
         打乱代码结构
         */
        stack.zPosition = StickHeroGameSceneZposition.stackZposition.rawValue
        stack.name = StickHeroGameSceneChildName.StackName.rawValue
        /*
         打乱代码结构
         */
        if (animate) {
            stack.position = CGPoint(x: DefinedScreenWidth / 2, y: -DefinedScreenHeight / 2 + height / 2)
            
            stack.run(SKAction.moveTo(x: -DefinedScreenWidth / 2 + width / 2 + startLeftPoint, duration: 0.3), completion: {[unowned self] () -> Void in
                self.isBegin = false
                self.isEnd = false
            })
            
        }
            /*
             打乱代码结构
             */
        else {
            stack.position = CGPoint(x: -DefinedScreenWidth / 2 + width / 2 + startLeftPoint, y: -DefinedScreenHeight / 2 + height / 2)
        }
        addChild(stack)
        /*
         打乱代码结构
         */
        let mid = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
        mid.fillColor = SKColor.red
        /*
         打乱代码结构
         */
        mid.strokeColor = SKColor.red
        mid.zPosition = StickHeroGameSceneZposition.stackMidZposition.rawValue
        /*
         打乱代码结构
         */
        mid.name = StickHeroGameSceneChildName.StackMidName.rawValue
        /*
         打乱代码结构
         */
        mid.position = CGPoint(x: 0, y: height / 2 - 20 / 2)
        stack.addChild(mid)
        /*
         打乱代码结构
         */
        nextLeftStartX = width + startLeftPoint
        /*
         打乱代码结构
         */
        return stack
    }

    func zftloadGameOverLayer() {
        let nodezft = SKNode()
        nodezft.alpha = 0
        /*
         打乱代码结构
         */
        nodezft.name = StickHeroGameSceneChildName.GameOverLayerName.rawValue
        /*
         打乱代码结构
         */
        nodezft.zPosition = StickHeroGameSceneZposition.gameOverZposition.rawValue
        addChild(nodezft)
        /*
         打乱代码结构
         */
        let label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        label.text = "Game Over"
        label.fontColor = SKColor.red
        label.fontSize = 150
        /*
         打乱代码结构
         */
        label.position = CGPoint(x: 0, y: 100)
        /*
         打乱代码结构
         */
        label.horizontalAlignmentMode = .center
        /*
         打乱代码结构
         */
        nodezft.addChild(label)
        /*
         打乱代码结构
         */
        let retry = SKSpriteNode(imageNamed: "button_retry_up")
        /*
         打乱代码结构
         */
        retry.name = StickHeroGameSceneChildName.RetryButtonName.rawValue
        /*
         打乱代码结构
         */
        retry.position = CGPoint(x: 0, y: -200)
        /*
         打乱代码结构
         */
        nodezft.addChild(retry)
        /*
         打乱代码结构
         */
        let highScorezft = SKLabelNode(fontNamed: "AmericanTypewriter")
        /*
         打乱代码结构
         */
     
        highScorezft.text = "Highscore!"
    
        /*
         打乱代码结构
         */
        highScorezft.fontColor = UIColor.white
        /*
         打乱代码结构
         */
        highScorezft.fontSize = 50
        /*
         打乱代码结构
         */
        highScorezft.name = StickHeroGameSceneChildName.HighScoreName.rawValue
        /*
         打乱代码结构
         */
        highScorezft.position = CGPoint(x: 0, y: 300)
        /*
         打乱代码结构
         */
        highScorezft.horizontalAlignmentMode = .center
        /*
         打乱代码结构
         */
        highScorezft.setScale(0)
        /*
         打乱代码结构
         */
        nodezft.addChild(highScorezft)
    }
    /*
     打乱代码结构
     */
    //MARK: - Action
    func zftstarEmitterActionAtPosition(_ position: CGPoint) -> SKAction {
        let zftemitter = SKEmitterNode(fileNamed: "StarExplosion")
        zftemitter?.position = position
        /*
         打乱代码结构
         */
        zftemitter?.zPosition = StickHeroGameSceneZposition.emitterZposition.rawValue
        /*
         打乱代码结构
         */
        zftemitter?.alpha = 0.6
        /*
         打乱代码结构
         */
        addChild((zftemitter)!)
        /*
         打乱代码结构
         */
        let wait = SKAction.wait(forDuration: 0.15)
        /*
         打乱代码结构
         */
        return SKAction.run({ () -> Void in
           zftemitter?.run(wait)
        })
    }

}
