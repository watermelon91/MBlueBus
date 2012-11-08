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
    NSString * routeName;
    NSInteger routeID;
    CGFloat busRouteColor;
}

@property (nonatomic) NSInteger busID;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) NSInteger heading;
@property (nonatomic, strong) NSString * routeName;
@property (nonatomic) NSInteger routeID;
@property (nonatomic) CGFloat  busRouteColor;



@end
