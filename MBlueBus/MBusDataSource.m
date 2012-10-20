//
//  MBusDataSource.m
//  MBlueBus
//
//  Created by Watermelon on 9/30/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "MBusDataSource.h"

@implementation DataSource

@synthesize parsedRoutes, routeCount;

- (id)init{
    
    self = [super init];
    
    if(self){
        parsedRoutes = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)doParse:(NSURL *)url{
    
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    XMLParser *parser = [[XMLParser alloc] init];
    [nsXmlParser setDelegate:parser];
    
    BOOL success = [nsXmlParser parse];
    
    if(success) {
        NSLog(@"No errors");
        parsedRoutes = [NSArray arrayWithArray:[parser routes]];
        routeCount = [parser routeCount];
    }else{
        NSLog(@"Error parsing in DataSource.m");
    }
}

// Parser function
//http://codesofa.com/blog/archive/2008/07/23/make-nsxmlparser-your-friend.html
//http://wiki.cs.unh.edu/wiki/index.php/Parsing_XML_data_with_NSXMLParser

@end
