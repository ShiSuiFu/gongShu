//
//  LoginViewController.m
//  daShu
//
//  Created by 付朋华 on 15/11/6.
//  Copyright © 2015年 付朋华. All rights reserved.
//

#import "LoginViewController.h"
#import "LSNavigationController.h"
#import "MyTabBarViewController.h"

@interface LoginViewController ()
{
    NSTimer *timer;
    int seconds;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    seconds = 60;
    [self setTitleViewWithTitle:@"登录"];
    self.loginButton.layer.cornerRadius = 4;
    self.loginButton.layer.masksToBounds = YES;
    self.timerLbl.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.timerLbl.textColor = [UIColor colorWithHexString:@"#CCCCD2"];
    self.timerLbl.layer.cornerRadius = 3;
    self.timerLbl.layer.borderWidth = 0.7;
    self.timerLbl.layer.borderColor = [UIColor colorWithHexString:@"#CCCCD2"].CGColor;
    self.timerLbl.hidden = YES;
    [self setGetCodeButtonColor];
    [self setLoginButtonColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCodeButtonStatus:) name:UITextFieldTextDidChangeNotification object:nil];
//    RAC(self.loginButton,enabled) = [RACSignal combineLatest:@[self.phoneField.rac_textSignal,self.verificationCodeField.rac_textSignal] reduce:^id{
//        return @(self.phoneField.text.length==13&&self.verificationCodeField.text.length>0);
//    }];
//    self.phoneField.text = @"13816763914";
//    self.verificationCodeField.text = @"123456";
    // Do any additional setup after loading the view from its nib.
}

- (void)setGetCodeButtonColor{
    if (self.phoneField.text.length == 13) {
        self.getCodeButton.enabled = YES;
    }else{
        self.getCodeButton.enabled = NO;
    }
    if (self.getCodeButton.enabled) {
        self.getCodeButton.layer.borderColor = [UIColor colorWithHexString:@"#32B77D"].CGColor;
        self.getCodeButton.layer.borderWidth = 0.7;
        self.getCodeButton.layer.cornerRadius = 3;
        self.getCodeButton.layer.masksToBounds = YES;
        self.getCodeButton.backgroundColor = [UIColor colorWithHexString:@"DDF4EA"];
        [self.getCodeButton setTitleColor:[UIColor colorWithHexString:@"#32B77D"] forState:UIControlStateNormal];
    }else{
        self.getCodeButton.layer.borderColor = [UIColor colorWithHexString:@"#CCCCD2"].CGColor;
        self.getCodeButton.layer.borderWidth = 0.7;
        self.getCodeButton.layer.cornerRadius = 3;
        self.getCodeButton.layer.masksToBounds = YES;
        self.getCodeButton.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [self.getCodeButton setTitleColor:[UIColor colorWithHexString:@"#CCCCD2"] forState:UIControlStateNormal];

    }
}
- (void)setLoginButtonColor{
    if (self.verificationCodeField.text.length > 0) {
        self.loginButton.userInteractionEnabled = YES;
    }else{
        self.loginButton.userInteractionEnabled = NO;
    }
    if (self.loginButton.userInteractionEnabled) {
        [self.loginButton setBackgroundColor:[UIColor colorWithHexString:@"#26AD68"]];
    }else{
        [self.loginButton setBackgroundColor:[UIColor colorWithHexString:@"#95D8BB"]];
    }
}
- (void)changeCodeButtonStatus:(NSNotification *)notification{
    if ([self.phoneField.text trim1].length == 11) {
        self.getCodeButton.enabled = YES;
        if (self.verificationCodeField.text.length>0) {
            self.loginButton.userInteractionEnabled = YES;
        }
    }
    [self setLoginButtonColor];
    [self setGetCodeButtonColor];
    
    
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

- (IBAction)getCodeClick:(id)sender {
    [self.view endEditing:YES];
    if (![GlobalUtil validateMobileNumber:[self.phoneField.text trim1]]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入有效的手机号" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        alert.tag = 100;
        [alert show];
        return;
    }
    [self startCountdown];
}
- (void)startCountdown{
    self.timerLbl.hidden = NO;
    self.timerLbl.backgroundColor = [UIColor whiteColor];
    self.timerLbl.text = @"重试(60秒)";
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getCodetime:) userInfo:nil repeats:YES];
}
- (void)getCodetime:(id)sender
{
    seconds--;
    self.timerLbl.text = [NSString stringWithFormat:@"重试(%d秒)",seconds];
    if (seconds==0)
    {
        self.getCodeButton.userInteractionEnabled = YES;
        [timer invalidate];
        seconds = 60;
        timer = nil;
        self.timerLbl.backgroundColor = [UIColor clearColor];
        self.timerLbl.hidden = YES;
        self.timerLbl.text = nil;
        
    }
}
- (IBAction)loginClick:(id)sender {
    [self.view endEditing:YES];
    if (![GlobalUtil validateMobileNumber:[self.phoneField.text trim1]]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入有效的手机号" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        alert.tag = 100;
        [alert show];
        return;
    }
    if (self.verificationCodeField.text.length <1) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入手机验证码" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        alert.tag = 101;
        [alert show];
        return;
    }
    [self LoginRequest];

}
- (void)LoginRequest{
    NSString *phone = [self.phoneField.text trim1];
    NSString *password = [self.verificationCodeField.text md5];//[self.verificationCodeField.text md5];
    NSDictionary *parameter = @{@"mobileNumber":phone,
                                @"password":password
                                };
    [self postPath:LOGIN_URL parameters:parameter success:^(id responseObject, id data, int flag, NSString *msg) {
        if (flag == 1) {
            [HBUserDefaults sharedInstance].userPhoneNum = data[@"mobileNumber"];
            [HBUserDefaults sharedInstance].realName = data[@"realName"];
            [HBUserDefaults sharedInstance].token = data[@"token"];
            [self goToTaskList];
        }
    } failure:^{
        
    }];
}
- (void)goToTaskList{
    [HBUserDefaults sharedInstance].isLogin = YES;
    MyTabBarViewController *taskListVC = [[MyTabBarViewController alloc]init];
    LSNavigationController *lsNVC = [[LSNavigationController alloc]initWithRootViewController:taskListVC];

    self.view.window.rootViewController = lsNVC;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.phoneField) {
        NSString * toBeString = [self.phoneField.text stringByReplacingCharactersInRange:range withString:string];
        if ([string isEqualToString:@""]) { // 删除字符
            if (textField.text.length  == 4 && textField.text.length < 14) {
                textField.text = [textField.text substringToIndex:textField.text.length - 1];
            }
            if (textField.text.length  == 9 && textField.text.length < 14) {
                textField.text = [textField.text substringToIndex:textField.text.length - 1];
            }
            [self setGetCodeButtonColor];
            return YES;
        }
        if ([string isPureInt]) {
            if (textField.text.length  == 3 && textField.text.length < 14) {
                textField.text = [NSString stringWithFormat:@"%@-", textField.text];
            }
            if (textField.text.length  == 8 && textField.text.length < 14) {
                textField.text = [NSString stringWithFormat:@"%@-", textField.text];
            }
        }
        
        if([toBeString length] < 14)
        {
            return YES;
        }
        [self setGetCodeButtonColor];
        return NO;
    }else{
        
        return YES;
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 100:
            [self.phoneField becomeFirstResponder];
            break;
        case 101:
            [self.verificationCodeField becomeFirstResponder];
            break;
            
        default:
            break;
    }
}
@end
