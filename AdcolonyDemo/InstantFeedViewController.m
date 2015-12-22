//
//  InstantFeedViewController.m
//  AdcolonyDemo
//
//  Created by Xiaofan Dai on 11/20/14.
//  Copyright (c) 2014 xiaofan.dai. All rights reserved.
//

#import "InstantFeedViewController.h"

@interface InstantFeedViewController (){
  AdColonyNativeAdView* adView;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *descLable;
@property (weak, nonatomic) IBOutlet UIView *videoContainer;
@property (weak, nonatomic) IBOutlet UIView *engagementBtnContainer;
@property (weak, nonatomic) IBOutlet UIView *adContainer;


@end

@implementation InstantFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [self buildPlacement];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildPlacement {
  adView = [AdColony getNativeAdForZone:instant_feed_zone_id
                                     presentingViewController:self];
  if(adView) {
    /* Ad was available, gather ad placement info */
    NSString* advertiserName = adView.advertiserName; // Required
    UIImage* advertiserIcon = adView.advertiserIcon; // Optional
    NSString* adTitle = adView.adTitle; // Optional
    NSString* adDescription = adView.adDescription; // Optional
    
    /* Set up the sponsored content indicator */
    NSString* sponsoredMessage = @"Sponsored Content"; // Required
    
    /* Style the ad's (optional) engagement button to match the app */
    UIButton* engagementButton = adView.engagementButton;
    if(engagementButton) {
      /* Adjust button background image, font color, etc. ... */
      [engagementButton setBackgroundColor:[UIColor greenColor]];
      [_engagementBtnContainer addSubview:engagementButton];
    }
    
    /* Adjust the size of the native ad view */
    CGFloat adWidth = _videoContainer.bounds.size.width;
    CGFloat adHeight = [adView recommendedHeightForWidth:adWidth];
    adView.frame = CGRectMake(0, 0, adWidth, adHeight);
    //adView.backgroundColor = [UIColor redColor];
    [_videoContainer addSubview:adView];
    _imageView.image = advertiserIcon;
    _nameLable.text = advertiserName;
    _titleLable.text = adTitle;
    _descLable.text = adDescription;
  }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  NSLog(@"scrolling");
  float yVideo = _adContainer.frame.origin.y+_videoContainer.frame.origin.y;
  float halfHeightOfVideo =adView.frame.size.height/2;
  float midY = yVideo + halfHeightOfVideo - scrollView.contentOffset.y;

  if(midY < 0 || midY > _scrollView.frame.size.height){
    [adView pause];
  }else{
    [adView resume];
  }
  
}

- (void)viewWillDisappear:(BOOL)animated{
  [adView pause];
}

-(void)viewDidAppear:(BOOL)animated{
  [adView resume];
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
