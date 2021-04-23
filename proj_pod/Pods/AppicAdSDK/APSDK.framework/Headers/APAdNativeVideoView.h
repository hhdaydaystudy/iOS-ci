//
//  APAdNativeVideoView.h
//  Copyright © 2018 AppicAd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class APAdNativeVideoView;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, APAdNativeVideoState) {
    APAdNativeVideoStateFailed    = 0,  // 播放失败
    APAdNativeVideoStateBuffering = 1,  // 缓冲中
    APAdNativeVideoStatePlaying   = 2,  // 播放中
    APAdNativeVideoStateStop      = 3,  // 停止播放
    APAdNativeVideoStatePause     = 4,  // 暂停播放
    APAdNativeVideoStateDefault   = 5   // 初始化状态
};

@protocol APAdNativeVideoViewDelegate <NSObject>

/**
 * The video playback status changes
 * @param view : the view for native video view
 * @param state : the state for native video view
 */
- (void) apAdNativeVideoView:(nonnull APAdNativeVideoView *)view didChangeState:(APAdNativeVideoState)state;

/**
 * The video finishes
 * @param view : the view for native video view
 */
- (void) apAdNativeVideoViewDidPlayFinish:(nonnull APAdNativeVideoView *)view;

@end

@interface APAdNativeVideoView : UIView

/**
 * The video state of the native video view.
 */
@property (nonatomic, assign) APAdNativeVideoState ap_videoState;

/**
 * The delegate to receive callbacks.
 */
@property (nonatomic, weak, nullable) id <APAdNativeVideoViewDelegate> ap_delegate;

/**
 * The mute  used to set the playback mute state of the native video
 */
@property (nonatomic, assign) BOOL ap_mute;

/**
 *  Set whether to mute
 *  @param mute : mute of the native  video view
 */
- (void) setMute:(BOOL)mute;

- (void) play;

- (void) pause;

@end



NS_ASSUME_NONNULL_END
