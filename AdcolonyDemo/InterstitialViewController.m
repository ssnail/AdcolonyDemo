//
//  InterstitialViewController.m
//  AdcolonyDemo
//
//  Created by Xiaofan Dai on 11/21/14.
//  Copyright (c) 2014 xiaofan.dai. All rights reserved.
//

#import "InterstitialViewController.h"
#import "Constants.h"

#import <AdColony/AdColony.h>


@interface InterstitialViewController ()

@end

@implementation InterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  int status = [AdColony zoneStatusForZone:interstitial_zone_id];
  if(status == ADCOLONY_ZONE_STATUS_ACTIVE){
    [AdColony playVideoAdForZone:interstitial_zone_id withDelegate:nil];
  }
  
  //[AdColony playVideoAdForZone:@"vz1ecd86dfb84d4f5295" withDelegate:nil];
  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
