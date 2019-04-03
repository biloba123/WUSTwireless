//
//  main.m
//  WUSTwireless
//
//  Created by 吕晴阳 on 2019/3/18.
//  Copyright © 2019 吕晴阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWLoginCycler.h"


NSMutableDictionary *getUsername2PwdMap() {
    return [@{
              
              } mutableCopy];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [[[WWLoginCycler alloc] initWithUsername2PwdMap:getUsername2PwdMap()] run];
        
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}
