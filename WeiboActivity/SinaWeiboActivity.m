//
//  SinaWeiboActivity.m
//  WeixinActivity
//
//  Created by Haozhen Li on 15-2-25.
//  Copyright (c) 2015年 Johnny iDay. All rights reserved.
//

#import "SinaWeiboActivity.h"
#import "WeiboSDK.h"
#import "WBAuthorizeResponse+NSUserDefaults.h"
#import "WBHttpRequest+WeiboShare.h"
#import "BPToast.h"

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
    NSString *text = nil;
    WBImageObject *imgObj = nil;

    text = title;
    if (url) {
        text = [text stringByAppendingFormat:@"%@", url.absoluteString];
    }
    
    if (image) {
        imgObj = [WBImageObject object];
        imgObj.imageData = UIImageJPEGRepresentation(image, 0.75);
    }
/*
    WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest request];
    req.message = [WBMessageObject message];
    req.message.text = text;
    req.message.imageObject = imgObj;
    [WeiboSDK sendRequest:req];
*/
    
    WBAuthorizeResponse *auth = [WBAuthorizeResponse objectFromUserDefaults];
    if (auth.accessToken && [auth.expirationDate compare:[NSDate date]] == NSOrderedDescending) {

        [WBHttpRequest requestForShareAStatus:text
                                                 contatinsAPicture:imgObj
                                                      orPictureUrl:nil
                                                   withAccessToken:auth.accessToken
                                                andOtherProperties:nil
                                                             queue:[NSOperationQueue mainQueue]
                                             withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
                                                 
                                                 if (error == NO) {
                                                     [@"Share Successed" toast];
                                                 }else{
                                                     
                                                     [error.localizedDescription toast];
                                                 }
                                             }];
        [self activityDidFinish:YES];
    }else{
        
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = @"https://api.weibo.com/oauth2/default.html";
        authRequest.scope = @"all";
        [WeiboSDK sendRequest:authRequest];
        [self activityDidFinish:YES];
    }
}

@end
