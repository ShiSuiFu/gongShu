//
//  OrderFormTableViewCell.h
//  gongShu
//
//  Created by 史岁富 on 15/11/19.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderFormTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *typeLbl;
@property (strong, nonatomic) IBOutlet UILabel *orderFormNumLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UILabel *userIdLbl;
@property (strong, nonatomic) IBOutlet UILabel *sumOfMoneyLbl;// 合计金额
@property (strong, nonatomic) IBOutlet UILabel *totleAmountLbl;//共计数量
@property (strong, nonatomic) IBOutlet UIImageView *line1;
@property (strong, nonatomic) IBOutlet UIImageView *line2;
@property (nonatomic,strong) NSDictionary *dataDic;

@end
