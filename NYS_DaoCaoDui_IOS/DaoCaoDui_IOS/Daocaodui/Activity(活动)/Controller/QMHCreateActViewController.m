//
//  QMHCreateActViewController.m
//  安居公社
//
//  Created by 倪永胜 on 2019/11/1.
//  Copyright © 2019 QingMai. All rights reserved.
//

#import "QMHCreateActViewController.h"
#import "QMHCommitSuccessView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <UIButton+WebCache.h>
#import <AXWebViewController.h>

#define _NAME_MAX_LENGTH_ 15
#define MaxCount 300
@interface QMHCreateActViewController () <UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate> {
        QMHCommitSuccessView *popUP;
}
@property (weak, nonatomic) IBOutlet UIButton *uploadGroupIconBtn;
@property (weak, nonatomic) IBOutlet UIButton *createBtn;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UIButton *IsEULABtn;

@property (nonatomic, strong) NSString *imgAddress;

@end

@implementation QMHCreateActViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.uploadGroupIconBtn.layer.cornerRadius = 45;
    self.uploadGroupIconBtn.clipsToBounds = YES;
    
    self.createBtn.layer.cornerRadius = 20;
    self.createBtn.clipsToBounds = YES;
    
    self.titleTextField.delegate = self;
    self.contentTextView.delegate = self;
    
    self.placeHolderLabel.userInteractionEnabled = NO;
}

/// 上传z活动图标
- (IBAction)uploadGroupIconBtnClicked:(UIButton *)sender {
    [self selectImageSource];
}

/// 创建社区活动
- (IBAction)createBtnClicked:(UIButton *)sender {
    [self createActivity];
}

/// 是否同意用户协议
- (IBAction)EULAClicked:(UIButton *)sender {
    self.IsEULABtn.selected = !self.IsEULABtn.selected;
    self.createBtn.selected = !self.createBtn.selected;
    self.createBtn.backgroundColor = self.IsEULABtn.selected ? [UIColor lightGrayColor] : RGBColor(77, 144, 236);
    self.createBtn.userInteractionEnabled = self.IsEULABtn.selected ? NO : YES;
}

/// 用户协议
- (IBAction)EULAInfoClicked:(UIButton *)sender {
        AXWebViewController *communityNews = [[AXWebViewController alloc] initWithAddress:@"http://activity.qmook.com/"];
        communityNews.showsToolBar = NO;
        communityNews.navigationController.navigationBar.translucent = NO;
        communityNews.title = @"用户协议";
        [self.navigationController pushViewController:communityNews animated:YES];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // 如果是删除减少字数，都返回允许修改
    if ([text isEqualToString:@""]) {
        return YES;
    }
    if (range.location >= MaxCount) {
        return NO;
    } else {
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeHolderLabel.hidden = [@(textView.text.length) boolValue];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL isAllowEdit = YES;
    if([string length]>range.length&&[textField.text length]+[string length]-range.length>_NAME_MAX_LENGTH_) {
        [textField resignFirstResponder];
        isAllowEdit = NO;
    }
    return isAllowEdit;
}

#pragma mark - 图片选择方法
- (void)selectImageSource {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    // 编辑模式
    imagePicker.allowsEditing = YES;
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            // 设置照片来源
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

#pragma mark - pickerController的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 回显选中的图片
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.uploadGroupIconBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    // 填写表单 上传服务器
    // 1、创建请求管理对象
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    // 2、封装请求参数
//    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:@"account" forKey:[userdefaults objectForKey:@"account"]];
//    // 3、发送请求URL
//    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/upload/uploadImg", POSTURL];
//    NLog(@"requestUrl = %@", requestUrl);
//    [SVProgressHUD showWithStatus:@"正在上传图片..."];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    [manager POST:requestUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        // 取出单张图片二进制数据
//        NSData * imageData = UIImageJPEGRepresentation(image, 0.5); // 压缩至原图的10%
//        // 上传的参数名，在服务器端保存文件的文件夹名
//        NSString * Name = @"file";
//        // 使用日期生成图片名称
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyy-MM-dd/HH:mm:ss";
//        NSString *imageName = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString stringWithFormat:@"%@.png",imageName];
//        //            NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
//        [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpg/png/jpeg"];
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NLog(@"请求成功JSON:%@", JSON);
//        if ([[JSON objectForKey:@"success"] integerValue] == 1) {
//            self.imgAddress = [JSON objectForKey:@"param"][@"url"];
//            NLog(@"image url:%@", self.imgAddress);
//            [SVProgressHUD showSuccessWithStatus:@"图片上传成功"];
//            [SVProgressHUD dismissWithDelay:1.5f];
//        } else {
//            [SVProgressHUD dismiss];
//            [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
//            [SVProgressHUD dismissWithDelay:1.0f];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//#if defined(DEBUG)||defined(_DEBUG)
//         [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"网络错误:%ld", error.code]];
//         [SVProgressHUD dismissWithDelay:1.0f];
//#endif
//         NLog(@"请求失败:%@", error.description);
//     }];
}

/** 创建社区活动 */
- (void)createActivity {
    if (self.imgAddress.length <= 0) {
        [SVProgressHUD showInfoWithStatus:@"上传一张活动封面吧"];
        [SVProgressHUD dismissWithDelay:1.f];
        return;
    }
    if (self.titleTextField.text.length <= 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入活动名称"];
        [SVProgressHUD dismissWithDelay:1.f];
        return;
    }
    if (self.contentTextView.text.length <= 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入活动简介"];
        [SVProgressHUD dismissWithDelay:1.f];
        return;
    }
    
    // 1、创建网络请求管理对象
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    // 2、封装请求参数
//    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
//    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
//    parames[@"account"]  =  [userdefaults objectForKey:@"account"];
//    parames[@"token"] = [userdefaults objectForKey:@"token"];
//    parames[@"comNo"] = [userdefaults objectForKey:@"comNo"];
//    parames[@"imgAddress"] = self.imgAddress;
//    parames[@"title"] = self.titleTextField.text;
//    parames[@"content"] = self.contentTextView.text;
//    NLog(@"parames:%@", parames);
//    
//    // 3、发送请求URL
//    WS(weakSelf);
//    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/activity/addActivity", POSTURL];
//    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NLog(@"请求成功JSON:%@", JSON);
//        if ([[JSON objectForKey:@"success"] integerValue] == 1) {
//            [weakSelf.view addSubview:self->popUP];
//        } else {
//            [SVProgressHUD showErrorWithStatus:[JSON objectForKey:@"error"]];
//            [SVProgressHUD dismissWithDelay:2.0f];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//#if defined(DEBUG)||defined(_DEBUG)
//        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"网络错误:%ld", error.code]];
//        [SVProgressHUD dismissWithDelay:1.0f];
//#endif
//        NLog(@"请求失败:%@", error.description);
//    }];
}

- (void)closeBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
