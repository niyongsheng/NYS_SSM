//
//  NYSPersonalInfoViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/2.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSPersonalInfoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <UIImageView+WebCache.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import <UMSocialCore/UMSocialCore.h>
#import "NYSButtonFooterView.h"
#import "KHAlertPickerController.h"
#import "NYSBindPhoneViewController.h"

@interface NYSPersonalInfoViewController () <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation NYSPersonalInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [TableViewAnimationKit showWithAnimationType:XSTableViewAnimationTypeFall tableView:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NCurrentUser account];
    
    // 1.tableView
    self.tableView.mj_header.hidden = NO;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // 2.FooterView
    NYSButtonFooterView *footerView = [[NYSButtonFooterView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, 100) withTitle:@"退出登录"];
    [footerView buttonForSendData:self action:@selector(userLogout:)];
    self.tableView.tableFooterView = footerView;
    
    
}

- (void)headerRereshing {
    WS(weakSelf);
    [NYSRequest RefreshUserInfoWithResMethod:GET
                                          parameters:@{@"account" : NCurrentUser.account}
                                             success:^(id response) {
        [self.tableView.mj_header endRefreshing];
        NSDictionary *userData = response[@"data"];
        [NUserManager saveUserInfo:userData];
        [NUserManager loadUserInfo];
        [weakSelf.tableView reloadData];
        [TableViewAnimationKit showWithAnimationType:XSTableViewAnimationTypeFall tableView:self.tableView];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    } isCache:YES];
}

#pragma mark —- tableview delegate —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 ) {
        return 65.f;
    } else if (indexPath.row == 9 || indexPath.row == 10) {
        return 65.f;
    } else if (indexPath.row == 13 || indexPath.row == 14) {
        return 50.f;
    } else {
        return 44.f;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"头像";
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NCurrentUser icon]] placeholderImage:[UIImage imageNamed:@"me_photo_80x80_"]];
        imageView.layer.cornerRadius = 25.f;
        imageView.layer.masksToBounds = YES;
        cell.accessoryView = imageView;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"姓名";
        cell.detailTextLabel.text = [NCurrentUser truename];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"昵称";
        cell.detailTextLabel.text = [NCurrentUser nickname];
    } else if (indexPath.row == 3) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"等级";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", [NCurrentUser grade]];
    } else if (indexPath.row == 4) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"稻壳";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld粒", [NCurrentUser score]];
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"性别";
        if ([[NCurrentUser gender] isEqualToString:@"male"]) {
            cell.detailTextLabel.text = @"弟兄";
        } else if ([[NCurrentUser gender] isEqualToString:@"female"]) {
            cell.detailTextLabel.text = @"姊妹";
        } else if ([[NCurrentUser gender] isEqualToString:@"secret"]) {
            cell.detailTextLabel.text = @"保密";
        } else {
            cell.detailTextLabel.text = @"未知";
        }
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"生日";
        cell.detailTextLabel.text = [NCurrentUser birthday];
    } else if (indexPath.row == 7) {
        cell.textLabel.text = @"手机号";
        cell.detailTextLabel.text = [NCurrentUser phone];
    } else if (indexPath.row == 8) {
        cell.textLabel.text = @"邮箱";
        cell.detailTextLabel.text = [NCurrentUser email];
    } else if (indexPath.row == 9) {
        cell.textLabel.text = @"简介";
        cell.detailTextLabel.text = [NCurrentUser introduction];
        cell.detailTextLabel.numberOfLines = 0;
    } else if (indexPath.row == 10) {
        cell.textLabel.text = @"地址";
        cell.detailTextLabel.text = [NCurrentUser address];
        cell.detailTextLabel.numberOfLines = 0;
    } else if (indexPath.row == 11) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"团契";
        cell.detailTextLabel.text = [NCurrentUser fellowshipName];
    } else if (indexPath.row == 12) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"身份";
        switch ([NCurrentUser profession]) {
            case 0:
                cell.detailTextLabel.text = @"特殊用户";
                break;
                
            case 1:
                cell.detailTextLabel.text = @"普通用户";
                break;
                
            case 2:
                cell.detailTextLabel.text = @"管理员";
                break;
                
            default:
                break;
        }
    } else if (indexPath.row == 13) {
        cell.textLabel.text = @"QQ";
        cell.detailTextLabel.text = [NCurrentUser qqOpenid];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [imageView setImage:[UIImage imageNamed:@"qq"]];
        cell.accessoryView = imageView;
    } else if (indexPath.row == 14) {
        cell.textLabel.text = @"We Chat";
        cell.detailTextLabel.text = [NCurrentUser wcOpenid];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [imageView setImage:[UIImage imageNamed:@"wc"]];
        cell.accessoryView = imageView;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: {
            [self selectImageSource];
        }
            break;
        
        case 1: {
            [self updateAlertWithTitle:@"修改姓名" message:@"请填写您的真实姓名" placeHolder:[NCurrentUser truename] parameterKey:@"truename"];
        }
            break;
            
        case 2: {
            [self updateAlertWithTitle:@"修改昵称" message:nil placeHolder:[NCurrentUser nickname] parameterKey:@"nickname"];
        }
            break;
            
        case 3: { // 等级
            
        }
            break;
            
        case 4: { // 积分
            
        }
            break;
            
        case 5: { // 性别
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *maleBtn = [UIAlertAction actionWithTitle:@"弟兄" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
                [weakSelf updateUserInfo:@{@"gender":@"male"}];
            }];
            UIAlertAction *femaleBtn = [UIAlertAction actionWithTitle:@"姊妹" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
                [weakSelf updateUserInfo:@{@"gender":@"female"}];
            }];
            UIAlertAction *secretBtn = [UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
                [weakSelf updateUserInfo:@{@"gender":@"secret"}];
            }];
            [alertVc addAction:cancelBtn];
            [alertVc addAction:maleBtn];
            [alertVc addAction:femaleBtn];
            [alertVc addAction:secretBtn];
            [self presentViewController:alertVc animated:YES completion:nil];
        }
            break;
            
        case 6: { // 生日
            UIDatePicker *datePicker = [[UIDatePicker alloc] init];
            datePicker.datePickerMode = UIDatePickerModeDate;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            KHAlertPickerController *alertPicker = [KHAlertPickerController alertPickerWithTitle:@"生日" DatePicker:datePicker DateFormatter:dateFormatter];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf updateUserInfo:@{@"birthday":alertPicker.contentStr}];
            }];
            [alertPicker addCompletionAction:sureAction];
            [self presentViewController:alertPicker animated:YES completion:nil];
        }
            break;
            
        case 7: { // 手机号
            NYSBindPhoneViewController *phoneBindVC = NYSBindPhoneViewController.new;
            phoneBindVC.isShowPasswordView = [NCurrentUser password] ? NO : YES;
            [self.navigationController pushViewController:phoneBindVC animated:YES];
        }
            break;
            
        case 8: {
            [self updateAlertWithTitle:@"修改邮箱" message:nil placeHolder:[NCurrentUser email] parameterKey:@"e_mail"];
        }
            break;
            
        case 9: {
            [self updateAlertWithTitle:@"修改简介" message:nil placeHolder:[NCurrentUser introduction] parameterKey:@"introduction"];
        }
            break;
            
        case 10: {
            [self updateAlertWithTitle:@"修改地址" message:@"请填写完整有效的地址" placeHolder:[NCurrentUser address] parameterKey:@"address"];
        }
            break;
            
        case 11: { // 团契
            
        }
            break;
            
        case 12: { // 身份
            
        }
            break;
            
        case 13: { // qq
            [SVProgressHUD showWithStatus:@"授权中..."];
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
                [SVProgressHUD dismiss];
                if (error) {
                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                    [SVProgressHUD dismissWithDelay:1.f];
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    [self updateUserInfo:@{@"qqOpenid" : resp.uid}];
                }
            }];
        }
            break;
            
        case 14: { // wc
            [SVProgressHUD showWithStatus:@"授权中..."];
                [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
                    if (error) {
                        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                        [SVProgressHUD dismissWithDelay:1.5f];
                    } else {
                        UMSocialUserInfoResponse *resp = result;
                        [self updateUserInfo:@{@"wcOpenid" : resp.uid}];
                    }
                }];
        }
            break;
            
        default: {
        }
            break;
    }
}


/// 图片选择方法
- (void)selectImageSource {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NLog(@"点击了取消");
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:photoAction];
    [actionSheet addAction:cancelAction];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma pickerController的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 上传服务器
    [NYSRequest UploadImagesWithImages:@[image] fileNames:nil name:@"files" parameters:@{@"fellowship":[NSString stringWithFormat:@"%ld", (long)[NCurrentUser fellowship]]} process:^(NSProgress *uploadProcess) {

    } success:^(id response) {
        [self updateUserInfo:@{@"icon":[[response[@"data"] firstObject] objectForKey:@"FileFullURL"]}];
    } failure:^(NSError *error) {

    }];
}

/// 文本内容提交修改方法
- (void)updateAlertWithTitle:(NSString *)title message:(NSString *)message placeHolder:(NSString *)placeholder parameterKey:(NSString *)parameterKey {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder;
    }];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NLog(@"取消");
    }];
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self updateUserInfo:@{parameterKey:alertVc.textFields.firstObject.text}];
    }];
    [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [alertVc addAction:cancelBtn];
    [alertVc addAction:sureBtn];
    [self presentViewController:alertVc animated:YES completion:nil];
}

/// 提交更改
/// @param parameter 参数
- (void)updateUserInfo:(NSDictionary *)parameter {
    [NYSRequest UpdateUserInfoWithResMethod:POST parameters:parameter success:^(id response) {
        [SVProgressHUD showSuccessWithStatus:response[@"msg"]];
        [SVProgressHUD dismissWithDelay:.7f completion:^{
            [NUserManager saveUserInfo:response[@"data"]];
            [NUserManager loadUserInfo];
            [self.tableView reloadData];
        }];
    } failure:^(NSError *error) {
        
    } isCache:NO];
}

#pragma mark —- 退出 --
- (void)userLogout:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要退出当前登录吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [NUserManager logout:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NLog(@"Cancel Action");
    }];
    
    [alertController addAction:logoutAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
