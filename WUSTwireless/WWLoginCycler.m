//
//  WWLoginCycler.m
//  WUSTwireless
//
//  Created by 吕晴阳 on 2019/3/18.
//  Copyright © 2019 吕晴阳. All rights reserved.
//

#import "WWLoginCycler.h"
#import "WWZportal.h"
#import "WWNetUtil.h"

@interface WWLoginCycler()
@property (nonatomic, copy) NSDictionary *username2PwdMap;
@property (nonatomic, strong) NSMutableArray *usernameArr;
@property (nonatomic, copy) NSString *curUsername;
@property (nonatomic, strong) WWZportal *zpertal;
@end

@implementation WWLoginCycler

 - (instancetype)initWithUsername2PwdMap:(NSDictionary *)map {
     if (self = [super init]) {
         self.username2PwdMap = map;
         self.usernameArr = [map.allKeys mutableCopy];
         self.zpertal = [[WWZportal alloc] init];
     }
     
     return self;
}

- (void)run {
    if (self.usernameArr.count == 0) {
        return;
    }
    
    NSString *username = self.usernameArr[0];
    NSLog(@"尝试登陆: %@", username);
    [self.zpertal loginWithUsername:username password:self.username2PwdMap[username] callback:^(BOOL success, NSString * _Nonnull errorMsg) {
        if (success) {
            NSLog(@"成功！");
            while ([WWNetUtil checkNetworkCanUse]) {
                NSLog(@"网络可用...");
                sleep(30);
            }
        } else {
            NSLog(@"失败");
            [self.usernameArr removeObjectAtIndex:0];
        }
        
        [self run];
    }];
}

@end
