//
//  HBUserDefaults.m
//  HuiBeauty
//
//  Created by darren on 14-9-10.
//  Copyright (c) 2014年 BrooksWon. All rights reserved.
//

#import "HBUserDefaults.h"

@implementation HBUserDefaults


@dynamic isLogin;
@dynamic isFirstLaunch;
@dynamic province;
@dynamic city;
@dynamic userPhoneNum;
@dynamic realName;
@dynamic token;
@dynamic address;
@dynamic provinceId;
@dynamic cityId;
- (id)init
{
    if (self = [super init]) {
        NSDictionary *registrationDictionary = @{
                                                 @"userPhoneNum":@"",
                                                 @"realName":@"",
                                                 @"isLogin":@0,
                                                 @"isFirstLaunch":@1,
                                                 @"province":@"",
                                                 @"provinceId":@"",
                                                 @"cityId":@"",
                                                 @"token":@"",
                                                 @"city":@"",
                                                 @"address":@""
                                                 };
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:registrationDictionary];
    }
    
    return self;
}

@end
