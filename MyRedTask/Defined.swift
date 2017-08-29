//
//  Defined.swift
//  Stick-Hero
//
//  Created by 顾枫 on 15/6/25.
//  Copyright © 2015年 koofrank. All rights reserved.
//

import Foundation
import CoreGraphics

let DefinedScreenWidth:CGFloat = 1536
let DefinedScreenHeight:CGFloat = 2048

enum StickHeroGameSceneChildName : String {
    case HeroName = "hero"
    case StickName = "stick"
    case StackName = "stack"
    case StackMidName = "stack_mid"
    case ScoreName = "score"
    case TipName = "tip"
    case PerfectName = "perfect"
    case GameOverLayerName = "over"
    case RetryButtonName = "retry"
    case HighScoreName = "highscore"
}

enum StickHeroGameSceneActionKey: String {
    case WalkAction = "walk"
    case StickGrowAudioAction = "stick_grow_audio"
    case StickGrowAction = "stick_grow"
    case HeroScaleAction = "hero_scale"
}

enum StickHeroGameSceneEffectAudioName: String {
    case DeadAudioName = "zftdead.wav"
    case StickGrowAudioName = "zftstick_grow_loop.wav"
    case StickGrowOverAudioName = "zftkick.wav"
    case StickFallAudioName = "zftfall.wav"
    case StickTouchMidAudioName = "zfttouch_mid.wav"
    case VictoryAudioName = "zftvictory.wav"
    case HighScoreAudioName = "zfthighScore.wav"
}

enum StickHeroGameSceneZposition: CGFloat {
    case backgroundZposition = 0
    case stackZposition = 30
    case stackMidZposition = 35
    case stickZposition = 40
    case scoreBackgroundZposition = 50
    case heroZposition, scoreZposition, tipZposition, perfectZposition = 100
    case emitterZposition
    case gameOverZposition
}
