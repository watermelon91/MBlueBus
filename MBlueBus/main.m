//
//  main.m
//  MBlueBus
//
//  Created by Watermelon on 9/23/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusAttributeInfo.h"

#import "MBusAppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        [BusAttributeInfo initStatic];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([MBusAppDelegate class]));
    }
}
