//
//  StopDetailedArrivingInfoContentController.h
//  MBlueBus
//
//  Created by Watermelon on 11/11/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteDataSource.h"
#import "stopViewAllRouteArrivingInfo.h"

@interface StopDetailedArrivingInfoContentController : UIViewController{
    NSMutableArray * thisStopArrivingInfo;
    NSMutableDictionary * stopAndArrivingInfos;
    NSArray * dictionaryKeys;
}

@property (weak, nonatomic) IBOutlet UITableView *stopArrivingInfoTable;
@property (nonatomic, readwrite) NSString * selectedStop;
@end
