//
//  QQActivity.m
//  BPActivityCollection
//
//  Created by LiHaozhen on 15/4/10.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "QQActivity.h"
#import "QQActivityHandler.h"

@implementation QQActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return NSStringFromClass([self class]);
}

- (NSString *)activityTitle
{
    return @"QQ登录";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[UIImage class]]) {
            image = activityItem;
        }
        if ([activityItem isKindOfClass:[NSURL class]]) {
            url = activityItem;
        }
        if ([activityItem isKindOfClass:[NSString class]]) {
            title = activityItem;
        }
    }
}

- (void)performActivity
{
    [[QQActivityHandler defaultHandler] auth];
    [self activityDidFinish:YES];
}
@end
