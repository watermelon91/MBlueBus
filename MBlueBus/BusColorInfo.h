//
//  BusColorInfo.h
//  MBlueBus
//
//  Created by Watermelon on 11/7/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BusColorInfo : NSObject{
    NSMutableArray * colors;
    NSMutableDictionary * colorDictionary;
}

- (UIColor *)getColor: (NSString *) routeName;

@end
