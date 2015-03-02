//
//  WeixinActivityHandler.m
//  BPActivityCollection
//
//  Created by Haozhen Li on 15-3-2.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "WeixinActivityHandler.h"
#import "WXApi.h"

@interface WeixinActivityHandler ()<WXApiDelegate>

@end

@implementation WeixinActivityHandler

+ (id)defaultHandler
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[WeixinActivityHandler alloc] init];
    });
    
    return _sharedInstance;
}

- (BOOL)openURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - delegate
- (void)onReq:(BaseReq *)req
{
    
}

- (void)onResp:(SendMessageToWXResp *)resp
{
    NSString *errDesc = [self errorDescWithCode:resp.errCode];
    if (errDesc) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"微信"]
                                                            message:[NSString stringWithFormat:@"[%d]%@", resp.errCode, errDesc]
                                                           delegate:nil
                                                  cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alertView show];
    }
}

- (NSString *)errorDescWithCode:(enum WXErrCode)code
{
    switch (code) {
        case WXErrCodeUserCancel:
            return @"已取消";
        case WXErrCodeSentFail:
            return @"发送失败";
        default:
            break;
    }
    return nil;
}
@end
