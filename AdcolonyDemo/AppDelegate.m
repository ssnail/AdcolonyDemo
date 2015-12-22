//
//  AppDelegate.m
//  AdcolonyDemo
//
//  Created by Xiaofan Dai on 11/20/14.
//  Copyright (c) 2014 xiaofan.dai. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  
  // Initialize AdColony only once, on initial launch
  [AdColony configureWithAppID:app_id zoneIDs:@[interstitial_zone_id, v4vc_zone_id, instant_feed_zone_id] delegate:self logging:YES];
  
  /*
  [AdColony configureWithAppID:@"app1f6a5d139e1143299a"
   
                       zoneIDs:@[@"vz1ecd86dfb84d4f5295"]
   
                      delegate:nil
   
                       logging:YES];
   */
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -
#pragma mark AdColony V4VC

// Callback activated when a V4VC currency reward succeeds or fails
// This implementation is designed for client-side virtual currency without a server
// It uses NSUserDefaults for persistent client-side storage of the currency balance
// For applications with a server, contact the server to retrieve an updated currency balance
// On success, posts an NSNotification so the rest of the app can update the UI
// On failure, posts an NSNotification so the rest of the app can disable V4VC UI elements
- ( void ) onAdColonyV4VCReward:(BOOL)success currencyName:(NSString*)currencyName currencyAmount:(int)amount inZone:(NSString*)zoneID {
  NSLog(@"AdColony zone %@ reward %i %i %@", zoneID, success, amount, currencyName);
  
  if (success) {
    NSUserDefaults* storage = [NSUserDefaults standardUserDefaults];
    
    // Get currency balance from persistent storage and update it
    NSNumber* wrappedBalance = [storage objectForKey:kCurrencyBalance];
    NSUInteger balance = wrappedBalance && [wrappedBalance isKindOfClass:[NSNumber class]] ? [wrappedBalance unsignedIntValue] : 0;
    balance += amount;
    
    // Persist the currency balance
    [storage setValue:[NSNumber numberWithUnsignedInt:balance] forKey:kCurrencyBalance];
    [storage synchronize];
    
    // Post a notification so the rest of the app knows the balance changed
    [[NSNotificationCenter defaultCenter] postNotificationName:kCurrencyBalanceChange object:nil];
  } else {
    [[NSNotificationCenter defaultCenter] postNotificationName:kZoneOff object:nil];
  }
}

#pragma mark -
#pragma mark AdColony ad fill

- ( void ) onAdColonyAdAvailabilityChange:(BOOL)available inZone:(NSString*) zoneID {
  if(available) {
    [[NSNotificationCenter defaultCenter] postNotificationName:kZoneReady object:nil userInfo:@{@"zone":zoneID}];
  } else {
    [[NSNotificationCenter defaultCenter] postNotificationName:kZoneLoading object:nil userInfo:@{@"zone":zoneID}];
  }
}

@end
