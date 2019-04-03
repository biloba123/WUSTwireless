//
//  WWLoginCycler.h
//  WUSTwireless
//
//  Created by 吕晴阳 on 2019/3/18.
//  Copyright © 2019 吕晴阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WWLoginCycler : NSObject

- (instancetype)initWithUsername2PwdMap:(NSDictionary *)map;

- (void)run;

@end

NS_ASSUME_NONNULL_END
