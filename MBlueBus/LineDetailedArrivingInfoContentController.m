//
//  LineDetailedArrivingInfoContentController.m
//  MBlueBus
//
//  Created by Watermelon on 11/20/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "LineDetailedArrivingInfoContentController.h"

@interface LineDetailedArrivingInfoContentController ()

@end

@implementation LineDetailedArrivingInfoContentController

@synthesize lineSelected = _lineSelected;
@synthesize lineArrivingInfoTable = _lineArrivingInfoTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        firstTimeCalled = YES;
        lineInfoDictionary = [[NSMutableDictionary alloc] init];
        tempResult = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLineArrivingInfoTable:nil];
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotification:) name:@"currentRouteDataUpdatedInMainView" object:nil];
}

- (void)getNotification:(NSNotification *)notification{
    RouteDataSource * tempRouteDataSource = [notification object];
    [lineInfoDictionary removeAllObjects];
    
    for(int i = 0; i < [tempRouteDataSource.parsedRoutes count]; i++){
        RouteInfo * tempR = [tempRouteDataSource.parsedRoutes objectAtIndex:i];
        bool isLoop;
        if(tempR.topOfLoop != 0){
            isLoop = YES;
        }else{
            isLoop = NO;
        }

        NSMutableArray * currentLineInfo = [[NSMutableArray alloc] init];

        for (int j = 0; j < tempR.stopCount; j++) {
            StopInfo * tempS = [tempR.stops objectAtIndex:j];            
            LineViewAllStopArrivingInfo * thisStop = [[LineViewAllStopArrivingInfo alloc] init];
            thisStop.stopName = tempS.commonName;
            NSInteger minArrivingTime = INT_MAX;
            for(int h = 0; h <tempS.busInOperationNum; h++){
                ArrivalInfo * arv = [tempS.arrivingSeconds objectAtIndex:h];
                if(minArrivingTime >= arv.arrivingSeconds){
                    minArrivingTime = arv.arrivingSeconds;
                }
            }
            
            minArrivingTime = minArrivingTime / 60;
            if(minArrivingTime < 1){
                thisStop.arrivingTime = @"Arriving";
            }else{
                thisStop.arrivingTime = [NSString stringWithFormat:@"%d", minArrivingTime];
            }
            
            [currentLineInfo addObject:thisStop];
        }
        
        [lineInfoDictionary setObject:currentLineInfo forKey:tempR.routeName];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_lineArrivingInfoTable reloadData];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[lineInfoDictionary objectForKey:_lineSelected] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"MyCellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    if(firstTimeCalled){
        tempResult = [lineInfoDictionary objectForKey:self.lineSelected];
        firstTimeCalled = NO;
    }
    
    if(indexPath.row < [tempResult count]){
        // Update cell textlabel
        LineViewAllStopArrivingInfo * tempSA = [tempResult objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", tempSA.stopName, tempSA.arrivingTime];
    }
    
    if(indexPath.row == [tempResult count]){
        firstTimeCalled = YES;
    }
    
    return cell;
}

@end
