//
//  GoodsListCell.m
//  gongShu
//
//  Created by 史岁富 on 15/11/20.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "OrderListCell.h"

@implementation OrderListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    self.goodsNameLbl.adjustsFontSizeToFitWidth = YES;
}
@end
