//
//  SinaWeiboBaseActivity.m
//  BPActivityCollection
//
//  Created by LiHaozhen on 15/4/9.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "SinaWeiboBaseActivity.h"
#import "WeiboSDK.h"
#import "WBAuthorizeResponse+NSUserDefaults.h"
#import "WBHttpRequest+WeiboShare.h"
#import "BPToast.h"

@implementation SinaWeiboBaseActivity


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return NSStringFromClass(self.class);
}

- (NSString *)activityTitle
{
    return @"新浪微博";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"more_weibo"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[UIImage class]]) {
            return YES;
        }
        if ([activityItem isKindOfClass:[NSURL class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    [activityItems enumerateObjectsUsingBlock:^(id activityItem, NSUInteger idx, BOOL *stop) {
        if ([activityItem isKindOfClass:[UIImage class]]) {
            image = activityItem;
        }
        if ([activityItem isKindOfClass:[NSURL class]]) {
            url = activityItem;
        }
        if ([activityItem isKindOfClass:[NSString class]]) {
            title = activityItem;
        }
        
        self.text = title;
        if (url) {
            self.text = [self.text stringByAppendingFormat:@"%@", url.absoluteString];
        }
        
        if (image) {
            self.imageObject = [WBImageObject object];
            self.imageObject.imageData = UIImageJPEGRepresentation(image, 0.75);
        }
    }];
}
@end
