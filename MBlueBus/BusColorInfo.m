//
//  BusColorInfo.m
//  MBlueBus
//
//  Created by Watermelon on 11/7/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "BusColorInfo.h"

@implementation BusColorInfo

- (id)init{
    self = [super init];
    
    if(self){
        colors = [[NSMutableArray alloc] init];
        colorDictionary = [[NSMutableDictionary alloc] init];
    }

    return self;
}

- (UIColor *)getColor: (NSString *) routeName{
    return [colorDictionary objectForKey:routeName];
}

- (void)popData{
    [colors addObject:@"990000"]; // Northwood
    [colors addObject:@"009933"]; // BursleyBaits
    [colors addObject:@"660099"]; // Commuter North
    
    [colorDictionary setObject:[self convertColor:colors[0]] forKey:@"Northwood"];
    [colorDictionary setObject:[self convertColor:colors[1]] forKey:@"Burseley-Baits (Nights)"];
    [colorDictionary setObject:[self convertColor:colors[1]] forKey:@"Burseley-Baits"];
    [colorDictionary setObject:[self convertColor:colors[2]] forKey:@"Commuter Northbound (Nights)"];
    [colorDictionary setObject:[self convertColor:colors[2]] forKey:@"Commuter Northboud"];
}

- (UIColor *)convertColor: (NSString *)inputColor{

    UIColor * result;
    result = [[UIColor alloc] init];
    
    CGFloat red = (([inputColor integerValue] & 0xFF0000) >> 16) / 255.0f;
    CGFloat green = (([inputColor integerValue] & 0x00FF00) >> 8) / 255.0f;
    CGFloat blue = ([inputColor integerValue] & 0x0000FF) / 255.0f;
    
    result = [result initWithRed:red green:green blue:blue alpha: 0.5f];
    
    return result;
}

@end
