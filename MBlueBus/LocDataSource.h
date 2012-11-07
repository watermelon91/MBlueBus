//
//  LocDataSource.h
//  MBlueBus
//
//  Created by Watermelon on 11/7/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLBusLocParser.h"

@interface LocDataSource : NSObject{
    @public
    NSArray * parsedBusLocs;
}

@property (nonatomic, strong) NSArray * parsedBusLocs;

- (id)init;

- (void)doLocParse:(NSURL *)url;

@end
