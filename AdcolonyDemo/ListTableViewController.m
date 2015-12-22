//
//  ListTableViewController.m
//  AdcolonyDemo
//
//  Created by Xiaofan Dai on 11/26/14.
//  Copyright (c) 2014 xiaofan.dai. All rights reserved.
//

#import "ListTableViewController.h"
#import "Constants.h"

@interface ListTableViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *interstitialIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *v4vcIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *instantFeedIndicator;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zoneReady:) name:kZoneReady object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zoneOff:) name:kZoneOff object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zoneLoading:) name:kZoneLoading object:nil];
  
}

//@"vz50dbff4940ae45acac", @"vz79fb5a2b990f489ba6", @"vz81b3518fbc664ca586"

- (UIActivityIndicatorView *)getIndicator:(NSNotification *)center{
  NSString *zone = [center.userInfo objectForKey:@"zone"];
  
  if ([zone  isEqual: interstitial_zone_id]) {
    return _interstitialIndicator;
  }else if([zone  isEqual: v4vc_zone_id]){
    return _v4vcIndicator;
  }else if([zone  isEqual: instant_feed_zone_id]){
    return _instantFeedIndicator;
  }else{
    return nil;
  }
}

- (void)zoneReady:(NSNotification *)center {
  UIActivityIndicatorView *spinner = [self getIndicator:center];
  [spinner stopAnimating];
  [spinner setHidden:YES];
}

- (void)zoneOff:(NSNotification *)center {
  UIActivityIndicatorView *spinner = [self getIndicator:center];
  [spinner stopAnimating];
  [spinner setHidden:YES];
}

- (void)zoneLoading:(NSNotification *)center {
  UIActivityIndicatorView *spinner = [self getIndicator:center];
  [spinner setHidden:NO];
  [spinner startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
