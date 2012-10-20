//
//  MBusViewController.m
//  MBlueBus
//
//  Created by Watermelon on 9/23/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "MBusViewController.h"
#import "MBusDataSource.h"

@implementation MBusViewController

@synthesize mapView = _mapView, url, dataSource;

- (void)PrintLog{
    for(int i = 0; i < [dataSource.parsedRoutes count]; i++){
        NSLog(@"Route #%d \n", i);
        RouteInfo * temp = [dataSource.parsedRoutes objectAtIndex:i];
        NSLog(@"Route Name: %@, RouteID: %d, topOfLoop: %d, stopCount: %d \n",
              temp.routeName, temp.routeID, temp.topOfLoop, temp.stopCount);
    }
    NSLog(@"\n");
}

- (void)awakeFromNib {
    url = [[NSURL alloc] initWithString:@"http://mbus.pts.umich.edu/shared/public_feed.xml"];
    dataSource = [[DataSource alloc] init];
    
    source =  dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_event_handler(source,
                                      ^{
                                          /* Update Data */
                                          [dataSource doParse:url];
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              /* update UI here*/
                                              [self PrintLog];
                                          });
                                      });
    dispatch_source_set_timer(source, DISPATCH_TIME_NOW, 5000000000, 1000000000);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    dispatch_resume(source);
}

- (void)viewDidUnload
{
    dispatch_suspend(source);
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
