//
//  MyTabBarViewController.m
//  doctor
//
//  Created by yanjing on 15/7/31.
//  Copyright (c) 2015年 fupenghua. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "FactoryModel.h"
#import "LSNavigationController.h"
@interface MyTabBarViewController ()
{
    NSMutableArray *navArry;
}
@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self initTabViewController];
    [self initTabBarItem];
    // Do any additional setup after loading the view.
}
- (void)initTabViewController
{
    NSArray *arry = [[FactoryModel shareFactoryModel] getTabbarArrys];
    navArry = [NSMutableArray arrayWithCapacity:0];
    if(arry && arry.count>0)
    {
        int a = 0;
        for(UIViewController *vc in arry)
        {
            LSNavigationController *nav = [[LSNavigationController alloc] initWithRootViewController:vc];
            nav.view.tag = 20+a;
            [navArry addObject:nav];
            a++;
        }
    }
    
    self.viewControllers = navArry;
}

- (void)initTabBarItem
{
    [self.tabBar setShadowImage:[[UIImage alloc] init]];
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    if (IS_IOS7) {
        CGRect frame = CGRectMake(0.0, 0, kMainScreenWidth, self.tabBar.bounds.size.height);
        UIView *v = [[UIView alloc] initWithFrame:frame];
        [v setBackgroundColor:[UIColor whiteColor]];
        [self.tabBar insertSubview:v atIndex:0];
    }
    NSArray *tabTitleArray = [NSArray arrayWithObjects:@"订单",@"商品管理",@"我",nil];
    for(int i=0; i<navArry.count;i++)
    {
        UITabBarItem *tabBarItem = self.tabBar.items[i];
        UIImage *norimg = nil;
        UIImage *selimg = nil;
        norimg = [UIImage imageNamed:[NSString stringWithFormat:@"TabBarItem_nor_%d",i+1]];
        selimg = [UIImage imageNamed:[NSString stringWithFormat:@"TabBarItem_sel_%d",i+1]];
        
        [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#8A8A8A"], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#FFB808"],NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
        if(IS_IOS7)
        {
            norimg = [norimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            selimg = [selimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarItem.image = norimg;
            tabBarItem.selectedImage = selimg;
            tabBarItem.tag = i;
        }
        tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0, -3);
//        tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
        tabBarItem.title = [tabTitleArray objectAtIndex:i];
        
    }
    [self.tabBar setTintColor:[UIColor whiteColor]];
    
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    return YES;
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

@end
