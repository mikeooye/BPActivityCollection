//
//  SinaWeiboBaseActivity.h
//  BPActivityCollection
//
//  Created by LiHaozhen on 15/4/9.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"

#define kWBAppKey @"3951331094"
#define kWBAppSecret @"ba833b7da2d9ca1a5593734c2302af9d"
#define kWBRedirectURI @"https://api.weibo.com/oauth2/default.html"

@interface SinaWeiboBaseActivity : UIActivity{
    
    NSString *title;
    UIImage *image;
    NSURL *url;
}

@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) WBImageObject *imageObject;
@end
