//
//  APAdBannerView.h
//  Copyright © 2018 AppicAd. All rights reserved.
//
@class APAdBannerView;

typedef NS_ENUM(NSUInteger, APAdBannerSize) {
    APAdBannerSize320x50        = 1, // => 320 x 50 iPhone Portrait
    APAdBannerSize468x60,            // => 468 x 60 iPad Portrait
    APAdBannerSize728x90             // => 728 x 90 iPad Portrait
};

@protocol APAdBannerViewDelegate <NSObject>
@optional
/**
 * BannerView ad slot loaded successfully.
 * @param ad : the ad for bannerview
 */

- (void) apAdBannerViewDidLoadSuccess:(nonnull APAdBannerView *)ad;
/**
 * BannerView ad slot failed to load.
 * @param ad : the ad for bannerview
 * @param err : the reason of error
 */
- (void) apAdBannerViewDidLoadFail:(nonnull APAdBannerView *)ad
                         withError:(nonnull NSError *)err;
/**
 * BannerView ad slot presented successfully.
 * @param ad : the ad for bannerview
 */
- (void) apAdBannerViewDidPresentSuccess:(nonnull APAdBannerView *)ad;

/**
 * BannerView ad landing is presented.
 * @param ad : the ad for bannerview
 */
- (void) apAdBannerViewDidClick:(nonnull APAdBannerView *)ad;

@end


@interface APAdBannerView : UIView

/**
 * interval minimum 20
 */
@property (nonatomic, assign) NSInteger interval;

@property (nonatomic, weak, nullable) id<APAdBannerViewDelegate> ap_delegate;

/**
 * The slot  used to request the bannerView ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ap_slot;

/**
 * Initialize a banner ad with the given slotId
 * @param slot : The slotId for loading the banner ad
 * @param delegate : The delegate to receive callbacks from APAdBannerView
 */
- (nonnull instancetype) initWithFrame:(CGRect)frame
                                  Slot:(nonnull NSString *)slot
                                adSize:(APAdBannerSize)size
                              delegate:(nullable id<APAdBannerViewDelegate>)delegate
                    rootViewController:(nullable UIViewController *)controller;


/**
 * Initialize a banner ad with the given slotId
 * @param slot : The slotId for loading the banner ad
 * @param delegate : The delegate to receive callbacks from APAdBannerView
 */
- (nonnull instancetype) initWithFrame:(CGRect)frame
                                  Slot:(nonnull NSString *)slot
                                adSize:(APAdBannerSize)size
                              delegate:(nullable id<APAdBannerViewDelegate>)delegate;

/**
 * required.
 * The root view controller for handling ad actions.
 */
@property (nonatomic, weak, readwrite, nullable) UIViewController *ap_adPresentLandingController;

/**
 * Load the bannerView ad
 */
- (void) load;

/**
 * Set to enable users to be prompted before leaving the app
 * @param title : text to show when prompted
 */
- (void) setDeeplinkTipWithTitle:(NSString *_Nullable)title;


@end
