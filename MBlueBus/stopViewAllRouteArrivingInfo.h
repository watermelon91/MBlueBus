//
//  stopViewAllRouteArrivingInfo.h
//  MBlueBus
//
//  Created by Watermelon on 11/11/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface stopViewAllRouteArrivingInfo : NSObject{
    NSString * routeName;
    double arrivingSeconds;
    NSInteger direction; // 0 as IN, 1 as OUT, 2 as non-loop
}

@property (nonatomic, strong) NSString * routeName;
@property (nonatomic) double arrivingSeconds;
@property (nonatomic) NSInteger direction;

@end
