//
//  SinaWeiboActivityHandler.h
//  BPActivityCollection
//
//  Created by Haozhen Li on 15-3-2.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "UIActivityHandlerBase.h"

@interface SinaWeiboActivityHandler : NSObject<UIActivityHandlerBase>

- (BOOL)openURL:(NSURL *)url;

+ (id)defaultHandler;
@end
