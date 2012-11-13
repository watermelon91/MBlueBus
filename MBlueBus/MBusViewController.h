//
//  MBusViewController.h
//  MBlueBus
//
//  Created by Watermelon on 9/23/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RouteDataSource.h"
#import "LocDataSource.h"
#import "BusAttributeInfo.h"
#import "StopViewPopoverContentController.h"

@interface MBusViewController : UIViewController<MKMapViewDelegate, UIScrollViewDelegate> {
    dispatch_source_t source;
    NSURL *routeUrl;
    NSURL *locUrl;
    NSLock * lock;
    NSMutableArray * busesOnMap;
    BusAttributeInfo * busColorInfo;
    UIBarButtonItem * lineViewButton;
    UIBarButtonItem * stopViewButton;
    
    RouteDataSource * routeDataSource;
    LocDataSource * locDataSource;
    UIPopoverController * stopViewPopover;
}

@property (weak, nonatomic) IBOutlet MKMapView * mapView;
@property (nonatomic, strong) RouteDataSource * routeDataSource;
@property (nonatomic, strong) LocDataSource * locDataSource;
@property (nonatomic, strong) UIPopoverController * stopViewPopover;

@end
