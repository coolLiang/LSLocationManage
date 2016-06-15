//
//  UIWindow+show.m
//  FM
//
//  Created by noci on 16/4/15.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import "UIWindow+show.h"

@implementation UIWindow (show)

+(void)showTipMessage:(NSString *)message
{
    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow  animated:YES];
    hub.detailsLabelText = message;
    hub.detailsLabelFont = [UIFont systemFontOfSize:17];
    hub.mode = MBProgressHUDModeText;
    hub.animationType = MBProgressHUDAnimationZoomIn;
    [hub hide:YES afterDelay:1.5];
}

@end
