//
//  BatchAlterViewController.h
//  gongShu
//
//  Created by 史岁富 on 15/11/28.
//  Copyright © 2015年 付朋华. All rights reserved.
//

#import "BaseViewController.h"
#import "MySlideTabBarView.h"

@interface BatchAlterViewController : BaseViewController
@property (weak, nonatomic) IBOutlet MySlideTabBarView *slideView;
@property (weak, nonatomic) IBOutlet UIButton *batchAlter;
@property (weak, nonatomic) IBOutlet UIButton *batchDown;


- (IBAction)batchAlterClick;
- (IBAction)batchDownClick;

@end
