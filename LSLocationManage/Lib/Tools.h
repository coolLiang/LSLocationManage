//
//  Tools.h
//  517job
//
//  Created by noci on 16/4/22.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface Tools : NSObject

//获取当前活动视图。
+(UIViewController *)getCurrentViewController;
//获取一个视图的模态视图。
+(UIViewController *)getCurrentPresentViewController:(UIViewController *)vc;


+(void)addTheHubToCurrentWindowsWithTitle:(NSString *)title;
+(void)removeTheHubFromCurrentWindows;




@end
