//
//  RouteDataSource.h
//  MBlueBus
//
//  Created by Watermelon on 11/7/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLRouteParser.h"
#import "XMLBusLocParser.h"

@interface RouteDataSource : NSObject {
    @public
    NSArray * parsedRoutes;
    NSInteger routeCount;
}

@property (nonatomic, strong) NSArray * parsedRoutes;
@property (nonatomic) NSInteger routeCount;

- (id)init;

- (void)doRouteParse:(NSURL *)url;

@end


