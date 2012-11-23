//
//  LineViewPopoverContentController.h
//  MBlueBus
//
//  Created by Watermelon on 11/20/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineDetailedArrivingInfoContentController.h"
#import "RouteDataSource.h"

@interface LineViewPopoverContentController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray * lineNameList;
    UIPopoverController * lineArrivingInfoPopover;
}
@property (weak, nonatomic) IBOutlet UITableView *lineViewTable;

@end
