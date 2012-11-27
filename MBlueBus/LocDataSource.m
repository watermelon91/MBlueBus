//
//  LocDataSource.m
//  MBlueBus
//
//  Created by Watermelon on 11/7/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "LocDataSource.h"

@implementation LocDataSource

@synthesize parsedBusLocs;

- (id)init{
    self = [super init];
    
    if(self){
        parsedBusLocs = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)doLocParse:(NSURL *)url{
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    XMLBusLocParser * parser = [[XMLBusLocParser alloc] init];
    [nsXmlParser setDelegate:parser];
    BOOL success = [nsXmlParser parse];
    
    if(success){
        //NSLog(@"No errors");
        parsedBusLocs = [NSArray arrayWithArray:[parser busLocs]];
    }else{
        NSLog(@"Error parsing in LocDataSource.m");
    }
}

@end
