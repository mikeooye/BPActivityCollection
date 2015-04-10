//
//  TencentOAuth+NSUserDefaults.h
//  BPActivityCollection
//
//  Created by LiHaozhen on 15/4/10.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import <TencentOpenAPI/TencentOAuth.h>

@interface TencentOAuth (NSUserDefaults)

- (void)save;
+ (instancetype)objectFromUserDefaults;
@end
