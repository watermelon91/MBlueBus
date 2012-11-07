//
//  RouteDataSource.m
//  MBlueBus
//
//  Created by Watermelon on 11/7/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "RouteDataSource.h"

@implementation RouteDataSource

@synthesize parsedRoutes, routeCount;

- (id)init{
    
    self = [super init];
    
    if(self){
        parsedRoutes = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)doRouteParse:(NSURL *)url{
    
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    XMLRouteParser *parser = [[XMLRouteParser alloc] init];
    [nsXmlParser setDelegate:parser];
    BOOL success = [nsXmlParser parse];
    
    if(success) {
        NSLog(@"No errors");
        parsedRoutes = [NSArray arrayWithArray:[parser routes]];
        routeCount = [parser routeCount];
    }else{
        NSLog(@"Error parsing in RouteDataSource.m");
    }
}


// Parser function
//http://codesofa.com/blog/archive/2008/07/23/make-nsxmlparser-your-friend.html
//http://wiki.cs.unh.edu/wiki/index.php/Parsing_XML_data_with_NSXMLParser

@end
