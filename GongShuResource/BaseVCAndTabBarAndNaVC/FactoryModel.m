//
//  FactoryModel.m
//  YHB_Prj
//
//  Created by  striveliu on 14/12/3.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "FactoryModel.h"
#import "MyInfoViewController.h"
#import "MessageViewController.h"
#import "MerchandiseControlViewController.h"
#import "OrderFormViewController.h"
@implementation FactoryModel
+ (FactoryModel *)shareFactoryModel
{
    static FactoryModel *factoryModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(factoryModel == nil)
        {
            factoryModel = [[FactoryModel alloc] init];
        }
    });
    return factoryModel;
}

- (NSArray *)getTabbarArrys
{
    UIViewController *vc1 = [self getFirstViewController];
    UIViewController *vc2 = [self getSecondViewController];
//    UIViewController *vc3 = [self getThirdViewController];
    UIViewController *vc4 = [self getFourthViewController];
     NSArray *arry = @[vc1,vc2,vc4];
    return arry;
}

- (UIViewController *)getFirstViewController{
    OrderFormViewController *firstVC = [[OrderFormViewController alloc]init];
    return firstVC;
}
- (UIViewController *)getSecondViewController
{
    MerchandiseControlViewController *secondVC = [[MerchandiseControlViewController alloc]init];
    return secondVC;
}
- (UIViewController *)getThirdViewController
{
    
    MessageViewController *thirdVC = [[MessageViewController alloc]init];
    return thirdVC;
    
}

- (UIViewController *)getFourthViewController
{
    MyInfoViewController *fourthVC = [[MyInfoViewController alloc] init];
    return fourthVC;
}


@end
