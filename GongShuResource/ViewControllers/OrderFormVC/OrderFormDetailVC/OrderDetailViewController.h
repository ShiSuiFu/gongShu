//
//  OrderDetailViewController.h
//  gongShu
//
//  Created by 史岁富 on 15/11/20.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderDetailViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *sendOutGoodsButton;
@property (copy,nonatomic) NSString *pushID;
@property (copy,nonatomic) NSString *labelLogistics;

- (IBAction)sendOutClick:(id)sender;

@end
