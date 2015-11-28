//
//  GoodsTableViewCell.h
//  gongShu
//
//  Created by 史岁富 on 15/11/20.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *goodsNameLbl;
@property (strong, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (strong, nonatomic) IBOutlet UILabel *goodsSizeLbl;
@property (strong, nonatomic) IBOutlet UILabel *goodsPriceAndStockLbl;

@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *size;
@property (copy,nonatomic) NSString *price;
@property (copy,nonatomic) NSString *stock;
@property (copy,nonatomic) NSString *classify;
@property (strong,nonatomic) UIImage *image;

@property (nonatomic,strong) NSDictionary *dataDic;

@end
