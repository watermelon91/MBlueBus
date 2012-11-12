//
//  StopViewPopoverContentController.h
//  MBlueBus
//
//  Created by Watermelon on 11/11/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StopDetailedArrivingInfoContentController.h"

@interface StopViewPopoverContentController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray * stopNameList;
    UIPopoverController * stopArrivingInfoPopover;
}

@property (weak, nonatomic) IBOutlet UITableView *stopViewTable;

@end
