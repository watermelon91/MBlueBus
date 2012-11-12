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

@synthesize mapView = _mapView, routeDataSource, locDataSource, stopViewPopover, region = _region, span = _span;

// Finish building BusColorInfo

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
                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"currentRouteDataUpdatedInMainView" object:routeDataSource];
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
    dispatch_source_set_timer(source, DISPATCH_TIME_NOW, 2000000000, 1000000000);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationItem setTitle:@"Blue Bus Map View"];
    
    lineViewButton = [[UIBarButtonItem alloc] initWithTitle:@"Line View" style: UIBarButtonItemStylePlain target:self action:@selector(buttonPressed:)];
    stopViewButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop View" style: UIBarButtonItemStylePlain target:self action:@selector(buttonPressed:)];
    self.navigationItem.leftBarButtonItem = lineViewButton;
    self.navigationItem.rightBarButtonItem = stopViewButton;
    self.mapView.delegate = self;
    
    dispatch_resume(source);
    
    _span.latitudeDelta = 0.0326;
    _span.longitudeDelta = 0.017;
    CLLocationCoordinate2D location;
    location.latitude = 42.2845;
    location.longitude = -83.7260;
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

- (IBAction)buttonPressed:(id)sender
{
    if([stopViewPopover isPopoverVisible]){
        [stopViewPopover dismissPopoverAnimated:YES];
    }
    
    UIBarButtonItem * temp = sender;
    
    if([temp.title isEqualToString:@"Line View"]){
        
    }else if([temp.title isEqualToString:@"Stop View"]){
        StopViewPopoverContentController * stopViewPC = [[StopViewPopoverContentController alloc] init];
        [stopViewPC setTitle:@"Stop List"];
        UINavigationController * childNavigationForStopViewPopover = [[UINavigationController alloc] initWithRootViewController:stopViewPC];
        stopViewPopover = [[UIPopoverController alloc] initWithContentViewController:childNavigationForStopViewPopover];
        [stopViewPopover presentPopoverFromBarButtonItem: stopViewButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        //stopViewPopover.popoverContentSize = CGSizeMake(250, 250);
    }
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    /*
    if([overlay isKindOfClass:[MKCircle class]]){
        MKCircleView * circleView = [[MKCircleView alloc] initWithCircle:(MKCircle *)overlay];
    
        MKCircle * temp = overlay;
        UIColor * tempC = [busColorInfo getColor:temp.title];
        [circleView setFillColor:tempC];
        
        [circleView setStrokeColor:[UIColor blackColor]];
        [circleView setLineWidth:1];
        [circleView setAlpha:1.0f];
    
        return circleView;
    }else{
        return  nil;
    }
     */

    if([overlay isKindOfClass:[MKPolygon class]]){
        MKPolygonView * polyView = [[MKPolygonView alloc] initWithPolygon:(MKPolygon *)overlay];
        
        MKPolygon * tempP = overlay;
        UIColor * tempC = [busColorInfo getColor:tempP.title];
        
        [polyView setFillColor:tempC];
        [polyView setStrokeColor:tempC];
        [polyView setLineWidth:3];
        [polyView setAlpha:1.0f];

        return polyView;
    }else{
        return nil;
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
        /*
        CLLocationCoordinate2D location;
        location.latitude = thisBus.latitude;
        location.longitude = thisBus.longitude;
         */
        
        // heading 0 - clockwise
        CLLocationCoordinate2D busShapeCord[5];
        double height = 0.00035, leg = 0.00025;
        
        thisBus.heading = thisBus.heading % 360;
        double rotationDegree = thisBus.heading / 360.0 * 2 * M_PI;
        double leftRotationDegree = ((thisBus.heading + 225) % 360) / 360.0 * 2 * M_PI;
        double rightRotationDegree = ((thisBus.heading + 135) % 360) / 360.0 * 2 * M_PI;

        // Middle Point
        busShapeCord[0].latitude = thisBus.latitude;
        busShapeCord[0].longitude = thisBus.longitude;
        
        busShapeCord[1].latitude = thisBus.latitude + leg * cos(leftRotationDegree);
        busShapeCord[1].longitude = thisBus.longitude + leg * sin(leftRotationDegree);
        
        busShapeCord[2].latitude = thisBus.latitude + height * cos(rotationDegree);
        busShapeCord[2].longitude = thisBus.longitude + height * sin(rotationDegree);
        
        busShapeCord[3].latitude = thisBus.latitude + leg * cos(rightRotationDegree);
        busShapeCord[3].longitude = thisBus.longitude + leg * sin(rightRotationDegree);
        
        busShapeCord[4].latitude = thisBus.latitude;
        busShapeCord[4].longitude = thisBus.longitude;
      
        /*
        MKCircle * circle = [MKCircle circleWithCenterCoordinate:location radius:50];
        circle.title = thisBus.routeName;
        [busesOnMap addObject:circle];
        [self.mapView addOverlay: circle];
        */
        
        MKPolygon * poly = [MKPolygon polygonWithCoordinates:busShapeCord count:4];
        poly.title = thisBus.routeName;
        [busesOnMap addObject:poly];
        [self.mapView addOverlay:poly];
         
    }
}

- (void)UpdateStopViewBusArrivalInfo{
    
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
