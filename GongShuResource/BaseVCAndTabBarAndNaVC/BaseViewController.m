//
//  BaseViewController.m
//  daShu
//
//  Created by 史岁富 on 15/11/3.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "BaseViewController.h"
#import "LSNavigationController.h"

@interface BaseViewController ()<UIAlertViewDelegate>
{
    UILabel *titleLabel;
}
@end

@implementation BaseViewController
- (void)ExclusiveTouch:(UIView *)allView{
    for (UIView *item in allView.subviews)
    {
        if ([item isKindOfClass:[UIButton class]]) {
            [(UIButton *)item setExclusiveTouch:YES];
            
        }
        
        if( item.subviews.count >0)
        {
            [self ExclusiveTouch:item];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self ExclusiveTouch:self.view];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    if (IS_IOS7) {
//        self.extendedLayoutIncludesOpaqueBars = YES;
//        self.automaticallyAdjustsScrollViewInsets = YES;
//    }
    //    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#48B79D"];
    if(IS_IOS7)
    {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#202327"];
    }
    else
    {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"#202327"];
    }
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle=  UIBarStyleBlack;
    self.navigationController.navigationBar.alpha = 1;
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    if (self != [self.navigationController.viewControllers objectAtIndex:0])
    {
        [self setLeftButton:[UIImage imageNamed:@"back"] width:18/2 height:30/2 title:@"" target:self action:@selector(back)];
    }
    [self resetViewFrame];

    // Do any additional setup after loading the view.
}
- (void)resetViewFrame{
    if(self.navigationController)
    {
        if(self.navigationController.navigationBarHidden == YES)
        {
            if(IS_IOS7)
            {
                self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
            }
            else
            {
                self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20);
            }
        }
        else
        {
            if(IS_IOS7)
            {
                self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-self.navigationController.navigationBar.frame.size.height-20);
            }
            else
            {
                self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-self.navigationController.navigationBar.frame.size.height-20);
            }
        }
    }
    else
    {
        if(IS_IOS7)
        {
            self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
        }
        else
        {
            self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20);
        }
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loginUmengPage];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self logoutUmengPage];
}
-(void)loginUmengPage
{
    NSString *pageStr = [NSString stringWithFormat:@"%@-%@",NSStringFromClass([self class]),titleLabel.text];
    [MobClick beginLogPageView:pageStr];
}

-(void)logoutUmengPage
{
    NSString *pageStr = [NSString stringWithFormat:@"%@-%@",NSStringFromClass([self class]),titleLabel.text];
    [MobClick endLogPageView:pageStr];
}
- (void)back
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setLeftButton:(UIImage *)aImg width:(CGFloat)aWidth height:(CGFloat)aHeight title:(NSString *)aTitle target:(id)aTarget action:(SEL)aSelector
{
    CGRect buttonFrame;
    if (IS_IOS7) {
        buttonFrame = CGRectMake(0, 0, 60.0, 44.0);
    }else{
        buttonFrame = CGRectMake(0, 0, 60.0, 44.0);
    }
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    if(aImg)
    {
        UIImageView *btnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, (44.0 - aHeight)/2, aWidth, aHeight)];
        btnImageView.image = aImg;
        [button addSubview:btnImageView];
        //[button setImage:aImg forState:UIControlStateNormal];
    }
    if(aTitle)
    {
        [button setTitle:aTitle forState:UIControlStateNormal];
    }
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
    CGRect viewFrame = CGRectMake(0, 0, 60.0, 44.0);
    UIView *view = [[UIView alloc]initWithFrame:viewFrame];
    button.titleEdgeInsets = UIEdgeInsetsMake(button.titleEdgeInsets.top, button.titleEdgeInsets.left+5, button.titleEdgeInsets.bottom, button.titleEdgeInsets.right-5);
    //view.backgroundColor = [UIColor blueColor];
    [view addSubview:button];
    
    if(self.navigationController && self.navigationItem)
    {
        UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        // 调整 leftBarButtonItem 在 iOS7 下面的位置
        if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
            self.navigationItem.leftBarButtonItem = backNavigationItem;
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = -15;
            self.navigationItem.leftBarButtonItems = @[negativeSpacer, backNavigationItem];
        }else{
            self.navigationItem.leftBarButtonItem = backNavigationItem;
        }
        
        
    }
}
- (void)setTitleViewWithTitle:(NSString *)title{
    if (!NOTNULL(title)) {
        return;
    }
    
    if(!titleLabel)
    {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, kMainScreenWidth, 150, self.navigationController.navigationBar.frame.size.height)];
        self.navigationItem.titleView = titleLabel;
    }
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.center = self.navigationController.navigationBar.center;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
}
- (void)setRightButton:(UIImage *)aImg width:(CGFloat)aWidth height:(CGFloat)aHeight title:(NSString *)aTitle target:(id)aTarget action:(SEL)aSelector
{
    CGRect buttonFrame;
    if (IS_IOS7) {
        buttonFrame = CGRectMake(0, 0, 60, 44.0);
    }else{
        buttonFrame = CGRectMake(-5, 0, 60, 44.0);
    }
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    if(aTitle)
    {
        [button setTitle:aTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    if(aImg)
    {
        UIImageView *btnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60 - aWidth - 15, (44.0 - aHeight)/2, aWidth, aHeight)];
        btnImageView.image = aImg;
        [button addSubview:btnImageView];
        //[button setImage:aImg forState:UIControlStateNormal];
        // [button setBackgroundImage:aImg forState:UIControlStateNormal];
    }
    CGRect viewFrame = CGRectMake(0, 0, 60, 44.0);
    UIView *view = [[UIView alloc]initWithFrame:viewFrame];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:button];
    if(self.navigationController && self.navigationItem)
    {
        UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        // 调整 leftBarButtonItem 在 iOS7 下面的位置
        if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
            self.navigationItem.rightBarButtonItem = backNavigationItem;
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = -16;
            self.navigationItem.rightBarButtonItems = @[negativeSpacer, backNavigationItem];
        }else{
            self.navigationItem.rightBarButtonItem = backNavigationItem;
        }
        
        
    }
    //    if(self.navigationController && self.navigationItem)
    //    {
    //        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    //    }
}
- (void)showHUDInView{
    HUD  = [GlobalUtil showMBProgressHudOnView:self.view withTitle:@"请稍候..."];
}
- (void)hidHUDView{
    [HUD hide:NO];
}

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(id responseObject,id data,int flag,NSString *msg))success failure:(void (^)())failure{
    [self showHUDInView];
    [[AFAppDotNetAPIClient sharedClient] postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hidHUDView];
        NSDictionary *dic = [GlobalUtil analyzeRequestDataOfJSON:responseObject];
        int flag = [dic[@"flag"] intValue];
        id data = dic[@"data"];
        NSString *msg = dic[@"msg"];
        NSLog(@"responseData: %@\nmsg: %@",dic,msg);
        if (flag == -1) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录超时" message:@"请重新登录！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            alert.tag = 10001;
            [alert show];
            return ;
        }
        if (flag != 1) {
            [GlobalUtil showMBProgressHudOnView:self.view withTitle:msg];
        }
        success(dic,data,flag,msg);

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"网络异常";
        [HUD hide:YES afterDelay:1];
        failure();
    }];
}

- (void)getPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(id responseObject,id data,int flag,NSString *msg))success failure:(void (^)())failure {
    [self showHUDInView];
    [[AFAppDotNetAPIClient sharedClient] getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hidHUDView];
        NSDictionary *dic = [GlobalUtil analyzeRequestDataOfJSON:responseObject];
        int flag = [dic[@"flag"] intValue];
        id data = dic[@"data"];
        NSString *msg = dic[@"msg"];
        NSLog(@"responseData: %@\nmsg: %@",dic,msg);
        if (flag == -1) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录超时" message:@"请重新登录！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            alert.tag = 10001;
            [alert show];
            return ;
        }
        if (flag != 1) {
            [GlobalUtil showMBProgressHudOnView:self.view withTitle:msg];
        }
        success(dic,data,flag,msg);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"网络异常";
        [HUD hide:YES afterDelay:2];
        failure();
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10001) {
        [HBUserDefaults sharedInstance].isLogin = NO;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
