//
//  SinaWeiboActivity.m
//  WeixinActivity
//
//  Created by Haozhen Li on 15-2-25.
//  Copyright (c) 2015年 Johnny iDay. All rights reserved.
//

#import "SinaWeiboActivity.h"
#import "WeiboSDK.h"

@implementation SinaWeiboActivity

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
    }];
}

- (void)performActivity
{
    /*
    WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest request];
    req.message = [WBMessageObject message];
    req.message.text = title;
    
    if (url) {
        req.message.text = [req.message.text stringByAppendingFormat:@"%@", url.absoluteString];
    }
    
    if (image) {
        req.message.imageObject = [WBImageObject object];
        req.message.imageObject.imageData = UIImageJPEGRepresentation(image, 0.75);
    }
    [WeiboSDK sendRequest:req];
     */
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"https://api.weibo.com/oauth2/default.html";
    authRequest.scope = @"all";
    [WeiboSDK sendRequest:authRequest];
    [self activityDidFinish:YES];
}
@end
