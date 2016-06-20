//
//  LocationManage.m
//  trip
//
//  Created by noci on 16/5/3.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import "LocationManage.h"

@implementation LocationManage

+ (LocationManage *)sharedManager
{
    static LocationManage * locationManage = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        locationManage = [[self alloc] init];
    });
    return locationManage;
}

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _locationManager = [[CLLocationManager alloc]init];
        _geocoder = [[CLGeocoder alloc]init];
        _locationManager.delegate = self;
        
    }
    return self;
}

-(void)startLocation
{
    if (![CLLocationManager locationServicesEnabled]) {
        
        NSLog(@"定位服务未打开");
        return;
    }
    
        [Tools addTheHubToCurrentWindowsWithTitle:@"定位中..."];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10;
        [_locationManager startUpdatingLocation];

}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [Tools removeTheHubFromCurrentWindows];
    [UIWindow showTipMessage:@"定位失败"];
    [_locationManager stopUpdatingLocation];
}

//获取到最新的定位时
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    if (_geocoder.isGeocoding) {
        
        return;
        
    }
    
    CLLocation *location=[locations firstObject];//取出第一个位置
    
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
    
    __weak typeof(self) weakSelf = self;
    
    //反地理编码
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        weakSelf.location = location.coordinate;
        CLPlacemark *placemark=[placemarks firstObject];
        
        
        weakSelf.address = [NSString stringWithFormat:@"%@%@%@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"SubLocality"],placemark.addressDictionary[@"Street"]];
        
        weakSelf.cityName = placemark.addressDictionary[@"City"];
        
        [Tools removeTheHubFromCurrentWindows];
    
        if (weakSelf.block != nil) {
            
            weakSelf.block(weakSelf.address);
        }
        
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
            
            //被用户拒绝访问定位服务。
        case kCLAuthorizationStatusDenied:
            
            [self showDeniedTip];
            
            break;
            
            //没有获取的定位服务。可能用户未拒绝访问。
        case kCLAuthorizationStatusRestricted:
            
            [self showRestrictedTip];
            
            break;
            
        case kCLAuthorizationStatusNotDetermined:
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [_locationManager requestWhenInUseAuthorization];
            }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            
            
            [self startLocation];
            break;
        default:
            break;
    }
    
}
-(void)startUpdateLocationWith:(getNewLocation)block
{
    self.block = block;
    
    [self startLocation];
}


-(void)showDeniedTip
{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        
        UIAlertController * alertControll = [UIAlertController alertControllerWithTitle:@"提示" message:@"需要开启定位服务,请到设置->隐私,打开定位服务" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            [[Tools getCurrentViewController]dismissViewControllerAnimated:YES completion:NULL];
            
        }];
        
        [alertControll addAction:confirmAction];
        
        [[Tools getCurrentViewController] presentViewController:alertControll animated:YES completion:NULL];
    }
    
    else
    {
            UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"需要开启定位服务,请到设置->隐私,打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alvertView show];
        
    }
 
}

-(void)showRestrictedTip
{
    
    [Tools removeTheHubFromCurrentWindows];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
    {
        UIAlertController * alertControll = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取系统定位服务失败,请查看设备是否开启定位服务" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            [[Tools getCurrentViewController]dismissViewControllerAnimated:YES completion:NULL];
            
        }];
        
        [alertControll addAction:confirmAction];
        
        [[Tools getCurrentViewController] presentViewController:alertControll animated:YES completion:NULL];
    }
    
    else
    {
        UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"获取系统定位服务失败,请查看设备是否开启定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alvertView show];
    }
    
    
   
}

@end
