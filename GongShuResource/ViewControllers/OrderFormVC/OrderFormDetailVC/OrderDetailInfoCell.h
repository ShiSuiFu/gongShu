//
//  OrderDetailInfoCell.h
//  gongShu
//
//  Created by 史岁富 on 15/11/20.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailInfoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *orderNumLbl;
@property (strong, nonatomic) IBOutlet UILabel *orderDateLbl;
@property (strong, nonatomic) IBOutlet UILabel *userIDLbl;
@property (strong, nonatomic) IBOutlet UILabel *customerInfoLbl;
@property (strong, nonatomic) IBOutlet UILabel *payTypeLbl;
@property (strong, nonatomic) IBOutlet UILabel *realPayAmountLbl;

@property (nonatomic,strong) NSDictionary *dataDic;
@end
