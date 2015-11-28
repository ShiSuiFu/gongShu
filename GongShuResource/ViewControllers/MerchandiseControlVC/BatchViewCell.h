//
//  BatchViewCell.h
//  gongShu
//
//  Created by 史岁富 on 15/11/28.
//  Copyright © 2015年 付朋华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BatchViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *goodsNameLbl;
@property (strong, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (strong, nonatomic) IBOutlet UILabel *goodsSizeLbl;
@property (strong, nonatomic) IBOutlet UILabel *goodsPriceAndStockLbl;
@property (weak, nonatomic) IBOutlet UIButton *goodsChoose;
- (IBAction)goodsChooseClick;

@end
