//
//  TencentOAuth+NSUserDefaults.m
//  BPActivityCollection
//
//  Created by LiHaozhen on 15/4/10.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "TencentOAuth+NSUserDefaults.h"

#define kQQAuthAccessToken @"qq.auth.accesstoken"

@implementation TencentOAuth (NSUserDefaults)

- (void)saveValue:(id)value forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (value == nil) {
        [userDefaults removeObjectForKey:key];
    }else{
        [userDefaults setObject:value forKey:key];
    }
}

- (void)save
{
    [self saveValue:self.accessToken forKey:kQQAuthAccessToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (instancetype)objectFromUserDefaults
{
    TencentOAuth *oauth = [[TencentOAuth alloc] init];
    oauth.accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:kQQAuthAccessToken];
    return oauth;
}
@end
