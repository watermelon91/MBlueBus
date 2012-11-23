//
//  LineViewAllStopArrivingInfo.h
//  MBlueBus
//
//  Created by Watermelon on 11/22/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineViewAllStopArrivingInfo : NSObject{
    NSString * arrivingTime;
    NSString * stopName;
}

@property (nonatomic, strong) NSString * arrivingTime;
@property (nonatomic, strong) NSString * stopName;

@end
