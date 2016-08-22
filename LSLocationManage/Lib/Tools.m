//
//  Tools.m
//  517job
//
//  Created by noci on 16/4/22.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(UIViewController *)getCurrentViewController
{
    //首先。拿到根windows。
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    //然后。拿到根vc.
    UIViewController * rootVC = window.rootViewController;
    //真实根视图。
    
    while (![rootVC isEqual:[self getCurrentPresentViewController:rootVC]]) {
        
        rootVC = [self getCurrentPresentViewController:rootVC];
    }
    //判断特殊情况,如果存在alertVC.
    if ([rootVC isKindOfClass:[UIAlertController class]]) {
        
        rootVC = rootVC.presentingViewController;
    }
    
    //判断根视图
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController * tabbar = (UITabBarController *)rootVC;
        //当前选中的bar.
        UIViewController * choosedVC = tabbar.selectedViewController;
        
        if ([choosedVC isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController * currentNavi = (UINavigationController *)choosedVC;
            //原为visiableVC。改为top.避免存在alertview.
            return currentNavi.topViewController;
            
        }
        else if ([choosedVC isKindOfClass:[UIViewController class]])
        {
            return choosedVC;
        }
        
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]])
    {
        UINavigationController * chooseNavi = (UINavigationController *)rootVC;
        
        return chooseNavi.topViewController;
    }
    
    else
    {
        return rootVC;
    }
    
    return rootVC;
    
}

+(UIViewController *)getCurrentPresentViewController:(UIViewController *)vc
{
    UIViewController * vaildVC;
    
    //开始判断。
    //1.先查看是否存在presentedVC.
    if (vc.presentedViewController) {
        
        vaildVC = vc.presentedViewController;
    }
    else
    {
        vaildVC = vc;
    }
    
    return vaildVC;
}


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
