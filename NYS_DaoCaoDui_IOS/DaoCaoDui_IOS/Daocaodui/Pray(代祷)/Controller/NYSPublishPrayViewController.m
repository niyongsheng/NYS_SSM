//
//  NYSPublishPrayViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/25.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSPublishPrayViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "NYSUploadImageHeaderView.h"
#import "NYSPublishFooterView.h"
#import "NYSProtoclViewController.h"
#import "NYSInputTableViewCell.h"
#import "NYSContentTableViewCell.h"
#import "KHAlertPickerController.h"
#import "NYSAlert.h"
#import "KHAlertPickerController.h"
#import "NYSPrayCardInfoViewController.h"

@interface NYSPublishPrayViewController () <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NYSUploadImageHeaderView *_headerView;
    NYSPublishFooterView *_footerView;
}
@property (strong, nonatomic) UIImageView *bgimageView;
@property (strong, nonatomic) UISwitch *anonymitySwitch;

@property (strong, nonatomic) NSString *paramTitle;
@property (strong, nonatomic) NSString *paramSubTitle;
@property (strong, nonatomic) NSString *paramLink;
@property (strong, nonatomic) NSString *paramContent;
@property (strong, nonatomic) NSString *paramType;
@property (strong, nonatomic) NSString *paramIsAnonymity;
@end

@implementation NYSPublishPrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"代祷"];

    [self initUI];
}

- (void)initUI {
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, NTabBarHeight + SegmentViewHeight, 0);
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 65.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = [UIColor clearColor];
    // header
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"NYSUploadImageHeaderView" owner:self options:nil] objectAtIndex:0];
    _headerView.uploadTitle.text = @"添加代祷封面";
    _headerView.frame = CGRectMake(0, 0, NScreenWidth, 200);
    [_headerView uploadBtnForSendData:self action:@selector(selectImageSource:)];
    [self.tableView setTableHeaderView:_headerView];
    // footer
    _footerView = [[NYSPublishFooterView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, 100) withTitle:@"立即发布"];
    [_footerView publishButtonForSendData:self action:@selector(publishNow:)];
    [_footerView EULAButtonForSendData:self action:@selector(EULAClicked:)];
    [self.tableView setTableFooterView:_footerView];
    
    [self.view addSubview:self.bgimageView];
    [self.view addSubview:self.tableView];
}

#pragma mark - lazy load
- (UIImageView *)bgimageView {
    if (!_bgimageView) {
        _bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight)];
        _bgimageView.contentMode = UIViewContentModeScaleToFill;
        _bgimageView.image = [UIImage imageWithColor:[UIColor whiteColor]];
        // Blur effect
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, 0, _bgimageView.frame.size.width, _bgimageView.frame.size.height);
        [_bgimageView addSubview:effectView];
    }
    return _bgimageView;
}

- (UISwitch *)anonymitySwitch {
    if (!_anonymitySwitch) {
        _anonymitySwitch = [[UISwitch alloc] init];
        [_anonymitySwitch setOn:NO];
        [_anonymitySwitch setOnTintColor:NNavBgColorShallow];
        [_anonymitySwitch addTarget:self action:@selector(anonymitySwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _anonymitySwitch;
}

- (void)anonymitySwitchChanged:(UISwitch *)sender {
    self.paramIsAnonymity = sender.on ? @"true" : @"false";
}

#pragma mark —- tableviewdDelegate —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
       
    if (indexPath.row == 0) {
        NYSInputTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"NYSInputTableViewCell"];
        if(titleCell == nil) {
            titleCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSInputTableViewCell" owner:self options:nil] firstObject];
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"*标题："];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:NNavBgColor} range:NSMakeRange(0, 1)];
        titleCell.title.attributedText = attrStr;
        titleCell.content.placeholder = @"请输入代祷的标题";
        return titleCell;
    } else if (indexPath.row == 1) {
        NYSInputTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"NYSInputTableViewCell"];
        if(titleCell == nil) {
            titleCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSInputTableViewCell" owner:self options:nil] firstObject];
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"*副标题："];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:NNavBgColor} range:NSMakeRange(0, 1)];
        titleCell.title.attributedText = attrStr;
        titleCell.content.placeholder = @"请输入代祷的副标题";
        return titleCell;
    } else if (indexPath.row == 2) {
        NYSInputTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"NYSInputTableViewCell"];
        if(titleCell == nil) {
            titleCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSInputTableViewCell" owner:self options:nil] firstObject];
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"*链接："];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:[[UIColor darkGrayColor] colorWithAlphaComponent:0.4f]} range:NSMakeRange(0, 1)];
        titleCell.title.attributedText = attrStr;
        titleCell.content.placeholder = @"请输入代祷的链接";
        return titleCell;
    } else if (indexPath.row == 3) {
        NYSContentTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"NYSContentTableViewCell"];
        if(contentCell == nil) {
            contentCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSContentTableViewCell" owner:self options:nil] firstObject];
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"*代祷内容："];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:NNavBgColor} range:NSMakeRange(0, 1)];
        contentCell.title.attributedText = attrStr;
        contentCell.placeholderStr = @"请输入你要代祷的内容";
        return contentCell;
    } else if (indexPath.row == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        }
        NSDictionary *attributeDict = @{NSForegroundColorAttributeName: NNavBgColor};
        NSString *textStr = @"*代祷类型：";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:textStr];
        NSRange range = [textStr rangeOfString:@"*"];
        [attrStr setAttributes:attributeDict range:range];
        cell.textLabel.attributedText = attrStr;
        cell.detailTextLabel.textColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4f];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (indexPath.row == 5) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"*是否匿名："];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:NNavBgColor} range:NSMakeRange(0, 1)];
        cell.textLabel.attributedText = attrStr;
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryView = self.anonymitySwitch;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

/// 避免循环引用cell nil监听cell划出屏幕时的数据处理
- (void)tableView:(UITableView*)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            self.paramTitle = [[(NYSInputTableViewCell *)cell content] text];
            break;
            
        case 1:
            self.paramSubTitle = [[(NYSInputTableViewCell *)cell content] text];
            break;
            
        case 2:
            self.paramLink = [[(NYSInputTableViewCell *)cell content] text];
            break;
            
        case 3:
            self.paramContent = [[(NYSContentTableViewCell *)cell contentTextView] text];
            break;
            
        case 4: {
            NSString *type = [[(UITableViewCell *)cell detailTextLabel] text];
            if ([type isEqualToString:@"普通代祷"]) {
                self.paramType = @"1";
            } else if ([type isEqualToString:@"紧急代祷"]) {
                self.paramType = @"2";
            }  else {
                self.paramType = @"";
            }
        }
            break;
            
        case 5:
            self.paramIsAnonymity = self.anonymitySwitch.on ? @"true" : @"false";
            break;
            
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 4) {
        KHAlertPickerController *alertPicker = [KHAlertPickerController  alertPickerWithTitle:@"分享类型" Separator:nil SourceArr:@[@"普通代祷", @"紧急代祷"]];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = [alertPicker.contentStr copy];
            [cell reloadInputViews]; // 不要使用reloadRowsAtIndexPaths刷新cell
        }];
        [alertPicker addCompletionAction:sureAction];
        [self presentViewController:alertPicker animated:YES completion:nil];
    }
}

/// 图片选择方法
- (void)selectImageSource:(UIButton *)sender {
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
    _headerView.bgImage = image;
    self.bgimageView.image = image;
    [self.view layoutIfNeeded];
    [self.view updateConstraints];
}

#pragma mark - 立即发布
- (void)publishNow:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
    
    NYSInputTableViewCell *titleCell = (NYSInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    titleCell ? self.paramTitle = titleCell.content.text : nil;
    NYSInputTableViewCell *subtitleCell = (NYSInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    subtitleCell ? self.paramSubTitle = subtitleCell.content.text : nil;
    NYSInputTableViewCell *linkCell = (NYSInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    linkCell ? self.paramLink = linkCell.content.text : nil;
    NYSContentTableViewCell *contentCell = (NYSContentTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    contentCell ? self.paramContent = contentCell.contentTextView.text : nil;
    UITableViewCell *typeCell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    NSString *type = nil;
    typeCell ? type = typeCell.detailTextLabel.text : nil;
    if ([type isEqualToString:@"普通代祷"]) {
        self.paramType = @"1";
    } else if ([type isEqualToString:@"紧急代祷"]) {
        self.paramType = @"2";
    } else {
        self.paramType = @"";
    }
    UITableViewCell *anonymityCell = (NYSInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    anonymityCell ? self.paramIsAnonymity = (self.anonymitySwitch.on ? @"true" : @"false") : nil;
    
    WS(weakSelf);
    [NYSRequest PublishPrayWithImage:self.bgimageView.image
                                  name:@"iconImage"
                            parameters:@{@"title" : _paramTitle,
                                         @"subTitle" : _paramSubTitle,
                                         @"prayUrl" : _paramLink,
                                         @"content" : _paramContent,
                                         @"prayType" : _paramType,
                                         @"anonymity" : _paramIsAnonymity,
                                         @"fellowship" : @(NCurrentUser.fellowship)}
                               process:^(NSProgress *progress) {
        
    } success:^(id response) {
        if ([[response objectForKey:@"status"] boolValue]) {
            [NYSAlert showSuccessAlertWithTitle:@"发布代祷" message:@"发布成功，快去刷新看看吧❤️" okButtonClickedBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    } failure:^(NSError *error) {
        
    }];
}

/// 用户许可协议
- (void)EULAClicked:(UIButton *)sender {
    NYSProtoclViewController *protoclVC = NYSProtoclViewController.new;
    protoclVC.protoclPDFFileName = @"PublishEULA";
    protoclVC.title = @"许可协议";
    [self.navigationController pushViewController:protoclVC animated:YES];
}

@end
