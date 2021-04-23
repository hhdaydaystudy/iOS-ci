//
//  AppDelegate.m
//  AffiliateSDKSample
//
//  Created by Jason Y Liu on 5/11/16.
//  Copyright © 2016 Jason Y Liu. All rights reserved.
//

@import AVFoundation;
@import Accelerate;
@import AdSupport;
@import AudioToolbox;
@import CFNetwork;
@import CoreData;
@import CoreGraphics;
@import CoreImage;
@import CoreLocation;
@import CoreMedia;
@import CoreMotion;
@import CoreTelephony;
@import CoreVideo;
@import EventKit;
@import EventKitUI;
@import Foundation;
@import GLKit;
@import MediaPlayer;
@import MessageUI;
@import MobileCoreServices;
@import OpenGLES;
@import QuartzCore;
@import SafariServices;
@import Security;
@import Social;
@import StoreKit;
@import SystemConfiguration;
@import UIKit;
@import VideoToolbox;
@import WebKit;

#import "AppDelegate.h"
#import "ViewController.h"
#import <objc/runtime.h>
#import <APSDK/APSDK.h>
//#import <DoraemonManager.h>

@interface AppDelegate ()


@end

@implementation AppDelegate

+(void)replaceInstanceSelector:(SEL)selector fromClass:(Class)original toClass:(Class)stub {
    Method originalMethod =class_getInstanceMethod(original,selector);
    Method stubMethod =class_getInstanceMethod(stub,selector);
    if (!originalMethod ||!stubMethod){
        [NSException raise:NSInternalInconsistencyException format:@"Couldn't load class or method."];
    }
    method_exchangeImplementations(originalMethod,stubMethod);
}

//
-(BOOL) isJailBroken{
    return NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//#ifdef DEBUG
//    [[DoraemonManager shareInstance] install];//productId为在“平台端操作指南”中申请的产品id
//#endif
    
    [[APSDK sharedInstance] initWithAppId:@"EJOnLKynzwypakow-Rw6KoW"];
    NSLog(@"版本号 - %@", [[APSDK sharedInstance] sdkVersion]);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return YES;
}

@end
