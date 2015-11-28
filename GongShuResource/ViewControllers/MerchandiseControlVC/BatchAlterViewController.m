//
//  BatchAlterViewController.m
//  gongShu
//
//  Created by 史岁富 on 15/11/28.
//  Copyright © 2015年 付朋华. All rights reserved.
//

#import "BatchAlterViewController.h"
#import "BatchViewCell.h"

@interface BatchAlterViewController ()

@end

@implementation BatchAlterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setTitleViewWithTitle:@"批量修改"];
    self.slideView.dataSourceDelegate = self;
    self.slideView.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //    self.sliderView.dataSourceDelegate = self;
    //    self.sliderView.delegate = self;
}
- (NSArray *)headerTitleArray{
    return @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成"];
}
- (void)headerTitleClick:(int)index{
    NSLog(@"第 %d 个 Title is clicked",index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"BatchViewCell";
    BatchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BatchViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //刷新数据,刷新对应的那一行
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    
    BatchViewCell *batchCell = [tableView cellForRowAtIndexPath:indexPath];
    batchCell.goodsChoose.selected = !batchCell.goodsChoose.selected;
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)TableViewHeaderRefresh:(UITableView *)tableView{
    [tableView headerEndRefreshing];
    NSLog(@"第 %d 个 tableView 下拉刷新",(int)tableView.tag);
}
- (void)TableViewFooterRefresh:(UITableView *)tableView{
    [tableView footerEndRefreshing];
    
    NSLog(@"第 %d 个 tableView 上拉加载",(int)tableView.tag);
    
}


- (IBAction)batchAlterClick {
}

- (IBAction)batchDownClick {
}
@end
