//
//  LineInfo.h
//  MBlueBus
//
//  Created by Watermelon on 10/18/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RouteInfo : NSObject{
    NSString * routeName;
    NSInteger routeID;
    NSInteger topOfLoop;
    NSInteger stopCount;
    NSMutableArray * stops;
}

@property (nonatomic, strong) NSString * routeName;
@property (nonatomic) NSInteger routeID;
@property (nonatomic) NSInteger topOfLoop;
@property (nonatomic) NSInteger stopCount;
@property (nonatomic, strong) NSMutableArray * stops;

- (id)init;

@end
