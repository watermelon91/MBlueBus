//
//  MBusViewController.m
//  MBlueBus
//
//  Created by Watermelon on 9/23/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "MBusViewController.h"

@interface MBusViewController()
@property MKCoordinateRegion region;
@property MKCoordinateSpan span;
@end

@implementation MBusViewController

@synthesize mapView = _mapView, routeDataSource, locDataSource, region = _region, span = _span;

// Finish building BusColorInfo
// Color not working

// pins with arriving time of lines
// line layout
// push notification (needs Apple Developer license)
// table views for different lines

- (void)awakeFromNib {
   
    [self SetUp];
    
    source =  dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_event_handler(source,
                                      ^{
                                          /* Update Data */
                                          [routeDataSource doRouteParse:routeUrl];
                                          [locDataSource doLocParse:locUrl];
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              /* update UI here*/
                                              if ([lock tryLock] == YES) {
                                                  //[self PrintRouteLog];
                                                  [self PrintLocLog];
                                                  [self RemoveOldBus];
                                                  [self DrawBus];
                                                  [lock unlock];
                                              }
                                          });
                                      });
    dispatch_source_set_timer(source, DISPATCH_TIME_NOW, 3000000000, 1000000000);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
    dispatch_resume(source);
    
    _span.latitudeDelta = 0.025;
    _span.longitudeDelta = 0.017;
    CLLocationCoordinate2D location;
    location.latitude = 42.2858;
    location.longitude = -83.7269;
    
    _region.span = _span;
    _region.center = location;
    
    [_mapView setRegion:_region animated:TRUE];
    [_mapView regionThatFits:_region];
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

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if([overlay isKindOfClass:[MKCircle class]]){
        MKCircleView * circleView = [[MKCircleView alloc] initWithCircle:(MKCircle *)overlay];
    
        MKCircle * temp = overlay;
        UIColor * tempC = [busColorInfo getColor:temp.title];
        [circleView setFillColor:tempC];
        
        [circleView setStrokeColor:[UIColor blackColor]];
        [circleView setLineWidth:1];
        [circleView setAlpha:0.5f];
    
        return circleView;
    }else{
        return  nil;
    }
}

- (void)SetUp{
    lock = [[NSLock alloc] init];
    busesOnMap = [[NSMutableArray alloc] init];
    busColorInfo = [[BusColorInfo alloc] init];
    
    routeUrl = [[NSURL alloc] initWithString:@"http://mbus.pts.umich.edu/shared/public_feed.xml"];
    routeDataSource = [[RouteDataSource alloc] init];
    
    locUrl = [[NSURL alloc] initWithString:@"http://mbus.pts.umich.edu/shared//location_feed.xml"];
    locDataSource = [[LocDataSource alloc] init];
}

- (void)RemoveOldBus{
    for(MKCircle * c in busesOnMap){
        [self.mapView removeOverlay:c];
    }
}

- (void)DrawBus{
    for(BusLocationCoordinateInfo * thisBus in locDataSource.parsedBusLocs){
        CLLocationCoordinate2D location;
        location.latitude = thisBus.latitude;
        location.longitude = thisBus.longitude;
        
        MKCircle * circle = [MKCircle circleWithCenterCoordinate:location radius:50];
        circle.title = thisBus.routeName;
        [busesOnMap addObject:circle];
        [self.mapView addOverlay: circle];
    }
}

- (void)PrintRouteLog{
    for(int i = 0; i < [routeDataSource.parsedRoutes count]; i++){
        NSLog(@"Route #%d \n", i);
        RouteInfo * temp = [routeDataSource.parsedRoutes objectAtIndex:i];
        NSLog(@"Route Name: %@, RouteID: %d, topOfLoop: %d, stopCount: %d \n",
              temp.routeName, temp.routeID, temp.topOfLoop, temp.stopCount);
        
        for(int j = 0; j < temp.stopCount; j++){
            StopInfo * stop = [temp.stops objectAtIndex:j];
            //NSLog(@"Stop oName: %@, Stop cName: %@, latitude: %f, longtitude: %f, # bus in op: %d\n", stop.officialName, stop.commonName, stop.latitude, stop.longtitude, stop.busInOperationNum);
            
            for(int h = 0; h < stop.busInOperationNum; h++){
                ArrivalInfo * arv = [stop.arrivingSeconds objectAtIndex:h];
                NSLog(@"busId: %d, arrivingSec: %f", arv.busID, arv.arrivingSeconds);
            }
            
        }
    }
    NSLog(@"\n");
}

- (void)PrintLocLog{
    NSLog(@"------------------------------------");
    
    for(BusLocationCoordinateInfo *thisBus in locDataSource.parsedBusLocs){
        NSLog(@"busId: %d, latitude: %f, longitude: %f, heading: %d, routeName: %@, routeID: %d, busRouteColor: %f", thisBus.busID, thisBus.latitude, thisBus.longitude, thisBus.heading, thisBus.routeName, thisBus.routeID, thisBus.busRouteColor);
    }
    
    NSLog(@"------------------------------------");
}

@end
