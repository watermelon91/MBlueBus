//
//  StopInfo.m
//  MBlueBus
//
//  Created by Watermelon on 10/18/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "StopInfo.h"

@implementation StopInfo

@synthesize officialName, commonName, latitude, longtitude, busInOperationNum, arrivingSeconds;

- (id)init{
    self = [super init];
    
    if(self){
        arrivingSeconds = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
