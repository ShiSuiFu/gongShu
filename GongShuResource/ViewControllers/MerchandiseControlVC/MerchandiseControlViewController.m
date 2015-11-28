//
//  MerchandiseControlViewController.m
//  gongShu
//
//  Created by 史岁富 on 15/11/18.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "MerchandiseControlViewController.h"
#import "GoodsTableViewCell.h"
#import "ReleaseCommodityViewController.h"
#import "BatchAlterViewController.h"

@interface MerchandiseControlViewController ()<MySliderTabBarDataSourceDelegate,MySliderTabBarDelegate>

@end

@implementation MerchandiseControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleViewWithTitle:@"货架"];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.listView.dataSourceDelegate = self;
    self.listView.delegate = self;
}
- (NSArray *)headerTitleArray{
    return @[@"全部",@"生鲜",@"零食",@"烟酒",@"饮料",@"日用品"];
}
- (void)headerTitleClick:(int)index{
    NSLog(@"第 %d 个 Title is clicked",index);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"GoodsTableViewCell";
    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsTableViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReleaseCommodityViewController *relComVC = [[ReleaseCommodityViewController alloc]init];
    GoodsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    relComVC.name = cell.name;
    relComVC.image = cell.image;
    relComVC.size = cell.size;
    relComVC.price = cell.price;
    relComVC.classify = cell.classify;
    relComVC.stock = cell.stock;
    relComVC.pushID = @"详情";
    [self.navigationController pushViewController:relComVC animated:YES];
}

- (void)TableViewHeaderRefresh:(UITableView *)tableView{
    [tableView headerEndRefreshing];
    NSLog(@"第 %d 个 tableView 下拉刷新",(int)tableView.tag);
}
- (void)TableViewFooterRefresh:(UITableView *)tableView{
    [tableView footerEndRefreshing];
    
    NSLog(@"第 %d 个 tableView 上拉加载",(int)tableView.tag);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)issueGoods {
    ReleaseCommodityViewController *relComVC = [[ReleaseCommodityViewController alloc]init];
    [self.navigationController pushViewController:relComVC animated:YES];
}

- (IBAction)batchAlter {
    BatchAlterViewController *batchAlterVC = [[BatchAlterViewController alloc]init];
    [self.navigationController pushViewController:batchAlterVC animated:YES];
}

- (IBAction)goodsDown {
}

- (IBAction)headerButtonClick:(id)sender {
}
@end
