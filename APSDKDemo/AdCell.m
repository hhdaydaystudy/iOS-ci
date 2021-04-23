//
//  APAffiliateSDKTestViewCell.m
//  AffiliateSDKSample
//
//  Created by AP on 10/18/16.
//  Copyright © 2016 AP. All rights reserved.
#import "AdCell.h"
#import "ViewController.h"

typedef enum : NSUInteger {
    APDemoRequest,
    APDemoSuccess,
    APDemoShow,
    APDemoFail,
    APDemoLoading,
    APDemoHideBanner,
    APDemoShowBanner
} APDemoShowType;

@interface AdCell()
{
    APDemoShowType demoShowType;
}
@end

@implementation AdCell

- (void) setupWithSlot:(NSString *)slot
               andName:(NSString *)name
     andViewController:(UIViewController *)controller
{
    self.viewController = (ViewController *)controller;
    self.slot = slot;
    self.name = name;

    [self updateLabel:demoShowType];

}

- (void) setLoadingNative:(BOOL)loadingNative{
    _loadingNative = loadingNative;
}

- (IBAction) buttonClick:(id)sender{
    if([self.name isEqualToString:@"Native"]){
        if(!self.loadingNative){
            if(self.native){
                NativeAdController * controller = [[NativeAdController alloc] init];
                [controller presentWithAd:self.native];
                self.native = nil;
                [self updateLabel:APDemoRequest];
            }else{
                [self requestAd];
            }
        }
    }else if([self.name isEqualToString:@"Interstitial"]){
        if(!self.loadingInterstitial){
            if(self.interstitial){
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                [self.interstitial presentWithViewController:window.rootViewController];
            }else{
                [self requestAd];
            }
        }
    }else if([self.name isEqualToString:@"Splash"]){
        if(!self.loadingSplash){
            [self requestAd];
        }
    }else if([self.name isEqualToString:@"RewardVideo"]){
        if(!self.loadingRewardVideo){
            if(self.rewardVideo){
                if (self.rewardVideo.ap_isReady) {
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    [self.rewardVideo presentWithViewController:window.rootViewController];
                }
            }else{
                [self requestAd];
            }
        }
    }else if([self.name isEqualToString:@"Banner"])
    {
        if (self.loadingBanner)
        {
            return;
        }
        if (!self.banner)
        {
            self.loadingBanner = YES;
            CGFloat bottomDistance = 0;
            if ([self isPhoneX])
            {
                bottomDistance = 34;
            }
            APAdBannerSize bannerSize = APAdBannerSize728x90;
            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
            {
                bannerSize = APAdBannerSize320x50;
            }
            CGRect parentFrame = self.viewController.view.bounds;

            self.banner = [[APAdBannerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 90 , CGRectGetWidth(parentFrame), 100) Slot:self.slot adSize:bannerSize delegate:self rootViewController:self.viewController];
            [self.banner load];
            self.banner.interval = 20;
            [self.viewController.view addSubview:self.banner];
            [self updateLabel:APDemoLoading];
        }
        else
        {
            if (self.banner.hidden)
            {
                demoShowType = APDemoHideBanner;
                self.banner.hidden = NO;
            }
            else
            {
                demoShowType = APDemoShowBanner;
                self.banner.hidden = YES;
            }
            [self updateLabel:demoShowType];
        }
    }
}

- (BOOL)isPhoneX {
    BOOL iPhoneX = NO;
    if (@available(iOS 11.0, *))
    {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0)
        {
            iPhoneX = YES;
        }
    }
    return iPhoneX;
}

- (void) requestAd{
    self.label.text = [NSString stringWithFormat:@"%@ - Loading", self.name];
    if([self.name isEqualToString:@"Native"]){
        self.loadingNative = YES;
        self.native = [[APAdNative alloc] initWithSlot:self.slot andDelegate:self];
        [self.native load];
    }else if([self.name isEqualToString:@"Interstitial"]){
        self.loadingInterstitial = YES;
        self.interstitial = [[APAdInterstitial alloc]  initWithSlot:self.slot andDelegate:self];
        [self.interstitial load];
    }else if([self.name isEqualToString:@"Splash"]){
        self.loadingSplash = YES;
        self.splash = [[APAdSplash alloc] initWithSlot:self.slot andDelegate:self];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView * bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height /4)];
        bottom.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        label.text = @"icon";
        label.center =CGPointMake(bottom.bounds.size.width / 2, bottom.bounds.size.height/2);
        [bottom addSubview:label];
        [self.splash setDeeplinkTipWithTitle:@"您的应用将要跳转到淘宝"];
        [self.splash setSplashShowInterval:5];
        [self.splash setSplashMaxLoadInterval:3];
        [self.splash setSplashBottomView:bottom autoFitForDisplay:NO];
        [self.splash loadAndPresentWithViewController:window.rootViewController];
    }else if([self.name isEqualToString:@"RewardVideo"]){
        self.loadingRewardVideo = YES;
        self.rewardVideo = [[APAdRewardVideo alloc] initWithSlot:self.slot andDelegate:self];
        [self.rewardVideo load];
    }
}

- (void)updateLabel:(APDemoShowType)type
{
    demoShowType = type;
    switch (type)
    {
        case APDemoRequest:
            self.label.text = [NSString stringWithFormat:@"%@ - slotID:%@ - Request AD", self.name, self.slot];
            break;
        case APDemoFail:
            self.label.text = [NSString stringWithFormat:@"%@ - slotID:%@ - Fail，Request AD", self.name, self.slot];
            break;
        case APDemoShow:
            self.label.text = [NSString stringWithFormat:@"%@ - slotID:%@ - Success, Show AD", self.name, self.slot];
            break;
        case APDemoSuccess:
            self.label.text = [NSString stringWithFormat:@"%@ - slotID:%@ - Request AD", self.name, self.slot];
            break;
        case APDemoShowBanner:
            self.label.text = [NSString stringWithFormat:@"%@ - slotID:%@ - click show banner", self.name, self.slot];
            break;
        case APDemoHideBanner:
            self.label.text = [NSString stringWithFormat:@"%@ - slotID:%@ - click hide banner", self.name, self.slot];
            break;
        case APDemoLoading:
            self.label.text = [NSString stringWithFormat:@"%@ - slotID:%@ - loading...", self.name, self.slot];
            break;
        default:
            break;
    }
}

#pragma mark ======================= Banner Delegate =======================
- (void) apAdBannerViewDidLoadSuccess:(nonnull APAdBannerView *)ad
{
    self.loadingBanner = NO;
    NSLog(@"BannerView Ad received");
    static BOOL isFirstLoad = YES;
    if (isFirstLoad)
    {
        [self updateLabel:APDemoHideBanner];
        isFirstLoad = NO;
    }
}

-(void) apAdBannerViewDidLoadFail:(nonnull APAdBannerView *)ad
                        withError:(nonnull NSError *)err
{
    NSLog(@"BannerView Ad failed to receive, error = %@", err);
}

- (void) apAdBannerViewDidPresentSuccess:(nonnull APAdBannerView *)ad
{
    NSLog(@"BannerView Ad did present ");
}


- (void) apAdBannerViewDidDismiss:(nonnull APAdBannerView *)ad{
    NSLog(@"BannerView Ad did dismiss ");
}

- (void) apAdBannerViewDidClick:(nonnull APAdBannerView *)ad
{
    NSLog(@"BannerView Ad did click ");
}

#pragma mark ======================= RewardVideo Delegate =======================

- (void) apAdRewardVideoDidLoadSuccess:(nonnull APAdRewardVideo *)ad
{
    NSLog(@"RewardVideo Ad received");
    self.rewardVideo = ad;
    [self updateLabel:APDemoShow];
    self.loadingRewardVideo = NO;
}

- (void) apAdRewardVideoDidLoadFail:(nonnull APAdRewardVideo *)ad withError:(nonnull NSError *)err
{
    NSLog(@"RewardVideo Ad failed to receive, error = %@", err);
    self.rewardVideo = nil;
    [self updateLabel:APDemoFail];
    self.loadingRewardVideo = NO;
}

- (void) apAdRewardVideoDidPresentSuccess:(nonnull APAdRewardVideo *)ad
{
    NSLog(@"RewardVideo Ad did present");
}

- (void) apAdRewardVideoDidPresentFail:(nonnull APAdRewardVideo *)ad withError:(nonnull NSError *)err
{
    NSLog(@"RewardVideo Ad failed to present, error = %@", err);
    self.rewardVideo = nil;
    [self updateLabel:APDemoFail];
    self.loadingRewardVideo = NO;
}

- (void) apAdRewardVideoDidClick:(nonnull APAdRewardVideo *)ad
{
    NSLog(@"RewardVideo Ad did click");
}

- (void) apAdRewardVideoDidPlayComplete:(nonnull APAdRewardVideo *)ad
{
    NSLog(@"RewardVideo Ad did play complete");
}

- (void) apAdRewardVideoDidDismiss:(nonnull APAdRewardVideo *)ad
{
    NSLog(@"RewardVideo Ad did dismiss");
    self.rewardVideo = nil;
    [self updateLabel:APDemoRequest];
}

#pragma mark ======================= Interstitial Delegate =======================

- (void) apAdInterstitialDidLoadSuccess:(nonnull APAdInterstitial *) ad
{
    NSLog(@"Interstitial Ad received");
    self.interstitial = ad;
    [self updateLabel:APDemoShow];
    self.loadingInterstitial = NO;
}

- (void) apAdInterstitialDidLoadFail:(nonnull APAdInterstitial *) ad
                           withError:(nonnull NSError *) err
{
    NSLog(@"Interstitial Ad failed to receive, error = %@", err);
    self.interstitial = nil;
    [self updateLabel:APDemoFail];
    self.loadingInterstitial = NO;
}


- (void) apAdInterstitialDidPresentSuccess:(nonnull APAdInterstitial *) ad
{
    NSLog(@"Interstitial Ad did present");
}

- (void) apAdInterstitialDidPresentFail:(nonnull APAdInterstitial *)ad withError:(nonnull NSError *)err
{
    NSLog(@"Interstitial Ad did present fail,error = %@", err);
    self.interstitial = nil;
    [self updateLabel:APDemoFail];
    self.loadingInterstitial = NO;
}


- (void) apAdInterstitialDidClick:(nonnull APAdInterstitial *) ad
{
    NSLog(@"Interstitial Ad did click");
}

- (void) apAdInterstitialDidPresentLanding:(nonnull APAdInterstitial *)ad
{
    NSLog(@"Interstitial Ad Present Landing");
}

- (void) apAdInterstitialDidDismissLanding:(nonnull APAdInterstitial *)ad
{
    NSLog(@"Interstitial Ad Dismiss Landing");
}

- (void) apAdInterstitialApplicationWillEnterBackground:(nonnull APAdInterstitial *)ad
{
    NSLog(@"Interstitial Ad Will EnterBackground");

}

- (void) apAdInterstitialDidDismiss:(nonnull APAdInterstitial *)ad
{
    NSLog(@"Interstitial Ad did dismiss");
    self.interstitial = nil;
    [self updateLabel:APDemoRequest];
}

#pragma mark ======================= Native Delegate =======================
- (void) apAdNativeDidLoadSuccess:(nonnull APAdNative *)ad
{
    NSLog(@"Native Ad received");
    self.native = ad;
    [self updateLabel:APDemoShow];
    self.loadingNative = NO;
}

- (void) apAdNativeDidLoadFail:(nonnull APAdNative *)ad withError:(nonnull NSError *)err
{
    NSLog(@"Native Ad failed to receive, error = %@", err);
    self.native = nil;
    [self updateLabel:APDemoFail];
    self.loadingNative = NO;
}

- (void)apAdNativeDidPresentSuccess:(APAdNative *)ad
{
    NSLog(@"Native Present Success");
}

- (void) apAdNativeDidClick:(nonnull APAdNative *)ad
{
    NSLog(@"Native Click");
}

- (void) apAdNativeDidPresentLanding:(nonnull APAdNative *)ad
{
    NSLog(@"Native Ad Present Landing");
}

- (void) apAdNativeDidDismissLanding:(nonnull APAdNative *)ad
{
    NSLog(@"Native Ad Dismiss Landing");
}

- (void) apAdNativeApplicationWillEnterBackground:(nonnull APAdNative *)ad
{
    NSLog(@"Native Ad Will EnterBackground");
}

#pragma mark ======================= Splash Delegate =======================
- (void) apAdSplashDidLoadSuccess:(nonnull APAdSplash *)ad
{
    NSLog(@"Splash Ad Load Success");
}

- (void) apAdSplashDidLoadFail:(nonnull APAdSplash *)ad withError:(nonnull NSError *)err
{
    NSLog(@"Splash Ad failed to receive, error = %@", err);
    [self updateLabel:APDemoFail];
    self.splash = nil;
    self.loadingSplash = NO;
}

- (void) apAdSplashDidPresentSuccess:(nonnull APAdSplash *)ad
{
    self.loadingSplash = NO;
    NSLog(@"Splash Ad present success");
}

- (void) apAdSplashDidPresentFail:(nonnull APAdSplash *)ad withError:(nonnull NSError *)err
{
    self.splash = nil;
    [self updateLabel:APDemoFail];
    self.loadingSplash = NO;
    NSLog(@"Splash Ad present fail, error = %@", err);
}

- (void) apAdSplashDidClick:(nonnull APAdSplash *)ad
{
    NSLog(@"Splash Ad clicked");
}

- (void) apAdSplashDidPresentLanding:(nonnull APAdSplash *)ad
{
    NSLog(@"Splash Ad PresentLanding Success");
}

- (void) apAdSplashDidDismissLanding:(nonnull APAdSplash *)ad
{
    NSLog(@"Splash Ad DismissLanding Success");
}

- (void) apAdSplashApplicationWillEnterBackground:(nonnull APAdSplash *)ad
{
    NSLog(@"Splash Ad Will EnterBackground");
}

- (void) apAdSplashDidDismiss:(nonnull APAdSplash *)ad
{

    NSLog(@"Splash Ad dismissed");
    self.splash = nil;
    [self updateLabel:APDemoRequest];
}

// 广告每展示1秒触发一次此回调
// 广告自动关闭前一定触发最后一次并且time = 0;
// @param time 广告展示停留剩余时间，单位：毫秒
- (void) apAdSplashDidPresentTimeLeft:(NSUInteger)time
{
    NSLog(@"Splash Ad Did PresentTime Left %zdms",time);
}

- (void) apAdSplashDidAssembleViewFail:(nonnull APAdSplash *)ad withError:(nonnull NSError *)err
{
    NSLog(@"Splash Ad failed to Assemble, error = %@", err);
    [self updateLabel:APDemoFail];
    self.loadingSplash = NO;
}


@end
