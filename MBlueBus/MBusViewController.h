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

@interface MBusViewController : UIViewController<MKMapViewDelegate> {
    dispatch_source_t source;
    NSURL *routeUrl;
    NSURL *locUrl;
    RouteDataSource * routeDataSource;
    LocDataSource * locDataSource;
}

@property (weak, nonatomic) IBOutlet MKMapView * mapView;
@property (nonatomic, strong) NSURL * routeUrl;
@property (nonatomic, strong) NSURL * locUrl;
@property (nonatomic, strong) RouteDataSource * routeDataSource;
@property (nonatomic, strong) LocDataSource * locDataSource;

- (void)awakeFromNib;

@end
