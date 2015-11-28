//
//  MyInfoViewController.m
//  gongShu
//
//  Created by 史岁富 on 15/11/18.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "MyInfoViewController.h"
#import "FirstViewCell.h"
#import "MyListViewCell.h"

@interface MyInfoViewController (){
    NSArray *_leftName;
    NSArray *_rightName;
}

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setTitleViewWithTitle:@"我"];
    _leftName = @[@"",@"配送范围",@"类别",@"联系方式",@"规格",@"版本升级"];
    _rightName = @[@"",@"徐汇区到浦东新区",@"饮料",@"13838380438",@"200ml",@""];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 95;
    }
    return 44;
}
-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *cellId = @"FirstViewCell";
        FirstViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstViewCell" owner:self options:nil]lastObject];
        }
        cell.IconImage.image = [UIImage imageNamed:@"TabBarItem_sel_3"];
        return cell;
    }
    static NSString *cellId = @"MyListViewCell";
    MyListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyListViewCell" owner:self options:nil]lastObject];
    }
    cell.iconImage.image = [UIImage imageNamed:@"TabBarItem_sel_3"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00000000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00000000001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
}

@end
