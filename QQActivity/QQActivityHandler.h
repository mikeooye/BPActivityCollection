//
//  QQActivityHandler.h
//  BPActivityCollection
//
//  Created by LiHaozhen on 15/4/10.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIActivityHandlerBase.h"

@interface QQActivityHandler : NSObject<UIActivityHandlerBase>

- (BOOL)openURL:(NSURL *)url;
+ (id)defaultHandler;

- (void)registerApp;
- (void)auth;
@end
