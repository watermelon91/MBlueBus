//
//  BusLocationCoordinateInfo.h
//  MBlueBus
//
//  Created by Watermelon on 11/6/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusLocationCoordinateInfo : NSObject{
    NSInteger busID;
    double latitude;
    double longitude;
    NSInteger heading;
    NSInteger routeID;
    NSString * busRouteColor;
}

@property (nonatomic) NSInteger busID;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) NSInteger heading;
@property (nonatomic) NSInteger routeID;
@property (nonatomic, strong) NSString * busRouteColor;



@end
