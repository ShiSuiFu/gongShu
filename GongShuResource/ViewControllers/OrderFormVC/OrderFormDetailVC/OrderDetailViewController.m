//
//  OrderDetailViewController.m
//  gongShu
//
//  Created by 史岁富 on 15/11/20.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailInfoCell.h"
#import "OrderListCell.h"
#import "SendOutViewController.h"
#import "AddLogisticsCell.h"

@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *goodsDetailArray;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleViewWithTitle:@"订单详情"];
    self.goodsDetailArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    if (self.pushID.length>0) {
        self.sendOutGoodsButton.hidden = YES;
        self.tableView.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64);
    }
}
- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma  --mark  -- UITableViewDataSource and UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.pushID.length>0) {
            return 2;
        }
        return 1;
    }else{
        return 5;
        return self.goodsDetailArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.pushID.length>0) {
            if (indexPath.row == 0) {
                static NSString *cellID = @"OrderDetailInfoCell";
                OrderDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailInfoCell" owner:self options:nil]lastObject];
                }
                return cell;
            } else {
                static NSString *cellID = @"AddLogisticsCell";
                AddLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"AddLogisticsCell" owner:self options:nil]lastObject];
                }
                cell.labelLogistics.text = self.labelLogistics;
                return cell;
            }
        }
        static NSString *cellID = @"OrderDetailInfoCell";
        OrderDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailInfoCell" owner:self options:nil]lastObject];
        }
        return cell;
    }else{
        static NSString *cellID = @"OrderListCell";
        OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderListCell" owner:self options:nil]lastObject];
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.pushID.length>0) {
            if (indexPath.row == 0) {
                return 259;
            } else {
                return 44;
            }
        }
        return 259;
    }else{
        return 70;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00000000000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 25)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kMainScreenWidth-15, 25)];
    if (section == 0) {
        label.text = @"基本信息";
    }else{
        label.text = @"订购清单";
    }
    label.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
    label.font = [UIFont systemFontOfSize:12];
    [view addSubview:label];
    return view;
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

- (IBAction)sendOutClick:(id)sender {
    SendOutViewController *sendOutVC = [[SendOutViewController alloc]init];
    [self.navigationController pushViewController:sendOutVC animated:YES];
}
@end
