//
//  Tools.m
//  517job
//
//  Created by noci on 16/4/22.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import "Tools.h"

@implementation Tools


+(void)addTheHubToCurrentWindowsWithTitle:(NSString *)title;
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD * hud = [[MBProgressHUD alloc]initWithView:window];
    hud.labelText = title;
    [window addSubview:hud];
    
}

+(void)removeTheHubFromCurrentWindows
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    [window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isMemberOfClass:[MBProgressHUD class]]) {
            
            [obj removeFromSuperview];
            

        }
        
    }];
}


@end
