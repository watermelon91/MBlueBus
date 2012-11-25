//
//  LineViewPopoverContentController.m
//  MBlueBus
//
//  Created by Watermelon on 11/20/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "LineViewPopoverContentController.h"

@interface LineViewPopoverContentController ()

@end

@implementation LineViewPopoverContentController

@synthesize lineViewTable = _lineViewTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        lineNameList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lineViewTable.delegate = self;
    self.lineViewTable.scrollEnabled = YES;
    self.lineViewTable.bounces = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotification:) name:@"currentRouteDataUpdatedInMainView" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLineViewTable:nil];
    [super viewDidUnload];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return lineNameList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"MyCellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [lineNameList objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([lineArrivingInfoPopover isPopoverVisible]){
        [lineArrivingInfoPopover dismissPopoverAnimated:YES];
    }
    
    LineDetailedArrivingInfoContentController * lineInfoPC = [[LineDetailedArrivingInfoContentController alloc] init];
    lineInfoPC.lineSelected = [lineNameList objectAtIndex: indexPath.row];
    [self.navigationController pushViewController:lineInfoPC animated:YES];
}

- (void)getNotification:(NSNotification *)notification {
    RouteDataSource * tempRouteDataSource = [notification object];
    [lineNameList removeAllObjects];
    
    for(int i = 0; i < [tempRouteDataSource.parsedRoutes count]; i++){
        RouteInfo * tempR = [tempRouteDataSource.parsedRoutes objectAtIndex:i];
        
        [lineNameList addObject:tempR.routeName];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_lineViewTable reloadData];
    });
}

@end
