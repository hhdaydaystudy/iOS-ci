//
//  APAdSplash.h
//  Copyright © 2018 AppicAd. All rights reserved.
//

@class APAdSplash;

@protocol APAdSplashDelegate <NSObject>

@optional
/**
 * Splash ad slot loaded successfully.
 * @param ad : the ad for splash
 */
- (void) apAdSplashDidLoadSuccess:(nonnull APAdSplash *)ad;

/**
 * Splash ad slot failed to load.
 * @param ad : the ad for splash
 * @param err : the reason of error
 */
- (void) apAdSplashDidLoadFail:(nonnull APAdSplash *)ad withError:(nonnull NSError *)err;

/**
 * Splash ad slot presented successfully.
 * @param ad : the ad for splash
 */
- (void) apAdSplashDidPresentSuccess:(nonnull APAdSplash *)ad;

/**
 * Splash ad slot failed to present.
 * @param ad : the ad for splash
 * @param err : the reason of error
 */
- (void) apAdSplashDidPresentFail:(nonnull APAdSplash *)ad withError:(nonnull NSError *)err;

/**
 * Splash ad is clicked.
 * @param ad : the ad for splash
 */
- (void) apAdSplashDidClick:(nonnull APAdSplash *)ad;

/**
 * Splash ad landing is presented.
 * @param ad : the ad for splash
 */
- (void) apAdSplashDidPresentLanding:(nonnull APAdSplash *)ad;

/**
 * Splash ad landing is dismissed.
 * @param ad : the ad for splash
 */
- (void) apAdSplashDidDismissLanding:(nonnull APAdSplash *)ad;

/**
 * After ad is clicked, splash ad application will enter background.
 * @param ad : the ad for splash
 */
- (void) apAdSplashApplicationWillEnterBackground:(nonnull APAdSplash *)ad;

/**
 * Splash ad is dismissed.
 * @param ad : the ad for splash
 */
- (void) apAdSplashDidDismiss:(nonnull APAdSplash *)ad;

/**
 * Splash ad periodically reports time left for splash impression.
 * @param time : the time for splash to present,  unit ms.
 */
- (void) apAdSplashDidPresentTimeLeft:(NSUInteger)time;

@end

@interface APAdSplash : NSObject

/**
 * The delegate to receive callbacks.
 */
@property (nonatomic, weak, nullable) id<APAdSplashDelegate> ap_delegate;

/**
 * Initialize a splash ad with the given slotId
 * @param slot : The slotId for loading the splash ad
 * @param delegate : The delegate to receive callbacks from APAdSplash
 */
- (nonnull instancetype) initWithSlot:(nonnull NSString *)slot
                          andDelegate:(nonnull id<APAdSplashDelegate>)delegate;

/**
 * Set show time of splash ad, unit s.
 * @param interval : interval for  display time to splash, default  5 seconds
 * @return Whether it is successfully set.
 */
- (BOOL) setSplashShowInterval:(NSUInteger)interval;

/**
 * Set maximum load time allowed for splash ad, unit s.
 * @param interval : interval for load to splash, default 3 seconds
 * @return Whether it is successfully set.
 */
- (BOOL) setSplashMaxLoadInterval:(double)interval;

/**
 * Set bottom view of splash ad .
 * @param view : bottom view of the splash ad
 * @param autofit : autofit NO : BottomView will always show, YES : Automatically fitted according to the screen size less space requried for ad asset.
 */
- (void) setSplashBottomView:(__kindof UIView *_Nullable)view autoFitForDisplay:(BOOL)autofit;

/**
 * Set background color of splash ad .
 * @param color : color of the splash ad, default to white
 */
- (void) setSplashBackgroundColor:(UIColor *_Nullable)color;

/**
 * Set  background image of splash ad.
 * @param image : image of the splash ad
 */
- (void) setSplashBackgroundImage:(UIImage *_Nullable)image;

/**
 * Set close button view of splash ad.
 * @param view : view of the close button
 */
- (void) setSplashCloseButtonView:(__kindof UIView *_Nullable)view;

/**
 * Set close button center of splash ad.
 * @param center : point of desired button center
 */
- (void) setSplashCloseButtonCenter:(CGPoint)center;

/**
 * Set to enable users to be prompted before leaving the app
 * @param title : text to show when prompted
 */
- (void) setDeeplinkTipWithTitle:(NSString *_Nullable)title;

/**
 * Present splash ad.
 * @param controller : Required, the controller for presenting splash ad from
 */
- (void) presentWithViewController:(UIViewController * _Nonnull)controller;

/**
 * Present immediately when splash ad is loaded successfully
 * @param controller : Required, the controller for presenting splash ad from
 */
- (void) loadAndPresentWithViewController:(UIViewController * _Nonnull)controller;

/**
 * The slot  used to request the splash ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ap_slot;

/**
 * Load the splash ad
 */
- (void) load;

@end
