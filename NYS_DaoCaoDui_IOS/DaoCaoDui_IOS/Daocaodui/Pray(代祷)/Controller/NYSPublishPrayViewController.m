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
#import "NYSButtonFooterView.h"
#import "NYSInputTableViewCell.h"
#import "NYSContentTableViewCell.h"

@interface NYSPublishPrayViewController () <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NYSUploadImageHeaderView *_headerView;
    NYSButtonFooterView *_footerView;
}
@property (strong, nonatomic) UIImageView *bgimageView;
@property (strong, nonatomic) UISwitch *anonymitySwitch;
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
    _footerView = [[NYSButtonFooterView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, 100) withTitle:@"立即发布"];
    [_footerView buttonForSendData:self action:@selector(publishNow:)];
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
//        _bgimageView.image = [UIImage imageNamed:@"1"];
        // Blur
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

#pragma mark —- tableviewdDelegate —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
       
    if (indexPath.row == 0) {
        NYSInputTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"NYSInputTableViewCell"];
        if(titleCell == nil) {
            titleCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSInputTableViewCell" owner:self options:nil] firstObject];
        }
        titleCell.title.text = @"标题：";
        titleCell.content.placeholder = @"请输入代祷的标题";
        return titleCell;
    } else if (indexPath.row == 1) {
        NYSInputTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"NYSInputTableViewCell"];
        if(titleCell == nil) {
            titleCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSInputTableViewCell" owner:self options:nil] firstObject];
        }
        titleCell.title.text = @"副标题：";
        titleCell.content.placeholder = @"请输入代祷的副标题";
        return titleCell;
    } else if (indexPath.row == 2) {
        NYSInputTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"NYSInputTableViewCell"];
        if(titleCell == nil) {
            titleCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSInputTableViewCell" owner:self options:nil] firstObject];
        }
        titleCell.title.text = @"作者：";
        titleCell.content.placeholder = @"请输入代祷的作者";
        return titleCell;
    } else if (indexPath.row == 3) {
        NYSContentTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"NYSContentTableViewCell"];
        if(contentCell == nil) {
            contentCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSContentTableViewCell" owner:self options:nil] firstObject];
        }
        contentCell.title.text = @"代祷内容：";
        contentCell.placeholderStr = @"请输入你要代祷的内容";
        return contentCell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = @"是否匿名：";
        cell.accessoryView = self.anonymitySwitch;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    
    // 上传服务器
//    [NYSRequest UploadImagesWithImages:@[image] fileNames:nil parameters:@{@"fellowship":[NSString stringWithFormat:@"%ld", (long)[NCurrentUser fellowship]]} process:^(NSProgress *uploadProcess) {
//
//    } success:^(id response) {
//        [self updateUserInfo:@{@"icon":[[response[@"data"] firstObject] objectForKey:@"qiniuURL"]}];
//    } failure:^(NSError *error) {
//
//    }];
}

#pragma mark - 立即发布
- (void)publishNow:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
    NYSInputTableViewCell *cell = (NYSInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *params1 = cell.content.text;
}

@end
