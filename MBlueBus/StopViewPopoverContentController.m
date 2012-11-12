//
//  StopViewPopoverContentController.m
//  MBlueBus
//
//  Created by Watermelon on 11/11/12.
//  Copyright (c) 2012 Yijia Tang. All rights reserved.
//

#import "StopViewPopoverContentController.h"

@interface StopViewPopoverContentController ()

@end

@implementation StopViewPopoverContentController

@synthesize stopViewTable = _stopViewTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        stopNameList = [[NSMutableArray alloc] init];
        [self popStopNameList];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.stopViewTable.delegate = self;
    self.stopViewTable.scrollEnabled = YES;
    self.stopViewTable.bounces = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setStopViewTable:nil];
    [super viewDidUnload];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return stopNameList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"MyCellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [stopNameList objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([stopArrivingInfoPopover isPopoverVisible]){
        [stopArrivingInfoPopover dismissPopoverAnimated:YES];
    }
    
    StopDetailedArrivingInfoContentController * stopInfoPC = [[StopDetailedArrivingInfoContentController alloc] init];
    stopInfoPC.selectedStop = [stopNameList objectAtIndex: indexPath.row];
    [self.navigationController pushViewController:stopInfoPC animated:YES];
    /*
    stopArrivingInfoPopover = [[UIPopoverController alloc]
                               initWithContentViewController:stopInfoPC];
    [stopArrivingInfoPopover presentPopoverFromRect:CGRectMake(0.0f, 0.0f, 320.0f, 109.0f) inView:tableView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES]; */
    
    /*UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Item Selected"
                          message:@"Selected"
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];*/
}

- (void)popStopNameList{
    [stopNameList addObject:@"Admin Services"];
    [stopNameList addObject:@"Arbor Lakes"];
    [stopNameList addObject:@"BIR Building"];
    [stopNameList addObject:@"BSR Building"];
    [stopNameList addObject:@"Baits I"];
    [stopNameList addObject:@"Baits II"];
    [stopNameList addObject:@"Baits II (Ziwet)"];
    [stopNameList addObject:@"Bishop Street"];
    [stopNameList addObject:@"Bursley"];
    [stopNameList addObject:@"Campus Safety"];
    [stopNameList addObject:@"Cancer Center"];
    [stopNameList addObject:@"Cancer Center Driveway"];
    [stopNameList addObject:@"Central Transit Center"];
    [stopNameList addObject:@"Church at Geddes"];
    [stopNameList addObject:@"Commonwealth"];
    [stopNameList addObject:@"Community Center"];
    [stopNameList addObject:@"Cooley Lab"];
    [stopNameList addObject:@"Couzens"];
    [stopNameList addObject:@"Cram Circle"];
    [stopNameList addObject:@"Crisler Arena"];
    [stopNameList addObject:@"Crisler Lot SC7"];
    [stopNameList addObject:@"Delhi Metor Park"];
    [stopNameList addObject:@"Dextar-Ann Arbor Run"];
    [stopNameList addObject:@"Dextar High sCHOOL"];
    [stopNameList addObject:@"Dextar-AA Staging"];
    [stopNameList addObject:@"Dominos Farms"];
    [stopNameList addObject:@"EAAHC"];
    [stopNameList addObject:@"East Hall"];
    [stopNameList addObject:@"East Quad"];
    [stopNameList addObject:@"FXB"];
    [stopNameList addObject:@"Fire Station"];
    [stopNameList addObject:@"Glazier Way"];
    [stopNameList addObject:@"Glen at Catherine"];
    [stopNameList addObject:@"Green Rd"];
    [stopNameList addObject:@"Hayward at NC-53"];
    [stopNameList addObject:@"Henderson House"];
    [stopNameList addObject:@"Hubbard at Cram Cir."];
    [stopNameList addObject:@"Hubbard at Cram Cirle"];
    [stopNameList addObject:@"Hubbard at Hayward"];
    [stopNameList addObject:@"Hubbard at Huron Parkway"];
    [stopNameList addObject:@"Hubbard at Murfin"];
    [stopNameList addObject:@"Hubbard at NC-46"];
    [stopNameList addObject:@"Hubbard at NW III"];
    [stopNameList addObject:@"Huron at Hubbard"];
    [stopNameList addObject:@"ICLE"];
    [stopNameList addObject:@"IM Building"];
    [stopNameList addObject:@"KDTW"];
    [stopNameList addObject:@"KMS"];
    [stopNameList addObject:@"Kellogg Eye Center"];
    [stopNameList addObject:@"Kipke at Greene"];
    [stopNameList addObject:@"Kresge"];
    [stopNameList addObject:@"Lot M-75"];
    [stopNameList addObject:@"Markley"];
    [stopNameList addObject:@"Mclntyre at NW 44"];
    [stopNameList addObject:@"Mclntyre at NW 46"];
    [stopNameList addObject:@"Mclntyre at NW-44"];
    [stopNameList addObject:@"Mclntyre at NW-46"];
    [stopNameList addObject:@"Mitchell Field"];
    [stopNameList addObject:@"Mosher-Jordan"];
    [stopNameList addObject:@"Mott Employee Entrance"];
    [stopNameList addObject:@"Murfin at NW3"];
    [stopNameList addObject:@"NCAC Baxter"];
    [stopNameList addObject:@"NCAC Hubbard"];
    [stopNameList addObject:@"NCRC"];
    [stopNameList addObject:@"NIB"];
    [stopNameList addObject:@"North U at Fletcher"];
    [stopNameList addObject:@"North U at Thayer"];
    [stopNameList addObject:@"Northwood Community Center"];
    [stopNameList addObject:@"Northwood V"];
    [stopNameList addObject:@"Oxford Housing"];
    [stopNameList addObject:@"Pierpont"];
    [stopNameList addObject:@"Plant Serces N"];
    [stopNameList addObject:@"Power Center"];
    [stopNameList addObject:@"Shapiro Library"];
    [stopNameList addObject:@"Simpson Building"];
    [stopNameList addObject:@"Steiner School"];
    [stopNameList addObject:@"Stockwell"];
    [stopNameList addObject:@"Taubman Center"];
    [stopNameList addObject:@"Transportation"];
    [stopNameList addObject:@"Trotter House"];
    [stopNameList addObject:@"Turner Senior Ctr"];
    [stopNameList addObject:@"Union"];
    [stopNameList addObject:@"V. Vaughan"];
    [stopNameList addObject:@"VA"];
    [stopNameList addObject:@"Wall St."];
}

@end
