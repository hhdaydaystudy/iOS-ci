//
//  Created by AP on 1/1/2020.
//  Copyright © 2016~2020 AP. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol APSDKDelegate <NSObject>

/*
 * If implemented, this will get called when SDK has finished initialization
 */
- (void) sdkDidInitialize;

- (void) sdkFailedToInitializeWithError:(nonnull NSError *)error;

@end

@interface APSDK : NSObject

+ (nonnull APSDK *) sharedInstance;

- (void) initWithAppId:(nonnull NSString *)appid;

- (void) initWithAppId:(nonnull NSString *)appid
           andDelegate:(nullable id<APSDKDelegate>)delegate;

- (nonnull NSString *) sdkVersion;

@end
