//
//  QQActivityHandler.m
//  BPActivityCollection
//
//  Created by LiHaozhen on 15/4/10.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "QQActivityHandler.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "QQActivity.h"
#import "BPToast.h"
#import "TencentOAuth+NSUserDefaults.h"

@interface QQActivityHandler ()<TencentSessionDelegate>

@end

@implementation QQActivityHandler{
    
    TencentOAuth *_oauth;
}

+ (id)defaultHandler
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[QQActivityHandler alloc] init];
    });
    
    return _sharedInstance;
}

- (BOOL)openURL:(NSURL *)url
{
    return [TencentOAuth HandleOpenURL:url];
}

- (void)registerApp
{
    _oauth = [[TencentOAuth alloc] initWithAppId:kQQAppId andDelegate:self];
}

- (void)auth
{
    [_oauth authorize:@[kOPEN_PERMISSION_ADD_SHARE]];
}

#pragma mark - Session delegate
- (void)tencentDidLogin
{
    if (_oauth.accessToken && _oauth.accessToken.length != 0) {
        [_oauth save];
        [@"登录成功" toast];
    }else{
        [@"登录不成功，没有获取accessToken" toast];
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled) {
        [@"用户取消登录" toast];
    }else{
        [@"登录失败" toast];
    }
}

- (void)tencentDidNotNetWork
{
    [@"无网络连接，请设置网络" toast];
}
@end
