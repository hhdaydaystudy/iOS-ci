//
//  ViewController.m
//  AppicSDKSample
//
//  Created by Jason Y Liu on 15/11/2017.
//  Copyright © 2017 AppicPlay. All rights reserved.
//

#import "ViewController.h"
#import "NativeAdController.h"
#import "AdCell.h"
@interface ViewController ()
{
    UILabel * debugLabel;
}
@property (nonatomic, strong) APAdSplash *splash;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //这里配置广告参数
    self.slot_dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                     @"RewardVideo",
//                     @"nmMWxXGQ",
//                     @"Interstitial",
//                     @"qGJeqZyw",
//                     @"Native",
//                     @"eAzONxmx",
                     @"Splash",
                     @"YGLnqnmx",
//                     @"Banner",
//                     @"dADjXaye",
                     nil];
    
    self.splash = [[APAdSplash alloc] initWithSlot:@"BGxgeNyK" andDelegate:self];
    [self.splash loadAndPresentWithViewController:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (BOOL) prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.slot_dic count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"AP_ad_test_cell";
    AdCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSString *slot = [[self.slot_dic allKeys] objectAtIndex:indexPath.row];
    NSString *name = [[self.slot_dic allValues] objectAtIndex:indexPath.row];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AdCellView" owner:nil options:nil] objectAtIndex:0];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
    }
    [cell setupWithSlot:slot andName:name andViewController:self];
    return cell;
}

- (void) apAdSplashDidLoadSuccess:(nonnull APAdSplash *)ad
{
    NSLog(@"Splash Ad Load Success");
}

- (void) apAdSplashDidLoadFail:(nonnull APAdSplash *)ad withError:(nonnull NSError *)err
{
    NSLog(@"Splash Ad failed to receive, error = %@", err);
    self.splash = nil;
}

- (void) apAdSplashDidPresentSuccess:(nonnull APAdSplash *)ad
{
    NSLog(@"Splash Ad present success");
}

- (void) apAdSplashDidPresentFail:(nonnull APAdSplash *)ad withError:(nonnull NSError *)err
{
    self.splash = nil;
    NSLog(@"Splash Ad present fail, error = %@", err);
}

- (void) apAdSplashDidClick:(nonnull APAdSplash *)ad
{
    NSLog(@"Splash Ad clicked");
}

- (void) apAdSplashDidDismiss:(nonnull APAdSplash *)ad
{
    NSLog(@"Splash Ad dismissed");
    self.splash = nil;
}


@end
