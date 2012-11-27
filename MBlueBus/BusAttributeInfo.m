//
//  BusColorInfo.m
//  MBlueBus
//
//  Created by Watermelon on 11/7/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "BusAttributeInfo.h"

@implementation BusAttributeInfo

NSMutableArray * colors = nil;
NSMutableArray * commonBusNames = nil;
NSMutableDictionary * colorDictionary = nil;
NSMutableDictionary * nameDictionary = nil;

+(void)initStatic {
    colors = [NSMutableArray arrayWithCapacity:0];
    commonBusNames = [NSMutableArray arrayWithCapacity:0];
    colorDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    nameDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    [BusAttributeInfo popData];
}

+ (UIColor *)getColor: (NSString *) routeName{
    return [colorDictionary objectForKey:routeName];
}

+ (NSString *)getName: (NSString *) commonName{
    return [nameDictionary objectForKey:commonName];
}

+ (void)popData{
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
    [colors addObject:@"7F0000"]; // North campus (Sun Morning)
    
    [commonBusNames addObject:@"Northwood"];
    [commonBusNames addObject:@"Bursley-Baits (Nights)"];
    [commonBusNames addObject:@"Commuter Northbound (Nights)"];
    [commonBusNames addObject:@"Commuter Southbound"];
    [commonBusNames addObject:@"Commuter Northbound"];
    [commonBusNames addObject:@"Bursley-Baits"];
    [commonBusNames addObject:@"Northwood Express"];
    [commonBusNames addObject:@"Intercampus to NIB"];
    [commonBusNames addObject:@"Oxford Loop to Northwood Express"];
    [commonBusNames addObject:@"Research Link"];
    [commonBusNames addObject:@"Diag to Diag Express"];
    [commonBusNames addObject:@"MedExpress"];
    [commonBusNames addObject:@"Intercampus to East Campus"];
    [commonBusNames addObject:@"Oxford Shuttle"];
    [commonBusNames addObject:@"Commuter Southbound (Nights)"];
    [commonBusNames addObject:@"North Campus to Burs/Baits and Northwood  (Sat Morning)"];
    [commonBusNames addObject:@"North Campus to Central Campus (Sat Morning)"];
    [commonBusNames addObject:@"Bursley-Baits (Weekends)"];
    [commonBusNames addObject:@"Northwood (Weekends)"];
    [commonBusNames addObject:@"Oxford Shuttle (Weekends)"];
    [commonBusNames addObject:@"North Campus to Central Campus (Sun Morning)"];
    [commonBusNames addObject:@"North Campus to Burs/Baits and Northwood  (Sun Morning)"];
    [commonBusNames addObject:@"North Campus to Central Campus (Mon-Thu)"];
    [commonBusNames addObject:@"North Campus to Burs/Baits and Northwood  (Mon-Thu)"];
    [commonBusNames addObject:@"Oxford Loop to Diag to Diag Express"];

    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[0]] forKey:[commonBusNames objectAtIndex:0]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[1]] forKey:[commonBusNames objectAtIndex:1]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[2]] forKey:[commonBusNames objectAtIndex:2]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[3]] forKey:[commonBusNames objectAtIndex:3]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[4]] forKey:[commonBusNames objectAtIndex:4]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[5]] forKey:[commonBusNames objectAtIndex:5]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[6]] forKey:[commonBusNames objectAtIndex:6]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[7]] forKey:[commonBusNames objectAtIndex:7]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[8]] forKey:[commonBusNames objectAtIndex:8]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[9]] forKey:[commonBusNames objectAtIndex:9]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[10]] forKey:[commonBusNames objectAtIndex:10]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[11]] forKey:[commonBusNames objectAtIndex:11]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[12]] forKey:[commonBusNames objectAtIndex:12]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[13]] forKey:[commonBusNames objectAtIndex:13]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[14]] forKey:[commonBusNames objectAtIndex:14]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[14]] forKey:[commonBusNames objectAtIndex:15]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[0]] forKey:[commonBusNames objectAtIndex:16]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[5]] forKey:[commonBusNames objectAtIndex:17]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[0]] forKey:[commonBusNames objectAtIndex:18]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[13]] forKey:[commonBusNames objectAtIndex:19]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[15]] forKey:[commonBusNames objectAtIndex:20]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[15]] forKey:[commonBusNames objectAtIndex:21]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[15]] forKey:[commonBusNames objectAtIndex:22]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[15]] forKey:[commonBusNames objectAtIndex:23]];
    [colorDictionary setObject:[BusAttributeInfo convertColor:colors[11]] forKey:[commonBusNames objectAtIndex:24]];
         
    [nameDictionary setObject:@"NW" forKey:commonBusNames[0]];
    [nameDictionary setObject:@"B-Baits (Nights)" forKey:commonBusNames[1]];
    [nameDictionary setObject:@"CN (Nights)" forKey:commonBusNames[2]];
    [nameDictionary setObject:@"CS" forKey:commonBusNames[3]];
    [nameDictionary setObject:@"CN" forKey:commonBusNames[4]];
    [nameDictionary setObject:@"B-Baits" forKey:commonBusNames[5]];
    [nameDictionary setObject:@"NWExp" forKey:commonBusNames[6]];
    [nameDictionary setObject:@"IC NIB" forKey:commonBusNames[7]];
    [nameDictionary setObject:@"Oxf-NWExp Loop" forKey:commonBusNames[8]];
    [nameDictionary setObject:@"Rsch Link" forKey:commonBusNames[9]];
    [nameDictionary setObject:@"D2D" forKey:commonBusNames[10]];
    [nameDictionary setObject:@"MedExp" forKey:commonBusNames[11]];
    [nameDictionary setObject:@"IC EC" forKey:commonBusNames[12]];
    [nameDictionary setObject:@"Oxf" forKey:commonBusNames[13]];
    [nameDictionary setObject:@"CS (Nights)" forKey:commonBusNames[14]];
    [nameDictionary setObject:@"NC2North" forKey:commonBusNames[15]];
    [nameDictionary setObject:@"NC2Central" forKey:commonBusNames[16]];
    [nameDictionary setObject:@"B-Baits (Wkd)" forKey:commonBusNames[17]];
    [nameDictionary setObject:@"NW (Wkd)" forKey:commonBusNames[18]];
    [nameDictionary setObject:@"Oxf (Wkd)" forKey:commonBusNames[19]];
    [nameDictionary setObject:@"NC2Central" forKey:commonBusNames[20]];
    [nameDictionary setObject:@"NC2North" forKey:commonBusNames[21]];
    [nameDictionary setObject:@"NC2Central" forKey:commonBusNames[22]];
    [nameDictionary setObject:@"NC2North" forKey:commonBusNames[23]];
    [nameDictionary setObject:@"Oxf-D2D Loop" forKey:commonBusNames[24]];
}

+ (UIColor *)convertColor: (NSString *)inputColor{

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
