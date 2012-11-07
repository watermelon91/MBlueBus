//
//  XMLParser.m
//  MBlueBus
//
//  Created by Watermelon on 10/18/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser
@synthesize route, routes, routeCount, routeInProcess;

- (id)init{
    self = [super init];
    
    if(self){
        routes = [[NSMutableArray alloc] init];
        routeInProcess = YES;
    }
    
    return self;
}

- (void)parser:(NSXMLParser *)parser
        didStartElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qName
        attributes:(NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"route"]){
        NSLog(@"A new route found");
        route = [[RouteInfo alloc] init];
    }else if([elementName isEqualToString:@"stop"]){
        routeInProcess = NO;
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
    
    if(([elementName isEqualToString:@"name"]) && routeInProcess){
        route.routeName = currentElementValue;
    }else if([elementName isEqualToString:@"id"]){
        route.routeID = [currentElementValue integerValue];
    }else if([elementName isEqualToString:@"topofloop"]){
        route.topOfLoop = [currentElementValue integerValue];
    }else if([elementName isEqualToString:@"routecounte"]){
        routeCount = [currentElementValue integerValue];
    }
    
    // Done with parsing one route 
    if([elementName isEqualToString:@"route"]){
        [routes addObject:route];
        route = nil;
    }else if([elementName isEqualToString:@"stop"]){
        routeInProcess = YES;
    }/*else{
        [route setValue:currentElementValue forKey:elementName];
    }*/
    
    currentElementValue = nil;
}

@end
