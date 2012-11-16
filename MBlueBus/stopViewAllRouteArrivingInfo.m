//
//  stopViewAllRouteArrivingInfo.m
//  MBlueBus
//
//  Created by Watermelon on 11/11/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "stopViewAllRouteArrivingInfo.h"

@implementation stopViewAllRouteArrivingInfo

@synthesize routeName, arrivingSeconds, direction;

int sgn(double val) {
    return (0 < val) - (val < 0);
}
- (NSComparisonResult)compare:(stopViewAllRouteArrivingInfo *)otherObject{
     return sgn(self.arrivingSeconds - otherObject.arrivingSeconds);
}

@end
