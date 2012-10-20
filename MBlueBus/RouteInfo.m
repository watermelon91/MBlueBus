//
//  LineInfo.m
//  MBlueBus
//
//  Created by Watermelon on 10/18/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "RouteInfo.h"

@implementation RouteInfo
@synthesize routeName, routeID, topOfLoop, stopCount, stops;

- (id)init{
    self = [super init];
    
    if(self){
        stops = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
