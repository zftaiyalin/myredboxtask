//
//  OCTool.h
//  MyRedTask
//
//  Created by 曾富田 on 2017/8/28.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCTool : NSObject
    + (NSDate *)getInternetDate;
/**
 *得到本机现在用的语言
 * en:英文  zh-Hans:简体中文   zh-Hant:繁体中文    ja:日本  ......
 */
+ (BOOL)getPreferredLanguage:(NSString *)lan;
@end
