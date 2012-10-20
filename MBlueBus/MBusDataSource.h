//
//  MBusDataSource.h
//  MBlueBus
//
//  Created by Watermelon on 9/30/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLParser.h"

@interface DataSource : NSObject {
    NSArray * parsedRoutes;
    NSInteger routeCount;
}

@property (nonatomic, strong) NSArray * parsedRoutes;
@property (nonatomic) NSInteger routeCount;

- (id)init;
  
- (void)doParse:(NSURL *)url;

@end

