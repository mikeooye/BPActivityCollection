//
//  SinaWeiboActivity.h
//  WeixinActivity
//
//  Created by Haozhen Li on 15-2-25.
//  Copyright (c) 2015年 Johnny iDay. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kWBAppKey @"3951331094"
#define kWBAppSecret @"ba833b7da2d9ca1a5593734c2302af9d"
#define kWBRedirectURI @"https://api.weibo.com/oauth2/default.html"

@interface SinaWeiboActivity : UIActivity{
    
    NSString *title;
    UIImage *image;
    NSURL *url;
}

@end
