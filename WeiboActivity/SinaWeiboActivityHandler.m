//
//  SinaWeiboActivityHandler.m
//  BPActivityCollection
//
//  Created by Haozhen Li on 15-3-2.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "SinaWeiboActivityHandler.h"
#import "WeiboSDK.h"
#import "WBAuthorizeResponse+NSUserDefaults.h"
#import "BPToast.h"

@interface SinaWeiboActivityHandler ()<WeiboSDKDelegate>

@end

@implementation SinaWeiboActivityHandler{

    NSDateFormatter *_dateFormatter;
}

+ (id)defaultHandler
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SinaWeiboActivityHandler alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateStyle = NSDateFormatterFullStyle;
        _dateFormatter.timeStyle = NSDateFormatterFullStyle;
    }
    return self;
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
        return;
    }
    
    WeiboSDKResponseStatusCode code = response.statusCode;
    if (code == WeiboSDKResponseStatusCodeSuccess) {
        
        WBAuthorizeResponse *authResp = nil;
        if ([response isMemberOfClass:[WBAuthorizeResponse class]]) {
            authResp = (WBAuthorizeResponse *)response;
        }else if (response.authResponse){
            authResp = response.authResponse;
        }
        
        if (authResp) {
            
            [authResp saveToUserDefaults];
            [@"Auth Successed" toast];
        }
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
