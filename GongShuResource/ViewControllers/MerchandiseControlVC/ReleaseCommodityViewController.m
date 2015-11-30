//
//  ReleaseCommodityViewController.m
//  gongShu
//
//  Created by davidlv on 15/11/24.
//  Copyright © 2015年 史岁富. All rights reserved.
//

#import "ReleaseCommodityViewController.h"

#define imageHeght 200

#define intervalH 10//间痕大小
#define textFTH 40//行间高度
#define firstH 200//图片高度

@interface ReleaseCommodityViewController (){
    UIImageView *camera;
    UIImageView *smallImage;
}

@property (nonatomic,strong) NSMutableArray *goodsDetailArray;
@property (nonatomic,strong) NSArray *leftArray;
@property (nonatomic,strong) NSArray *rightArray;

@end

@implementation ReleaseCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleViewWithTitle:@"发布商品"];
    
    // Do any additional setup after loading the view from its nib.
    self.leftArray = @[@"名称",@"规格",@"类目",@"商品描述",@"库存",@"价格"];
    self.rightArray = @[@"请输入商品名称",@"请输入商品规格",@"请选择商品分类",@"请输入商品描述",@"请输入库存数量",@"请输入商品价格"];
    
    //监听键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-104)];
    //设置弹簧效果
    self.scrollView.bounces = YES;
    //关闭垂直和水平的进度条
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    [self cameraView];
    [self adTextFieldView];
    
}
-(void)dismissKeyBoard{
    [self.view endEditing:YES];
}
//键盘出现
- (void)keyboardWillShow:(NSNotification*)noti{
    //键盘的高度
    CGSize size = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //屏幕宽高
    CGSize winSize = self.view.frame.size;
    //tableView的大小
    self.scrollView.frame = CGRectMake(0, 0, winSize.width, winSize.height - size.height);
}

//键盘消失
- (void)keyboardWillHide:(NSNotification*)noti{
    //屏幕宽高
    CGSize winSize = self.view.frame.size;
    //tableView的大小恢复
    self.scrollView.frame = CGRectMake(0, 0, winSize.width, winSize.height-40);
}
- (void)addPhoto{
    [self.view endEditing:YES];
    UIActionSheet *actiontxt = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",nil];
    actiontxt.tag = 123;
    [actiontxt setActionSheetStyle:UIActionSheetStyleDefault];
    [actiontxt showInView:[UIApplication sharedApplication].keyWindow];//参数指显示UIActionSheet的parent。
    
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet: (UIActionSheet *) actionSheet didDismissWithButtonIndex:(NSInteger) buttonIndex
{
    if (buttonIndex ==2) {
        
    }else{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        if (buttonIndex == 1) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else{
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            [MBProgressHUD showView:self.view withTitle:@"模拟器不支持拍照"];
//            return;
        }
        picker.view.tag = actionSheet.tag;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
}
- (NSString *)URLEncodedString:(NSString *)strUrl
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)strUrl,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

#pragma mark delegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //    CGSize imageSize = [(UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage] size];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGFloat cameraH = image.size.height/(image.size.width/kMainScreenWidth);
    camera.frame = CGRectMake(0, textFTH*5+intervalH*2, kMainScreenWidth, cameraH);
    camera.image = image;
    smallImage.hidden = YES;
    UIImageView *waterStain = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-55, 15, 40, 40)];
    waterStain.image = [UIImage imageNamed:@"camera"];
    [camera addSubview:waterStain];
    //设置可展示内容的size
    self.scrollView.contentSize = CGSizeMake(kMainScreenWidth, cameraH+textFTH*6+intervalH*2);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSData *imageData = UIImageJPEGRepresentation(image,0.4);
#pragma mark - 不同版本方法适配
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    NSString *tempImageString = [self URLEncodedString:[imageData base64Encoding]];
#endif
    NSString *tempImageString = [self URLEncodedString:[imageData base64EncodedStringWithOptions:0]];
    
    [self uploadImageToServer:tempImageString];
}
- (void)uploadImageToServer:(NSString *)imageStr{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:imageStr forKey:@"userPhoto"];
//    [MBProgressHUD showView:self.view withTitle:@"正在上传"];
    
//    [[CommonRequest sharedObject] postRequest:uploadImageToServer() Params:params sucessBlock:^(id dicResult) {
//        [self hideHUD];
//        if ([nullToString([dicResult objectForKey:@"responseStatus"])integerValue] == 200) {
//            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"]];
//            [userInfo setObject:nullToString([dicResult objectForKey:@"body"]) forKey:@"userPhoto"];
//            
//            [[NSUserDefaults standardUserDefaults]setObject:userInfo forKey:@"userInfo"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//            [self.navigationController popViewControllerAnimated:YES];
//            
//        }else{
//            [self hideHUD];
//            [iToast showCenterDefault:nullToString([[dicResult objectForKey:@"result"]objectForKey:@"msg"]) parentView:self.view];
//        }
//    } FaildBlock:^(NSError *error) {
//    }];
}
- (void)cameraView{
    camera = [[UIImageView alloc] initWithFrame:CGRectMake(0, textFTH*5+intervalH*2, kMainScreenWidth, firstH)];
    camera.backgroundColor = [UIColor whiteColor];
    camera.userInteractionEnabled = YES;
    [self.scrollView addSubview:camera];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto)];
    [camera addGestureRecognizer:tapGesture];
    
    smallImage = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-50, firstH/2-50, 100, 100)];
    smallImage.image = [UIImage imageNamed:@"camera"];
    smallImage.userInteractionEnabled = YES;
    [camera addSubview:smallImage];
}
- (void)adTextFieldView{
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    [self.scrollView addGestureRecognizer:tapGesture];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, intervalH*1+textFTH*5)];
    view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view];
    
    UILabel *one = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, textFTH)];
    one.text = self.leftArray[0];
    one.font = [UIFont systemFontOfSize:14];
    [view addSubview:one];
    UITextField *oneTF = [[UITextField alloc] initWithFrame:CGRectMake(115, 0, kMainScreenWidth-130, textFTH)];
    oneTF.textAlignment = NSTextAlignmentRight;
    oneTF.placeholder = self.rightArray[0];
    oneTF.font = [UIFont systemFontOfSize:14];
    oneTF.borderStyle = UITextBorderStyleNone;
    [view addSubview:oneTF];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, textFTH, kMainScreenWidth, 1)];//线3
    line1.backgroundColor = RGBColor(239, 239, 239);
    [view addSubview:line1];
    
    UILabel *two = [[UILabel alloc] initWithFrame:CGRectMake(15, textFTH, 100, textFTH)];
    two.text = self.leftArray[1];
    two.font = [UIFont systemFontOfSize:14];
    [view addSubview:two];
    UITextField *twoTF = [[UITextField alloc] initWithFrame:CGRectMake(115, textFTH, kMainScreenWidth-130, textFTH)];
    twoTF.textAlignment = NSTextAlignmentRight;
    twoTF.placeholder = self.rightArray[1];
    twoTF.font = [UIFont systemFontOfSize:14];
    twoTF.borderStyle = UITextBorderStyleNone;
    [view addSubview:twoTF];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, textFTH*2, kMainScreenWidth, 1)];//线3
    line2.backgroundColor = RGBColor(239, 239, 239);
    [view addSubview:line2];
    
    UILabel *three = [[UILabel alloc] initWithFrame:CGRectMake(15, textFTH*2, 100, textFTH)];
    three.text = self.leftArray[2];
    three.font = [UIFont systemFontOfSize:14];
    [view addSubview:three];
    UILabel *threeTF = [[UILabel alloc] initWithFrame:CGRectMake(115, textFTH*2, kMainScreenWidth-150, textFTH)];
    threeTF.textAlignment = NSTextAlignmentRight;
    threeTF.text = self.rightArray[2];
    three.userInteractionEnabled = NO;
    threeTF.font = [UIFont systemFontOfSize:14];
    [view addSubview:threeTF];
    UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-30, textFTH*2+10, 10, textFTH-20)];
    rightImage.image = [UIImage imageNamed:@"rightDetail"];
    [view addSubview:rightImage];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, textFTH*2, kMainScreenWidth, textFTH);
    [button addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, textFTH*3, kMainScreenWidth, 1)];//线3
    line3.backgroundColor = RGBColor(239, 239, 239);
    [view addSubview:line3];
    
//    UILabel *four = [[UILabel alloc] initWithFrame:CGRectMake(15, textFTH*3, 100, textFTH)];
//    four.text = self.leftArray[3];
//    four.font = [UIFont systemFontOfSize:14];
//    [view addSubview:four];
//    UILabel *fourTF = [[UILabel alloc] initWithFrame:CGRectMake(115, textFTH*3, kMainScreenWidth-150, textFTH)];
//    fourTF.textAlignment = NSTextAlignmentRight;
//    fourTF.text = self.rightArray[3];
//    four.userInteractionEnabled = NO;
//    fourTF.font = [UIFont systemFontOfSize:14];
//    [view addSubview:fourTF];
//    UIImageView *rightImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-30, textFTH*3+10, 10, textFTH-20)];
//    rightImage1.image = [UIImage imageNamed:@"rightDetail"];
//    [view addSubview:rightImage1];
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button1.frame = CGRectMake(0, textFTH*3, kMainScreenWidth, textFTH);
//    [button1 addTarget:self action:@selector(import) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:button1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, textFTH*3, kMainScreenWidth, intervalH)];//线3
    lineView2.backgroundColor = RGBColor(239, 239, 239);
    [view addSubview:lineView2];
    
    UILabel *five = [[UILabel alloc] initWithFrame:CGRectMake(15, intervalH*1+textFTH*3, 100, textFTH)];
    five.text = self.leftArray[4];
    five.font = [UIFont systemFontOfSize:14];
    [view addSubview:five];
    UITextField *fiveTF = [[UITextField alloc] initWithFrame:CGRectMake(115, intervalH*1+textFTH*3, kMainScreenWidth-130, textFTH)];
    fiveTF.textAlignment = NSTextAlignmentRight;
    fiveTF.placeholder = self.rightArray[4];
    fiveTF.font = [UIFont systemFontOfSize:14];
    fiveTF.borderStyle = UITextBorderStyleNone;
    [view addSubview:fiveTF];
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, intervalH*1+textFTH*4, kMainScreenWidth, 1)];//线3
    line4.backgroundColor = RGBColor(239, 239, 239);
    [view addSubview:line4];
    
    UILabel *six = [[UILabel alloc] initWithFrame:CGRectMake(15, intervalH*1+textFTH*4, 100, textFTH)];
    six.text = self.leftArray[5];
    six.font = [UIFont systemFontOfSize:14];
    [view addSubview:six];
    UITextField *sixTF = [[UITextField alloc] initWithFrame:CGRectMake(115, intervalH*1+textFTH*4, kMainScreenWidth-130, textFTH)];
    sixTF.textAlignment = NSTextAlignmentRight;
    sixTF.placeholder = self.rightArray[5];
    sixTF.font = [UIFont systemFontOfSize:14];
    sixTF.borderStyle = UITextBorderStyleNone;
    [view addSubview:sixTF];
    
    if ([self.pushID isEqualToString:@"详情"]) {
        [self setTitleViewWithTitle:@"修改"];
        [self.ImShelvesClick setTitle:@"保存修改" forState:UIControlStateNormal];
        if (self.name) {
            oneTF.text = self.name;
        }
        if (self.size) {
            twoTF.text = self.size;
        }
        if (self.classify) {
            threeTF.text = self.classify;
        }
//        if (<#condition#>) {
//            fourTF.text = @"商品描述";
//        }
        if (self.stock) {
            fiveTF.text = self.stock;
        }
        if (self.price) {
            sixTF.text = self.price;
        }
        
        if (self.image) {
            camera.image = self.image;
            smallImage.hidden = YES;
            UIImageView *waterStain = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-55, 15, 40, 40)];
            waterStain.image = [UIImage imageNamed:@"camera"];
            [camera addSubview:waterStain];
        }
    }
}
- (void)choose{
    NSLog(@"请选择商品分类");
}
- (void)import{
    NSLog(@"请输入商品描述");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//#pragma -- mark -- UITableViewDataSource and UITableViewDelegate
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 4;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 1;
//    } else if (section == 3) {
//        return 3;
//    } else {
//        return 2;
//    }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        static NSString *cellID = @"UITableViewCell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, imageHeght)];
//            UIImageView *smaillImage = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-50, imageHeght/2-50, 100, 100)];
//            smaillImage.image = [UIImage imageNamed:@"camera"];
//            [imageView addSubview:smaillImage];
//            [cell.contentView addSubview:imageView];
//        }
//        return cell;
//    }else{
//        NSString *cellID = [NSString stringWithFormat:@"Cell%ld %ld", indexPath.section,indexPath.row];//以indexPath来唯一确定cell
//        ReleaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReleaseViewCell" owner:self options:nil]lastObject];
//        }
//        switch (indexPath.section) {
//            case 1:
//            {
//                switch (indexPath.row) {
//                    case 0:
//                    {
//                        cell.LabelLeft.text = self.leftArray[0];
//                        cell.rightTF.placeholder = self.rightArray[0];
//                    }
//                        break;
//                    case 1:
//                    {
//                        cell.LabelLeft.text = self.leftArray[1];
//                        cell.rightTF.placeholder = self.rightArray[1];
//                    }
//                        break;
//                        
//                    default:
//                        break;
//                }
//            }
//                break;
//            case 2:
//            {
//                switch (indexPath.row) {
//                    case 0:
//                    {
//                        cell.LabelLeft.text = self.leftArray[2];
//                        cell.rightTF.placeholder = self.rightArray[2];
//                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                        cell.rightTF.userInteractionEnabled = NO;
//                    }
//                        break;
//                    case 1:
//                    {
//                        cell.LabelLeft.text = self.leftArray[3];
//                        cell.rightTF.placeholder = self.rightArray[3];
//                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                        cell.rightTF.userInteractionEnabled = NO;
//                    }
//                        break;
//                        
//                    default:
//                        break;
//                }
//            }
//                break;
//            case 3:
//            {
//                switch (indexPath.row) {
//                    case 0:
//                    {
//                        cell.LabelLeft.text = self.leftArray[4];
//                        cell.rightTF.placeholder = self.rightArray[4];
//                    }
//                        break;
//                    case 1:
//                    {
//                        cell.LabelLeft.text = self.leftArray[5];
//                        cell.rightTF.placeholder = self.rightArray[5];
//                    }
//                        break;
//                    case 2:
//                    {
//                        cell.LabelLeft.text = self.leftArray[6];
//                        cell.rightTF.placeholder = self.rightArray[6];
//                    }
//                        break;
//                        
//                    default:
//                        break;
//                }
//            }
//                break;
//                
//            default:
//                break;
//        }
//        
//        return cell;
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//            return imageHeght;
//    }else{
//        return 40;
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 0.00000001;
//    } else {
//        return 25;
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.00000000001;
//}
//
- (IBAction)ImmediatelyShelves {
}
@end
