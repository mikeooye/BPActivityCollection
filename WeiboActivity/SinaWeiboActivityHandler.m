//
//  SinaWeiboActivityHandler.m
//  BPActivityCollection
//
//  Created by Haozhen Li on 15-3-2.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "SinaWeiboActivityHandler.h"
#import "WeiboSDK.h"

@interface SinaWeiboActivityHandler ()<WeiboSDKDelegate>

@end

@implementation SinaWeiboActivityHandler

+ (id)defaultHandler
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SinaWeiboActivityHandler alloc] init];
    });
    
    return _sharedInstance;
}

- (BOOL)openURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark - delegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBSendMessageToWeiboResponse *)response
{
    NSString *errDesc = [self errorDescWithCode:response.statusCode];
    if (errDesc) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"微博"]
                                                            message:[NSString stringWithFormat:@"[%ld]%@", response.statusCode, errDesc]
                                                           delegate:nil
                                                  cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alertView show];
    }
}

- (NSString *)errorDescWithCode:(WeiboSDKResponseStatusCode)code
{
    switch (code) {
        case WeiboSDKResponseStatusCodeSentFail:
            return @"发送失败";
        case WeiboSDKResponseStatusCodeUserCancel:
            return @"已取消";
            
        default:
            break;
    }
    return nil;
}
@end
