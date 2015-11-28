//
//  GoodsListCell.h
//  gongShu
//
//  Created by 史岁富 on 15/11/20.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *goodsImage;
@property (strong, nonatomic) IBOutlet UILabel *goodsNameLbl;
@property (strong, nonatomic) IBOutlet UIImageView *goodsstandardLbl;
@property (strong, nonatomic) IBOutlet UILabel *countLbl;

@property (nonatomic,strong) NSDictionary *dataDic;

@end
