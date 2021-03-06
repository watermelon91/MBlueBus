//
//  StopDetailedArrivingInfoContentController.m
//  MBlueBus
//
//  Created by Watermelon on 11/11/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "StopDetailedArrivingInfoContentController.h"

// Using common route name only

@interface StopDetailedArrivingInfoContentController ()

@end

@implementation StopDetailedArrivingInfoContentController
@synthesize selectedStop = _selectedStop;
@synthesize stopArrivingInfoTable = _stopArrivingInfoTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        firstTimeCalled = YES;
        stopAndArrivingInfos = [NSMutableDictionary dictionaryWithCapacity:0];
        dictionaryKeys = [[NSArray alloc] init];
        directionLookup = [[NSArray alloc] initWithObjects:@"(IN)", @"(OUT)", @"", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotification:) name:@"currentRouteDataUpdatedInMainView" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setStopArrivingInfoTable:nil];
    [super viewDidUnload];
}

- (void)getNotification:(NSNotification *)notification {
    RouteDataSource * tempRouteDataSource = [notification object];
    [stopAndArrivingInfos removeAllObjects];
    
    for(int i = 0; i < [tempRouteDataSource.parsedRoutes count]; i++){
        RouteInfo * tempR = [tempRouteDataSource.parsedRoutes objectAtIndex:i];
        bool isLoop;
        if(tempR.topOfLoop != 0){
            isLoop = YES;
        }else{
            isLoop = NO;
        }
        for(int j = 0; j < tempR.stopCount; j++){
            StopInfo * tempS = [tempR.stops objectAtIndex:j];
            
            NSMutableArray * result = [stopAndArrivingInfos objectForKey:tempS.commonName];
            
            if(result == nil){
                result = [[NSMutableArray alloc] init];
            }else{
                [stopAndArrivingInfos removeObjectForKey:tempS.commonName];
            }
            
            NSMutableArray * currentResult = [[NSMutableArray alloc] init];
            for(int h = 0; h < tempS.busInOperationNum; h++){
                ArrivalInfo * arv = [tempS.arrivingSeconds objectAtIndex:h];
                stopViewAllRouteArrivingInfo * tempSA = [[stopViewAllRouteArrivingInfo alloc] init];
                tempSA.routeName = tempR.routeName;
                tempSA.arrivingSeconds = arv.arrivingSeconds;
                
                if(isLoop){
                    if(j <= tempR.topOfLoop){
                        tempSA.direction = 1;
                    }else{
                        tempSA.direction = 0;
                    }
                }else{
                    tempSA.direction = 2;
                }
                [currentResult addObject:tempSA];
            }
            
            currentResult = [[currentResult sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
            [result addObjectsFromArray:currentResult];
            [stopAndArrivingInfos setObject:result forKey:tempS.commonName];
        }
    }
    
    dictionaryKeys = [stopAndArrivingInfos allKeys];
    /*for(NSString * tempStopName in dictionaryKeys){
        NSLog(@"Stop Name: %@", tempStopName);
        for(stopViewAllRouteArrivingInfo * tempSV in [stopAndArrivingInfos objectForKey:tempStopName]){
            NSLog(@"Route Name: %@, Arriving Time: %f", tempSV.routeName, tempSV.arrivingSeconds);
        }
    }*/
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_stopArrivingInfoTable reloadData];
    });
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /*NSLog(@"%@", self.selectedStop);
    for(stopViewAllRouteArrivingInfo * tempSV in [stopAndArrivingInfos objectForKey:self.selectedStop]){
        NSLog(@"Route Name: %@, Arriving Time: %f", tempSV.routeName, tempSV.arrivingSeconds);
    }*/
    return [[stopAndArrivingInfos objectForKey:self.selectedStop] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"MyCellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    if(firstTimeCalled){
        tempResult = [stopAndArrivingInfos objectForKey: self.selectedStop];
        firstTimeCalled = NO;
    }
    
    if(indexPath.row < [tempResult count]){
        stopViewAllRouteArrivingInfo * tempSA = [tempResult objectAtIndex:indexPath.row];
        if(tempSA.arrivingSeconds <= 60){
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@, Arriving", [BusAttributeInfo getName:tempSA.routeName], directionLookup[tempSA.direction]];
            cell.textLabel.textColor = [UIColor redColor];
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@, %1.0f min", [BusAttributeInfo getName:tempSA.routeName], directionLookup[tempSA.direction], (tempSA.arrivingSeconds) / 60];
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }
    
    if(indexPath.row  == [tempResult count]){
        firstTimeCalled = YES;
    }
    
    return cell;
}

@end
