//
//  AppModel.h
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/29.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskLevel.h"
#import "Admob.h"

@interface AppModel : NSObject
@property(nonatomic,strong) TaskLevel *taskLevel;
@property(nonatomic,strong) Admob *admob;
@end
