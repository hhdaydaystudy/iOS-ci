//
//  ViewController.h
//  AppicSDKSample
//
//  Created by Jason Y Liu on 15/11/2017.
//  Copyright © 2017 AppicPlay. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate, APAdSplashDelegate>

@property (nonatomic, strong) NSDictionary *slot_dic;
@property (nonatomic, strong) IBOutlet UITableView *table_view;

@end

