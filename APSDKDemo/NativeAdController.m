//
//  NativeAdController.m
//  AffiliateSDKSample_NativeAd
//
//  Created by Jason Y Liu on 16/08/2017.
//  Copyright © 2017 Jason Y Liu. All rights reserved.
//
#import "NativeAdController.h"

@implementation NativeAdController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) presentWithAd:(APAdNative *)ad{
    self.ad = ad;

    UIScreen *screen = [UIScreen mainScreen];
    
    self.view = [[UIView alloc] initWithFrame:screen.bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *backcover = [[UIView alloc] initWithFrame:screen.bounds];
    backcover.userInteractionEnabled = NO;
    backcover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backcover];
    
    UIView *primaryView;
    if (self.ad)
    {
        CGFloat scale = 690.f/388.f;
        CGSize size = CGSizeMake(screen.bounds.size.width, screen.bounds.size.height);
        self.ad.ap_adPresentLandingController = self;
        UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:80];
        BOOL isOK = [self.ad registerContainerView:bgView];
        if (isOK) {
            primaryView = bgView;
        }

        CGFloat distance_y = 100;

        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width-100, 30)];
        title.text = self.ad.ap_adTitle;
        title.textColor = UIColor.whiteColor;
        title.font = [UIFont systemFontOfSize:18];
        title.center = CGPointMake(size.width/2, distance_y);
        title.lineBreakMode = NSLineBreakByTruncatingTail;
        title.numberOfLines = 0;
        [bgView addSubview:title];

        distance_y += 50;
        UILabel * desLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width-100, 60)];
        desLabel.text = self.ad.ap_adDescription;
        desLabel.textColor = UIColor.whiteColor;
        desLabel.font = [UIFont systemFontOfSize:14];
        desLabel.center = CGPointMake(size.width/2, distance_y);
        desLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        desLabel.numberOfLines = 0;
        [bgView addSubview:desLabel];


        if (self.ad.ap_adVideo)
        {
            distance_y += 130;
            UIView * videoView = self.ad.ap_adVideo;
            videoView.frame = CGRectMake(0, 0, 200, 200/scale);
            videoView.center = CGPointMake(size.width/2, distance_y);
            [bgView addSubview:videoView];
        }
        if (self.ad.ap_adIconUrl)
        {
            distance_y += 150;
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 125)];
            imageView.center = CGPointMake(size.width/2, distance_y);
            [bgView addSubview:imageView];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.ad.ap_adIconUrl]];
                UIImage * image = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = image;
                });
            });
            
        }
        if (self.ad.ap_adScreenshotUrl)
        {
            distance_y += 200;
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 240/scale)];
            imageView.center = CGPointMake(size.width/2, distance_y);
            [bgView addSubview:imageView];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.ad.ap_adScreenshotUrl]];
                UIImage * image = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = image;
                });
            });
        }
    }
    if(primaryView){
        [self.view addSubview:primaryView];
        primaryView.center = self.view.center;
    }

    self.forecover = [[UIView alloc] initWithFrame:screen.bounds];
    self.forecover.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.forecover];

    if (self.ad) {
        backcover.hidden = YES;
        self.forecover.userInteractionEnabled = NO;
    }

    UIImage *button_img = [UIImage imageNamed:@"Button_AD_Close.png"];
    
    CGRect screen_rect = [[UIScreen mainScreen] bounds];
    
    CGRect button_rect = CGRectMake(screen.bounds.size.width - 40, 20, 30, 30);
    
    if(screen_rect.size.width == 375 && screen_rect.size.height == 812){
        button_rect = CGRectMake(screen.bounds.size.width - 40, 44, 30, 30);
    }
    
    
    
    UIButton *close_button = [[UIButton alloc] initWithFrame:button_rect];
    [close_button setImage:button_img forState:UIControlStateNormal];
    [close_button addTarget:self action:@selector(nativeAdClosed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:close_button];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.view.center = window.center;
    self.modalPresentationStyle = UIModalPresentationCustom;
    [window.rootViewController presentViewController:self animated:NO completion:^(){

    }];
}

- (void) nativeAdClosed{
    NSLog(@"APAdNative: Ad closing");
    self.ad = nil;
    [self dismissViewControllerAnimated:NO completion:^(){
        NSLog(@"APAdNative: Ad closed");
    }];
}

@end
