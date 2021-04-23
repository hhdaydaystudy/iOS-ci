//
//  APAffiliateSDKTestViewCell.h
//  AffiliateSDKSample
//
//  Created by AP on 10/18/16.
//  Copyright © 2016 AP. All rights reserved.
//
#import "NativeAdController.h"

@class ViewController;

@interface AdCell : UITableViewCell<APAdInterstitialDelegate, APAdSplashDelegate, APAdBannerViewDelegate, APAdNativeDelegate,APAdRewardVideoDelegate>

@property (nonatomic, strong) NSString *slot, *name;
@property (nonatomic, strong) IBOutlet UIButton *button;
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) APAdInterstitial *interstitial;
@property (nonatomic, strong) APAdSplash *splash;
@property (nonatomic, strong) APAdBannerView * banner;
@property (nonatomic, strong) APAdNative * native;
@property (nonatomic, strong) APAdRewardVideo *rewardVideo;
@property (nonatomic, assign) BOOL loadingNative, loadingInterstitial, loadingSplash,loadingRewardVideo, loadingBanner;
@property (nonatomic, assign) ViewController * viewController;

- (void) setupWithSlot:(NSString *)slot
               andName:(NSString *)name
     andViewController:(UIViewController *)controller;

- (void) requestAd;

@end
