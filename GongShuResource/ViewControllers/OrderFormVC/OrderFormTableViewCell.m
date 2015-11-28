//
//  OrderFormTableViewCell.m
//  gongShu
//
//  Created by 史岁富 on 15/11/19.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "OrderFormTableViewCell.h"

@implementation OrderFormTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.typeLbl.layer.masksToBounds = YES;
    self.typeLbl.layer.cornerRadius = 5;
    self.line1.frameHeight = 0.7;
    self.line2.frameHeight = 0.7;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
}
@end
