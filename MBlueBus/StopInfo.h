//
//  StopInfo.h
//  MBlueBus
//
//  Created by Watermelon on 10/18/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopInfo : NSObject {
    @public
    NSString * officialName;
    NSString * commonName;
    double latitude;
    double longtitude;
    NSInteger busInOperationNum; /* current number of buses of this route in operation;
                            * equal to arrivingSeconds length
                            */
    NSMutableArray * arrivingSeconds; // an array of all the current route buses arriving at this bus stop
}

@property (nonatomic, strong) NSString * officialName;
@property (nonatomic, strong) NSString * commonName;
@property (nonatomic) double latitude;
@property (nonatomic) double longtitude;
@property (nonatomic) NSInteger busInOperationNum;
@property (nonatomic, strong) NSMutableArray * arrivingSeconds;

@end
