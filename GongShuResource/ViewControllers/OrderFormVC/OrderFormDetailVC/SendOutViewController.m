//
//  SendOutViewController.m
//  gongShu
//
//  Created by 史岁富 on 15/11/20.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "SendOutViewController.h"
#import "OrderDetailViewController.h"

@interface SendOutViewController ()

@end

@implementation SendOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleViewWithTitle:@"确认发货"];
    
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)leftBtnClick {
    OrderDetailViewController *outDetailVC = [[OrderDetailViewController alloc]init];
    [self.navigationController pushViewController:outDetailVC animated:YES];
}

- (IBAction)rightBtnClick {
    OrderDetailViewController *outDetailVC = [[OrderDetailViewController alloc]init];
    outDetailVC.pushID = @"有物流信息";
    outDetailVC.labelLogistics = [NSString stringWithFormat:@"%@ %@",self.companyTF.text,self.freightTF.text];
    [self.navigationController pushViewController:outDetailVC animated:YES];
}
@end
