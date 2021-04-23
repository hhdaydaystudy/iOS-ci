//
//  APAdNative.h
//  Copyright © 2018 AppicAd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class APAdNative;
@class APAdNativeVideoView;


@protocol APAdNativeDelegate <NSObject>

@optional

/**
 * Native ad slot loaded successfully.
 * @param ad : the ad for native
 */
- (void) apAdNativeDidLoadSuccess:(nonnull APAdNative *)ad;

/**
 * Native ad slot failed to load.
 * @param ad : the ad for native
 * @param err : the reason of error
 */
- (void) apAdNativeDidLoadFail:(nonnull APAdNative *)ad withError:(nonnull NSError *)err;

/**
 * Native ad slot presented successfully.
 * @param ad : the ad for native
 */
- (void) apAdNativeDidPresentSuccess:(nonnull APAdNative *) ad;

/**
 * Native ad is clicked.
 * @param ad : the ad for native
 */
- (void) apAdNativeDidClick:(nonnull APAdNative *)ad;

/**
 * Native ad landing page is presented.
 * @param ad : the ad for native
 */
- (void) apAdNativeDidPresentLanding:(nonnull APAdNative *)ad;

/**
 * Native ad landing page is dismissed.
 * @param ad : the ad for native
 */
- (void) apAdNativeDidDismissLanding:(nonnull APAdNative *)ad;

/**
 * After ad is clicked, native ad will enter background.
 * @param ad : the ad for native
 */
- (void) apAdNativeApplicationWillEnterBackground:(nonnull APAdNative *)ad;


@end

@interface APAdNative : NSObject

/**
 * The delegate to receive callbacks.
 */
@property (nonatomic, weak, nullable) id <APAdNativeDelegate> ap_delegate;
/**
 * The slot  used to request the native ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ap_slot;
/**
 * The title of the native ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ap_adTitle;
/**
 * The description of the native ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ap_adDescription;
/**
 * The icon url of the native ad.
 */
@property (nonatomic, strong, readonly, nullable) NSString *ap_adIconUrl;
/**
 * The image url of the native ad.
 */
@property (nonatomic, strong, readonly, nullable) NSString *ap_adScreenshotUrl;
/**
 * The video of the native ad.
 */
@property (nonatomic, strong, readonly, nullable) APAdNativeVideoView *ap_adVideo;
/**
 * required.
 * The root view controller for handling ad actions.
 */
@property (nonatomic, weak, readwrite, nullable) UIViewController *ap_adPresentLandingController;

/**
 * Initialize a native ad with the given slotId.
 * @param slot : The slotId for loading the native ad.
 * @param delegate : The delegate to receive callbacks from APAdNative.
 */
- (nonnull instancetype) initWithSlot:(nonnull NSString *)slot
                          andDelegate:(nonnull id<APAdNativeDelegate>)delegate;

/**
 * Loads a native ad
 */
- (void) load;

/**
 * Register a clickable views that is containing the native ad asset.
 * @param view : Required, container view of the native ad.
 * @note Please call this method after loading successfully，Do not repeatedly register the same view for the same view object
 * @return Whether it is successfully registered.
 */
- (BOOL) registerContainerView:(__kindof UIView *_Nonnull)view;

/**
 * Set to enable users to be prompted before leaving the app
 * @param title : text to show when prompted
 */
- (void) setDeeplinkTipWithTitle:(NSString *_Nullable)title;

@end

