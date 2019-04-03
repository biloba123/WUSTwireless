//
//  WWZportal.m
//  WUSTwireless
//
//  Created by 吕晴阳 on 2019/3/18.
//  Copyright © 2019 吕晴阳. All rights reserved.
//

#import "WWZportal.h"

NSString * const kURLLogin = @"http://202.114.240.108:8080/zportal/login/do";
NSString * const kDefaultParam = @"qrCodeId=请输入编号&validCode=Valid+Code&validCodeFlag=false&ssid=b8a9c2a1989e15776af70dbf182bbbe6&mac=58f013ef6daf2038c9153849d6521d59&t=wireless-v2-plain&wlanacname=182b6ff913c0d9a508d195bca363a86f&url=fc7371bb488da3687ec054c18a33fe094e232f29bdb19346acdc6b9c5996206b&nasip=5340d13e4208e1b891476c890b7f5f5c&wlanuserip=752c79a9f5d713fce88d4de281e3676c";

@interface WWZportal()
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSURLRequest *request;
@end

@implementation WWZportal

- (instancetype)init {
    if (self = [super init]) {
        self.session = [NSURLSession sharedSession];
        
        NSURL *url = [NSURL URLWithString:kURLLogin];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        request.HTTPMethod = @"POST";
        self.request = request;
    }
    
    return self;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)pwd callback:(nullable LoginCallback)callback{
    NSMutableString *dataStr = [kDefaultParam mutableCopy];
    [dataStr appendFormat:@"&username=%@", username];
    [dataStr appendFormat:@"&pwd=%@", pwd];
    NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [[self.session uploadTaskWithRequest:self.request fromData:data
                  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                      BOOL success = NO;
                      NSString *errMsg;
                      
                      if(!error) {
                          NSError *err;
                          NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                          NSLog(@"%@", result[@"message"]);
                          
                          NSString *status = result[@"result"];
                          if ([status isEqualToString:@"success"] || [status isEqualToString:@"online"]) {
                              success = YES;
                          } else {
                              errMsg = result[@"message"];
                          }
                      } else {
                          errMsg = error.localizedDescription;
                      }
                      
                      !callback ?: callback(success, errMsg);
                  }] resume];
    
}

@end
