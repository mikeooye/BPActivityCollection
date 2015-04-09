//
//  WBAuthorizeResponse+NSUserDefaults.h
//  BPActivityCollection
//
//  Created by LiHaozhen on 15/4/9.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "WeiboSDK.h"

@interface WBAuthorizeResponse (NSUserDefaults)

- (void)saveToUserDefaults;

+ (instancetype)objectFromUserDefaults;
@end
