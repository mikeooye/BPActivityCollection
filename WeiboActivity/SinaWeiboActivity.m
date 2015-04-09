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



- (void)performActivity
{
    WBMessageObject *msg = [WBMessageObject message];
    msg.text = self.text;
    msg.imageObject = self.imageObject;
    WBAuthorizeRequest *authReq = [WBAuthorizeRequest request];
    WBAuthorizeResponse *authResp = [WBAuthorizeResponse objectFromUserDefaults];
    WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest requestWithMessage:msg
                                                                              authInfo:authReq
                                                                          access_token:authResp.accessToken];
    [WeiboSDK sendRequest:req];
    [self activityDidFinish:YES];
}

@end
