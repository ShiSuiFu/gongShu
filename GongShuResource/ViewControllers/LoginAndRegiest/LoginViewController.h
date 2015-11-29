//
//  LoginViewController.h
//  daShu
//
//  Created by 付朋华 on 15/11/6.
//  Copyright © 2015年 付朋华. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIButton *getCodeButton;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UILabel *timerLbl;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITextField *verificationCodeField;

- (IBAction)getCodeClick:(id)sender;
- (IBAction)loginClick:(id)sender;
@end
