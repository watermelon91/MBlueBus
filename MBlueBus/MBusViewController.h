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
#import "BusColorInfo.h"

@interface MBusViewController : UIViewController<MKMapViewDelegate, UIScrollViewDelegate> {
    dispatch_source_t source;
    NSURL *routeUrl;
    NSURL *locUrl;
    NSLock * lock;
    NSMutableArray * busesOnMap;
    BusColorInfo * busColorInfo;
    
    RouteDataSource * routeDataSource;
    LocDataSource * locDataSource;
}

@property (weak, nonatomic) IBOutlet MKMapView * mapView;
@property (nonatomic, strong) RouteDataSource * routeDataSource;
@property (nonatomic, strong) LocDataSource * locDataSource;
@property (weak, nonatomic) IBOutlet UIScrollView *singleLineScrollView;

@end
