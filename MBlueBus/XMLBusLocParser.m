//
//  XMLBusLocParser.m
//  MBlueBus
//
//  Created by Watermelon on 11/6/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "XMLBusLocParser.h"

@implementation XMLBusLocParser
@synthesize currentBusLocInfo, currentElementValue, busLocs;

- (id)init{
    self = [super init];
    
    if(self){
        busLocs = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"item"]){
        currentBusLocInfo = [[BusLocationCoordinateInfo alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if([string isEqualToString:@"\n\t"]){
        currentElementValue = nil;
    }else{
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"livefeed"]){
        return;
    }
    
    if([elementName isEqualToString:@"id"]){
        currentBusLocInfo.busID = [currentElementValue integerValue];
    }else if([elementName isEqualToString:@"latitude"]){
        currentBusLocInfo.latitude = [currentElementValue doubleValue];
    }else if([elementName isEqualToString:@"longitude"]){
        currentBusLocInfo.longitude = [currentElementValue doubleValue];
    }else if([elementName isEqualToString:@"heading"]){
        currentBusLocInfo.heading = [currentElementValue integerValue];
    }else if([elementName isEqualToString:@"routeid"]){
        currentBusLocInfo.routeID = [currentElementValue integerValue];
    }else if([elementName isEqualToString:@"busroutecolor"]){
        currentBusLocInfo.busRouteColor = currentElementValue;
    }
    
    // Done with parsing one bus
    if([elementName isEqualToString:@"item"]){
        [busLocs addObject:currentBusLocInfo];
        currentBusLocInfo = nil;
    }
    
    currentElementValue = nil;
}

@end
