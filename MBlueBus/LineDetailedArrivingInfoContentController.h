//
//  LineDetailedArrivingInfoContentController.h
//  MBlueBus
//
//  Created by Watermelon on 11/20/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteDataSource.h"
#import "LineViewAllStopArrivingInfo.h"

@interface LineDetailedArrivingInfoContentController : UIViewController{
    BOOL firstTimeCalled;
    NSMutableDictionary * lineInfoDictionary;
    NSMutableArray * tempResult;
}

@property (weak, nonatomic) IBOutlet UITableView *lineArrivingInfoTable;
@property (nonatomic, readwrite) NSString * lineSelected;

@end
