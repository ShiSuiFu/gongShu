//
//  BaseViewController.h
//  daShu
//
//  Created by 史岁富 on 15/11/3.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFXMLRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFAppDotNetAPIClient.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController<UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
}
- (void)back;

- (void)showHUDInView;
- (void)hidHUDView;
- (void)setTitleViewWithTitle:(NSString *)title;
- (void)setLeftButton:(UIImage *)aImg width:(CGFloat)aWidth height:(CGFloat)aHeight title:(NSString *)aTitle target:(id)aTarget action:(SEL)aSelector;
- (void)setRightButton:(UIImage *)aImg width:(CGFloat)aWidth height:(CGFloat)aHeight title:(NSString *)aTitle target:(id)aTarget action:(SEL)aSelector
;

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(id responseObject,id data,int flag,NSString *msg))success failure:(void (^)())failure;

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(id responseObject,id data,int flag,NSString *msg))success failure:(void (^)())failure;
@end
