//
//  XMLParser.m
//  MBlueBus
//
//  Created by Watermelon on 10/18/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "XMLRouteParser.h"

// added in arrivingBusInfo into stop ok, but when adding stop into route, it is 0
// make when to add an object consistent

@implementation XMLRouteParser
@synthesize routes, routeCount;

- (id)init{
    self = [super init];
    
    if(self){
        routes = [[NSMutableArray alloc] init];
        routeInProcess = YES;
        stopInProcess = NO;
        arriveInfoParseInProcess = NO;
    }
    
    return self;
}

- (void)parser:(NSXMLParser *)parser
        didStartElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qName
        attributes:(NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"route"]){
        //NSLog(@"A new route found");
        route = [[RouteInfo alloc] init];
    }else if([elementName isEqualToString:@"stop"]){
        routeInProcess = NO;
        stopInProcess = YES;
        //NSLog(@"A new stop found");
        currentStop = [[StopInfo alloc] init];
    }else if((elementName.length > 3)
            && ([[elementName substringToIndex:3] isEqualToString:@"toa"])
            && (![elementName isEqualToString:@"toacount"])){
        routeInProcess = NO;
        stopInProcess = NO;
        //NSLog(@"A new arrival bus found");)
        currentArrivalBusInfo = [[ArrivalInfo alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

    if([string isEqualToString:@"\n\t"]){
        currentElementValue = nil;
    }else{
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
    
    //NSLog(@"Processing value for : %@", string);
}

- (void)parser:(NSXMLParser *)parser
        didEndElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"livefeed"]){
        return;
    }
    
    // Route Info
    if(([elementName isEqualToString:@"name"]) && routeInProcess){
        route.routeName = currentElementValue;
    }else if([elementName isEqualToString:@"id"]){
        route.routeID = [currentElementValue integerValue];
    }else if([elementName isEqualToString:@"topofloop"]){
        route.topOfLoop = [currentElementValue integerValue];
    }else if([elementName isEqualToString:@"routecount"]){
        routeCount = [currentElementValue integerValue];
    }else if([elementName isEqualToString:@"stopcount"]){
        route.stopCount = [currentElementValue integerValue];
        routeInProcess = YES;
        stopInProcess = NO;
    }
    // Stop Info
    else if(([elementName isEqualToString:@"name"]) && !routeInProcess){
        currentStop.officialName = currentElementValue;
    }else if([elementName isEqualToString:@"name2"]){
        currentStop.commonName = currentElementValue;
    }else if([elementName isEqualToString:@"latitude"]){
        currentStop.latitude = [currentElementValue doubleValue];
    }else if([elementName isEqualToString:@"longitude"]){
        currentStop.longtitude = [currentElementValue doubleValue];
    }else if([elementName isEqualToString:@"toacount"]){
        currentStop.busInOperationNum = [currentElementValue integerValue];
        routeInProcess = NO;
        stopInProcess = YES;
        [route.stops addObject:currentStop];
    }
    // ArrivalBus Info
    else if((elementName.length > 3)
            && ([[elementName substringToIndex:3] isEqualToString:@"toa"])
            && (!([elementName isEqualToString:@"toacount"] == YES))){
        currentArrivalBusInfo.arrivingSeconds = [currentElementValue doubleValue];
    }else if((elementName.length > 2)
             && ([[elementName substringToIndex:2] isEqualToString:@"id"])
             && (!([elementName isEqualToString:@"id"] == YES))){
        currentArrivalBusInfo.busID = [currentElementValue integerValue];
        [currentStop.arrivingSeconds addObject:currentArrivalBusInfo];
    }
    
    // Done with parsing one route 
    if([elementName isEqualToString:@"route"]){
        [routes addObject:route];
        route = nil;
    }/*else if([elementName isEqualToString:@"stop"]){
        routeInProcess = YES;
        stopInProcess = NO;
    }*/
    
    currentElementValue = nil;
}

@end
