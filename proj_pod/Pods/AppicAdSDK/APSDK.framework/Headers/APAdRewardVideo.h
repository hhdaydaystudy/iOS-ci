//
//  APAdRewardVideo.h
//  Copyright (c) 2015 Appic. All rights reserved.
//

@class APAdRewardVideo;
@protocol APAdRewardVideoDelegate <NSObject>
@optional

/**
 * RewardVideo ad slot loaded successfully.
 * @param ad : the ad for rewardVideo
 */
- (void) apAdRewardVideoDidLoadSuccess:(nonnull APAdRewardVideo *)ad;

/**
 * RewardVideo ad slot failed to load.
 * @param ad : the ad for rewardVideo
 * @param err : the reason of error
 */
- (void) apAdRewardVideoDidLoadFail:(nonnull APAdRewardVideo *)ad withError:(nonnull NSError *)err;

/**
 * RewardVideo ad slot presented successfully.
 * @param ad : the ad for rewardVideo
 */
- (void) apAdRewardVideoDidPresentSuccess:(nonnull APAdRewardVideo *)ad;

/**
 * RewardVideo ad slot failed to present.
 * @param ad : the ad for rewardVideo
 * @param err : the reason of error
 */
- (void) apAdRewardVideoDidPresentFail:(nonnull APAdRewardVideo *)ad withError:(nonnull NSError *)err;

/**
 * RewardVideo ad is clicked.
 * @param ad : the ad for rewardVideo
 */
- (void) apAdRewardVideoDidClick:(nonnull APAdRewardVideo *)ad;

/**
 * RewardVideo ad is play complete.
 * @param ad : the ad for rewardVideo
 */
- (void) apAdRewardVideoDidPlayComplete:(nonnull APAdRewardVideo *)ad;

/**
 * RewardVideo ad is dismissed.
 * @param ad : the ad for rewardVideo
 */
- (void) apAdRewardVideoDidDismiss:(nonnull APAdRewardVideo *)ad;

/**
 * RewardVideo ad is skiped.
 * @param ad : the ad for rewardVideo
 */
- (void) apAdRewardVideoPresentDidSkip:(nonnull APAdRewardVideo *)ad;

@end

#import <Foundation/Foundation.h>

@interface APAdRewardVideo : NSObject

/**
 * The delegate to receive callbacks
 */
@property (nonatomic, weak, nullable) id<APAdRewardVideoDelegate> ap_delegate;

/**
 * The slot ID used to request the native ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ap_slot;

/**
 * The mute  used to set the playback mute state of the native video
 */
@property (nonatomic, assign) BOOL ap_mute;

/**
 * The isReady To query if the rewardvideo is ready to be shown
 */
@property (nonatomic, assign, readonly) BOOL ap_isReady;

/**
 * Initialize a rewardvideo ad with the given slotId
 * @param slot : The slotId for loading the rewardvideo ad
 * @param delegate : The delegate to receive callbacks from APAdRewardVideo
 */
- (nonnull instancetype) initWithSlot:(nonnull NSString *)slot
                          andDelegate:(nonnull id<APAdRewardVideoDelegate>) delegate;

/**
 * Load the rewardvideo ad
 */
- (void) load;

/**
 * Present rewardvideo ad.
 * @param controller : Required, the controller for presenting rewardvideo ad from
 */
- (void) presentWithViewController:(nonnull UIViewController *) controller;

/**
 * Set to enable users to be prompted before leaving the app
 * @param title : text to show when prompted
 */
- (void) setDeeplinkTipWithTitle:(NSString *_Nullable)title;


@end

