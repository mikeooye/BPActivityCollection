//
//  SinaWeiboHttpActivity.m
//  BPActivityCollection
//
//  Created by LiHaozhen on 15/4/9.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "SinaWeiboHttpActivity.h"
#import "WBAuthorizeResponse+NSUserDefaults.h"
#import "BPToast.h"

@implementation SinaWeiboHttpActivity

- (void)performActivity
{
    WBAuthorizeResponse *auth = [WBAuthorizeResponse objectFromUserDefaults];
    if (auth.accessToken) {
        
        [WBHttpRequest requestForShareAStatus:self.text
                            contatinsAPicture:self.imageObject
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
