//
//  ArrivalInfo.h
//  MBlueBus
//
//  Created by Watermelon on 10/21/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrivalInfo : NSObject{
    NSInteger busID;
    double arrivingSeconds;
}

@property (nonatomic) NSInteger busID;
@property (nonatomic) double arrivingSeconds;

@end
