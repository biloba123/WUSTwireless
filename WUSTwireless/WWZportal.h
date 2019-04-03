//
//  WWZportal.h
//  WUSTwireless
//
//  Created by 吕晴阳 on 2019/3/18.
//  Copyright © 2019 吕晴阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginCallback) (BOOL success, NSString *errorMsg);

@interface WWZportal : NSObject

- (void)loginWithUsername:(NSString *)username password:(NSString *)pwd callback:(nullable LoginCallback) callback;

@end

NS_ASSUME_NONNULL_END
