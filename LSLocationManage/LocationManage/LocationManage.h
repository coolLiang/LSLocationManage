//
//  LocationManage.h
//  trip
//
//  Created by noci on 16/5/3.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "Tools.h"
#import "UIWindow+show.h"

typedef void(^getNewLocation)(NSString * address);

@interface LocationManage : NSObject<CLLocationManagerDelegate>

{
    CLLocationManager * _locationManager;
    CLGeocoder *_geocoder;
}

+(instancetype)sharedManager;

@property(nonatomic,copy)NSString * cityName;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,assign)CLLocationCoordinate2D  location;
@property(nonatomic,copy)getNewLocation block;

-(void)startUpdateLocationWith:(getNewLocation)block;

@end
