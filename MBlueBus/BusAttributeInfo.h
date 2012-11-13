//
//  BusColorInfo.h
//  MBlueBus
//
//  Created by Watermelon on 11/7/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BusAttributeInfo : NSObject

+ (void)initStatic;
+ (UIColor *)getColor: (NSString *) routeName;
+ (NSString *)getName: (NSString *) commonName;

@end
