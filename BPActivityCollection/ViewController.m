//
//  ViewController.m
//  BPActivityCollection
//
//  Created by Haozhen Li on 15-2-25.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "ViewController.h"
#import "WeixinActivity.h"
#import "SinaWeiboHttpActivity.h"
#import "SinaWeiboActivity.h"

@interface ViewController () {
    NSArray *activity;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    activity = @[[[WeixinSessionActivity alloc] init],
                 [[WeixinTimelineActivity alloc] init],
                 [[SinaWeiboActivity alloc] init],
                 [[SinaWeiboHttpActivity alloc] init]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)share:(id)sender
{
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[@"这里是标题", [UIImage imageNamed:@"Oauth"], [NSURL URLWithString:@"http://www.google.com"]] applicationActivities:activity];
    
    activityView.excludedActivityTypes = @[UIActivityTypeAssignToContact,
                                           UIActivityTypeCopyToPasteboard,
                                           UIActivityTypePrint,
                                           UIActivityTypeSaveToCameraRoll,
                                           UIActivityTypeAddToReadingList,
                                           UIActivityTypePostToWeibo];
    
    [self presentViewController:activityView animated:YES completion:nil];
    
    UIPopoverPresentationController *popoverVC = [activityView popoverPresentationController];
    popoverVC.sourceView = sender;
}

@end
