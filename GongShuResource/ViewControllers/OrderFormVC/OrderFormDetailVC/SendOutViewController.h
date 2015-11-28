//
//  SendOutViewController.h
//  gongShu
//
//  Created by 史岁富 on 15/11/20.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "BaseViewController.h"

@interface SendOutViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *companyTF;
@property (weak, nonatomic) IBOutlet UITextField *freightTF;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (IBAction)leftBtnClick;
- (IBAction)rightBtnClick;

@end
