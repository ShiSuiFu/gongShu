//
//  MyListViewCell.h
//  gongShu
//
//  Created by 史岁富 on 15/11/28.
//  Copyright © 2015年 付朋华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyListViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *LabelName;
@property (weak, nonatomic) IBOutlet UILabel *LabelDetail;

@end
