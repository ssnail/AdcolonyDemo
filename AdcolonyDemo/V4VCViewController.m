//
//  ViewController.m
//  AdColonyV4VC
//
//  Created by John Fernandes-Salling on 8/15/12.
//

#import "V4VCViewController.h"
#import "Constants.h"

#import <AdColony/AdColony.h>


@interface V4VCViewController ()
@property IBOutlet UILabel* currencyLabel;
@property IBOutlet UIActivityIndicatorView* spinner;
@property IBOutlet UIButton* button;
- (void)updateCurrencyBalance;
@end

@implementation V4VCViewController
@synthesize currencyLabel, spinner, button;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
    return YES;
  }
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  int status = [AdColony zoneStatusForZone:v4vc_zone_id];
  if(status == ADCOLONY_ZONE_STATUS_LOADING){
    [self zoneLoading];
  }else if(status == ADCOLONY_ZONE_STATUS_ACTIVE){
    [self zoneReady];
  }else{
    [self zoneOff];
  }
  [self updateCurrencyBalance];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrencyBalance) name:kCurrencyBalanceChange object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zoneReady:) name:kZoneReady object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zoneOff:) name:kZoneOff object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zoneLoading:) name:kZoneLoading object:nil];
}

/*
- (void) viewWillDisappear:(BOOL)animated
{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kCurrencyBalanceChange object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kZoneReady object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kZoneOff object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kZoneLoading object:nil];
}
*/

- (void)zoneReady:(NSNotification *)center {
  NSString *zone = [center.userInfo objectForKey:@"zone"];
  if (![zone  isEqual: v4vc_zone_id]) {
    return;
  }
  [self zoneReady];
}

- (void)zoneReady{
  [spinner stopAnimating];
  [spinner setHidden:YES];
  [button setEnabled:YES];
}

- (void)zoneOff:(NSNotification *)center {
  NSString *zone = [center.userInfo objectForKey:@"zone"];
  if (![zone  isEqual: v4vc_zone_id]) {
    return;
  }
  [self zoneOff];
}

- (void)zoneOff{
  [spinner stopAnimating];
  [spinner setHidden:YES];
  [button setEnabled:NO];
}

- (void)zoneLoading:(NSNotification *)center {
  NSString *zone = [center.userInfo objectForKey:@"zone"];
  if (![zone  isEqual: v4vc_zone_id]) {
    return;
  }
  [self zoneLoading];
}

- (void)zoneLoading{
  [spinner setHidden:NO];
  [spinner startAnimating];
  [button setEnabled:NO];
}
// Get currency balance from persistent storage and display it
- (void)updateCurrencyBalance {
  NSNumber* wrappedBalance = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrencyBalance];
  NSUInteger balance = wrappedBalance && [wrappedBalance isKindOfClass:[NSNumber class]] ? [wrappedBalance unsignedIntValue] : 0;
  [currencyLabel setText:[NSString stringWithFormat:@"%u", balance]];
}

#pragma mark -
#pragma mark AdColony-specific
- (IBAction)triggerVideo
{
  //AdColonyNativeAdView *adna = [AdColony getNativeAdForZone:@"vz83f6bd9e26e4405d93" presentingViewController:self];
  //[self.view addSubview:adna];
  [AdColony playVideoAdForZone:v4vc_zone_id withDelegate:nil withV4VCPrePopup:YES andV4VCPostPopup:YES];
}

@end
