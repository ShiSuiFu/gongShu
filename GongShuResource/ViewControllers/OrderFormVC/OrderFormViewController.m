//
//  OrderFormViewController.m
//  gongShu
//
//  Created by 史岁富 on 15/11/18.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "OrderFormViewController.h"
#import "OrderFormTableViewCell.h"
#import "OrderDetailViewController.h"

@interface OrderFormViewController ()<MySliderTabBarDataSourceDelegate,MySliderTabBarDelegate>

@end

@implementation OrderFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setTitleViewWithTitle:@"订单"];
    self.sliderView.dataSourceDelegate = self;
    self.sliderView.delegate = self;
    
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
    return 4;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}
-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"OrderFormTableViewCell";
    OrderFormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderFormTableViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc]init];
    switch (tableView.tag) {
        case 0:
        {
            
        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (void)TableViewHeaderRefresh:(UITableView *)tableView{
    [tableView headerEndRefreshing];
    NSLog(@"第 %d 个 tableView 下拉刷新",(int)tableView.tag);
}
- (void)TableViewFooterRefresh:(UITableView *)tableView{
    [tableView footerEndRefreshing];

    NSLog(@"第 %d 个 tableView 上拉加载",(int)tableView.tag);

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
