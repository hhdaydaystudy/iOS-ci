//
//  APAdInterstitial.h
//  Copyright (c) 2015 Appic. All rights reserved.
//

@class APAdInterstitial;

@protocol APAdInterstitialDelegate <NSObject>
@optional
/**
 * Interstitial ad slot loaded successfully.
 * @param ad : the ad for interstitial
 */
- (void) apAdInterstitialDidLoadSuccess:(nonnull APAdInterstitial *) ad;

/**
 * Interstitial ad slot failed to load.
 * @param ad : the ad for interstitial
 * @param err : the reason of error
 */
- (void) apAdInterstitialDidLoadFail:(nonnull APAdInterstitial *) ad
                           withError:(nonnull NSError *) err;

/**
 * Interstitial ad slot presented successfully.
 * @param ad : the ad for interstitial
 */
- (void) apAdInterstitialDidPresentSuccess:(nonnull APAdInterstitial *) ad;

/**
 * Interstitial ad slot failed to present.
 * @param ad : the ad for interstitial
 * @param err : the reason of error
 */
- (void) apAdInterstitialDidPresentFail:(nonnull APAdInterstitial *)ad withError:(nonnull NSError *)err;

/**
 * Interstitial ad is clicked.
 * @param ad : the ad for interstitial
 */
- (void) apAdInterstitialDidClick:(nonnull APAdInterstitial *) ad;

/**
 * Interstitial ad landing is presented.
 * @param ad : the ad for interstitial
 */
- (void) apAdInterstitialDidPresentLanding:(nonnull APAdInterstitial *)ad;

/**
 * Interstitial ad landing is dismissed.
 * @param ad : the ad for interstitial
 */
- (void) apAdInterstitialDidDismissLanding:(nonnull APAdInterstitial *)ad;

/**
 * After ad is clicked, interstitial ad application will enter background.
 * @param ad : the ad for interstitial
 */
- (void) apAdInterstitialApplicationWillEnterBackground:(nonnull APAdInterstitial *)ad;

/**
 * Interstitial ad is dismissed.
 * @param ad : the ad for interstitial
 */
- (void) apAdInterstitialDidDismiss:(nonnull APAdInterstitial *)ad;

@end

@interface APAdInterstitial : NSObject
/**
 * The delegate to receive callbacks
 */
@property (nonatomic, weak, nullable) id<APAdInterstitialDelegate> ap_delegate;

/**
 * The slot ID used to request the native ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ap_slot;

/**
 * The mute  used to set the playback mute state of the native video
 */
@property (nonatomic, assign) BOOL ap_mute;

/**
 * The isReady To query if the interstitial is ready to be shown
 */
@property (nonatomic, assign, readonly) BOOL ap_isReady;

/**
 * Initialize a interstitial ad with the given slotId
 * @param slot : The slotId for loading the interstitial ad
 * @param delegate : The delegate to receive callbacks from APAdInterstitial
 */
- (nonnull instancetype) initWithSlot:(nonnull NSString *) slot
                          andDelegate:(nonnull id<APAdInterstitialDelegate>) delegate;
/**
 * Load the interstitial ad
 */
- (void) load;

/**
 * Present interstitial ad.
 * @param controller : Required, the controller for presenting interstitial ad from
 */
- (void) presentWithViewController:(nonnull UIViewController *) controller;

/**
 * Set to enable users to be prompted before leaving the app
 * @param title : text to show when prompted
 */
- (void) setDeeplinkTipWithTitle:(NSString *_Nullable)title;

@end

