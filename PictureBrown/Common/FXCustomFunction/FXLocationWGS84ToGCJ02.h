//
//  FXLocationWGS84ToGCJ02.h
//  PictureBrown
//
//  Created by Jackpot on 15/2/27.
//  Copyright (c) 2015年 Jackpot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FXLocationWGS84ToGCJ02 : NSObject

// WGS84转换为GCJ02
+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;

// 判断是不是在中国
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;



@end
