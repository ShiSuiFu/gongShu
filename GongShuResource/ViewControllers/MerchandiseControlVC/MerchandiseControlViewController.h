//
//  MerchandiseControlViewController.h
//  gongShu
//
//  Created by 史岁富 on 15/11/18.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "BaseViewController.h"
#import "MySlideTabBarView.h"

@interface MerchandiseControlViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet MySlideTabBarView *listView;
- (IBAction)issueGoods;//发布商品
- (IBAction)batchAlter;//批量修改
- (IBAction)goodsDown;//下架商品

- (IBAction)headerButtonClick:(id)sender;
@end
