//
//  APUtil.h
//  APTracking
//
//  Created by 郭天齐 on 2019/6/26.
//  Copyright © 2019 Jason Y Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol APUtilDelegate <NSObject>

- (void)sdkInitiate:(BOOL)isInitiate currentCountry:(NSString *)country;

@end

@interface APUtil : NSObject

@property (nonatomic, weak) id<APUtilDelegate> delegate;

+ (instancetype)sharedInstance;

- (void) shouldSDKInitiateForCurrentLocaleWithAppId:(NSString *)appid channel:(NSString *)channel withDelegate:(id<APUtilDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
