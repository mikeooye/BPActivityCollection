//
//  WBAuthorizeResponse+NSUserDefaults.m
//  BPActivityCollection
//
//  Created by LiHaozhen on 15/4/9.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "WBAuthorizeResponse+NSUserDefaults.h"

#define kWbAuthUserId @"wb.auth.userid"
#define kWbAuthAccessToken @"wb.auth.accesstoken"
#define kWbAuthRefreshToken @"wb.auth.refreshtoken"
#define kWbAuthExpirationDate @"wb.auth.expirationdate"

@implementation WBAuthorizeResponse (NSUserDefaults)


- (void)saveToUserDefaults
{
    [self saveValue:self.userID forKey:kWbAuthUserId];
    [self saveValue:self.accessToken forKey:kWbAuthAccessToken];
    [self saveValue:self.refreshToken forKey:kWbAuthRefreshToken];
    [self saveValue:self.expirationDate forKey:kWbAuthExpirationDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (instancetype)objectFromUserDefaults
{
    WBAuthorizeResponse *resp = [WBAuthorizeResponse response];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    resp.userID = [userDefaults stringForKey:kWbAuthUserId];
    resp.accessToken = [userDefaults stringForKey:kWbAuthAccessToken];
    resp.refreshToken = [userDefaults stringForKey:kWbAuthRefreshToken];
    resp.expirationDate = [userDefaults objectForKey:kWbAuthExpirationDate];
    return resp;
}

- (void)saveValue:(id)value forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (value == nil) {
        [userDefaults removeObjectForKey:key];
    }else{
        [userDefaults setObject:value forKey:key];
    }
}

@end
