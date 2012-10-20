//
//  MBusViewController.h
//  MBlueBus
//
//  Created by Watermelon on 9/23/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MBusDataSource.h"

@interface MBusViewController : UIViewController {
    dispatch_source_t source;
    NSURL *url;
    DataSource * dataSource;
}

@property (weak, nonatomic) IBOutlet MKMapView * mapView;
@property (nonatomic, strong) NSURL * url;
@property (nonatomic, strong) DataSource * dataSource;

- (void)awakeFromNib;

@end
