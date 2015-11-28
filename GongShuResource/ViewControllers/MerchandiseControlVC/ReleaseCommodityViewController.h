//
//  ReleaseCommodityViewController.h
//  gongShu
//
//  Created by davidlv on 15/11/24.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "BaseViewController.h"

@interface ReleaseCommodityViewController : BaseViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *ImShelvesClick;

@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *size;
@property (copy,nonatomic) NSString *price;
@property (copy,nonatomic) NSString *stock;
@property (copy,nonatomic) NSString *classify;
@property (strong,nonatomic) UIImage *image;

@property (copy,nonatomic) NSString *pushID;

- (IBAction)ImmediatelyShelves;

@end
