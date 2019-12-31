//
//  NYSDocumentBrowserViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/30.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSDocumentBrowserViewController.h"

#pragma mark---------------------------------Document------------------------------------
@interface Document : UIDocument//UIDocument是IOS的文档类 它是一个虚拟基类,要使用它必须继承它.

@end

@implementation Document

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)errorPtr {
    // Load your document from contents
    //获取文件的data数据
    //[NSData dataWithData:contents];
    return YES;
}

@end

#pragma mark-------------------------DocumentBrowserViewController-----------------------------
@interface NYSDocumentBrowserViewController () <UIDocumentBrowserViewControllerDelegate>

@end

@implementation NYSDocumentBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.allowsDocumentCreation = NO;//不让文件管理器创建新文件
    self.allowsPickingMultipleItems = NO;//不让多点选择
    
    // Update the style of the UIDocumentBrowserViewController
    // 背景颜色
    self.browserUserInterfaceStyle = UIDocumentBrowserUserInterfaceStyleLight;
    // 底色
    self.view.tintColor = [UIColor redColor];
    
    
    // Specify the allowed content types of your application via the Info.plist.
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // 添加一个取消按钮
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.additionalLeadingNavigationBarButtonItems = @[buttonItem];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark UIDocumentBrowserViewControllerDelegate

-(void)documentBrowser:(UIDocumentBrowserViewController *)controller didPickDocumentURLs:(NSArray<NSURL *> *)documentURLs {
    NSURL *sourceURL = documentURLs.firstObject;
    if (!sourceURL) {
        return;
    }
    
    // Present the Document View Controller for the first document that was picked.
    // If you support picking multiple items, make sure you handle them all.
    [self presentDocumentAtURL:sourceURL];
}

// MARK: Document Presentation

- (void)presentDocumentAtURL:(NSURL *)documentURL {
    // 调用Document
    Document *docu = [[Document alloc] initWithFileURL:documentURL];
    // 开启
    [docu openWithCompletionHandler:^(BOOL success) {
        if (success) {
            /*
            NSLog(@"--%@---",docu.fileURL);
            NSLog(@"--%@---",docu.localizedName);
            NSLog(@"--%@---",docu.fileType);
            NSLog(@"--%@---",docu.fileModificationDate);
            NSLog(@"--%lu---",(unsigned long)docu.documentState);
            NSLog(@"--%@---",docu.progress);
            NSLog(@"--%@---",[NSData dataWithContentsOfURL:docu.fileURL]);
             */
            // 关闭
            [docu closeWithCompletionHandler:^(BOOL success) {

                self.callBack([NSData dataWithContentsOfURL:docu.fileURL], [NYSFileType fieldType:docu.fileURL], docu.localizedName, docu.fileURL);

                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
