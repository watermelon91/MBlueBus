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
        [self popData];
    }

    return self;
}

- (UIColor *)getColor: (NSString *) routeName{
    return [colorDictionary objectForKey:routeName];
}

- (void)popData{
    [colors addObject:@"990000"]; // Northwood
    [colors addObject:@"009933"]; // BursleyBaits (Nights)
    [colors addObject:@"660099"]; // Commuter North (Nights)
    [colors addObject:@"3400FF"]; // Commuter South
    [colors addObject:@"9933FF"]; // Commuter North
    [colors addObject:@"007F00"]; // BursleyBaits
    [colors addObject:@"993300"]; // Northwood express
    [colors addObject:@"FF00FF"]; // Intercampus to NIB
    [colors addObject:@"CC6600"]; // Oxford Loop to Northwood Express
    [colors addObject:@"0000FF"]; // Research Link
    [colors addObject:@"FF0000"]; // Diag to Diag
    [colors addObject:@"FF6600"]; // Med Express
    [colors addObject:@"00CC00"]; // Intercampus to East Campus
    [colors addObject:@"FF9900"]; // Oxford Shuttle
    [colors addObject:@"0000FF"]; // Commuter South (Nights)
    
    [colorDictionary setObject:[self convertColor:colors[0]] forKey:@"Northwood"];
    [colorDictionary setObject:[self convertColor:colors[1]] forKey:@"Bursley-Baits (Nights)"];
    [colorDictionary setObject:[self convertColor:colors[2]] forKey:@"Commuter Northbound (Nights)"];
    [colorDictionary setObject:[self convertColor:colors[3]] forKey:@"Commuter Southbound"];
    [colorDictionary setObject:[self convertColor:colors[4]] forKey:@"Commuter Northbound"];
    [colorDictionary setObject:[self convertColor:colors[5]] forKey:@"Bursley-Baits"];
    [colorDictionary setObject:[self convertColor:colors[6]] forKey:@"Northwood Express"];
    [colorDictionary setObject:[self convertColor:colors[7]] forKey:@"Intercampus to NIB"];
    [colorDictionary setObject:[self convertColor:colors[8]] forKey:@"Oxford Loop to Northwood Express"];
    [colorDictionary setObject:[self convertColor:colors[9]] forKey:@"Research Link"];
    [colorDictionary setObject:[self convertColor:colors[10]] forKey:@"Diag to Diag Express"];
    [colorDictionary setObject:[self convertColor:colors[11]] forKey:@"MedExpress"];
    [colorDictionary setObject:[self convertColor:colors[12]] forKey:@"Intercampus to East Campus"];
    [colorDictionary setObject:[self convertColor:colors[13]] forKey:@"Oxford Shuttle"];
    [colorDictionary setObject:[self convertColor:colors[14]] forKey:@"Commuter Southbound (Nights)"];
    [colorDictionary setObject:[self convertColor:colors[14]] forKey:@"North Campus to Burs/Baits and Northwood  (Sat Morning)"];
    [colorDictionary setObject:[self convertColor:colors[0]] forKey:@"North Campus to Central Campus (Sat Morning)"];
    [colorDictionary setObject:[self convertColor:colors[5]] forKey:@"Bursley-Baits (Weekends)"];
    [colorDictionary setObject:[self convertColor:colors[0]] forKey:@"Northwood (Weekends)"];
    [colorDictionary setObject:[self convertColor:colors[13]] forKey:@"Oxford Shuttle (Weekends)"];
}

- (UIColor *)convertColor: (NSString *)inputColor{

    UIColor * result;
    result = [[UIColor alloc] init];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [inputColor substringWithRange:range];
    range.location = 2;
    NSString *gString = [inputColor substringWithRange:range];
    range.location = 4;
    NSString *bString = [inputColor substringWithRange:range];
    
    // Scan values
    unsigned int r = 0, g = 0, b = 0;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    result = [UIColor colorWithRed:((float) r / 255.0f)
                             green:((float) g / 255.0f)
                              blue:((float) b / 255.0f)
                             alpha:1.0f];
    
    return result;
}

@end
