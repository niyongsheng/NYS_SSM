//
//  NYSPublishMusicViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/25.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSPublishMusicViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "KHAlertPickerController.h"
#import "NYSUploadImageHeaderView.h"
#import "NYSPublishFooterView.h"
#import "NYSProtoclViewController.h"
#import "NYSInputTableViewCell.h"
#import "NYSMusicMenuModel.h"
#import "NYSAlert.h"
#import "KHAlertPickerController.h"
#import "NYSDocumentBrowserViewController.h"

@interface NYSPublishMusicViewController () <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NYSUploadImageHeaderView *_headerView;
    NYSPublishFooterView *_footerView;
}
@property (strong, nonatomic) UIImageView *bgimageView;
@property (strong, nonatomic) NSArray *musicTypeArray;

@property (strong, nonatomic) NSString *paramTitle;
@property (strong, nonatomic) NSString *paramSinger;
@property (strong, nonatomic) NSString *paramWordAuthor;
@property (strong, nonatomic) NSString *paramAnAuthor;
@property (strong, nonatomic) NSData *paramAudioData;
@property (strong, nonatomic) NSData *paramFileData;
@property (strong, nonatomic) NSString *audioName;
@property (strong, nonatomic) NSString *fileName;
@end

@implementation NYSPublishMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"音频"];

    // 加载音频类型
    WS(weakSelf);
    [NYSRequest GetMusicMenuList:GET parameters:@{@"fellowship" : @(NCurrentUser.fellowship)} success:^(id response) {
        [NYSMusicMenuModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        weakSelf.musicTypeArray = [NYSMusicMenuModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
    } failure:nil isCache:YES];
    
    // 初始化UI
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
    _headerView.uploadTitle.text = @"添加音频封面";
    _headerView.frame = CGRectMake(0, 0, NScreenWidth, 200);
    [_headerView uploadBtnForSendData:self action:@selector(selectImageSource:)];
    [self.tableView setTableHeaderView:_headerView];
    // footer
    _footerView = [[NYSPublishFooterView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, 100) withTitle:@"立即上传"];
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

#pragma mark —- tableviewdDelegate —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
       
    if (indexPath.row == 0) {
        NYSInputTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"NYSInputTableViewCell"];
        if(titleCell == nil) {
            titleCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSInputTableViewCell" owner:self options:nil] firstObject];
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"*标题："];
        [attrStr setAttributes:@{NSForegroundColorAttributeName: NNavBgColor} range:NSMakeRange(0, 1)];
        titleCell.title.attributedText = attrStr;
        titleCell.content.placeholder = @"请输入音频的标题";
        return titleCell;
    } else if (indexPath.row == 1) {
        NYSInputTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"NYSInputTableViewCell"];
        if(titleCell == nil) {
            titleCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSInputTableViewCell" owner:self options:nil] firstObject];
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"*歌手："];
        [attrStr setAttributes:@{NSForegroundColorAttributeName: NNavBgColor} range:NSMakeRange(0, 1)];
        titleCell.title.attributedText = attrStr;
        titleCell.content.placeholder = @"请输入音频的歌手";
        return titleCell;
    } else if (indexPath.row == 2) {
        NYSInputTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"NYSInputTableViewCell"];
        if(titleCell == nil) {
            titleCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSInputTableViewCell" owner:self options:nil] firstObject];
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"*词作者："];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:[[UIColor darkGrayColor] colorWithAlphaComponent:0.4f]} range:NSMakeRange(0, 1)];
        titleCell.title.attributedText = attrStr;
        titleCell.content.placeholder = @"请输入音频的词作者";
        return titleCell;
    } else if (indexPath.row == 3) {
        NYSInputTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"NYSInputTableViewCell"];
        if(titleCell == nil) {
            titleCell = [[[NSBundle mainBundle] loadNibNamed:@"NYSInputTableViewCell" owner:self options:nil] firstObject];
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"*曲作者："];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:[[UIColor darkGrayColor] colorWithAlphaComponent:0.4f]} range:NSMakeRange(0, 1)];
        titleCell.title.attributedText = attrStr;
        titleCell.content.placeholder = @"请输入音频的曲作者";
        return titleCell;
    } else if (indexPath.row == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"*音频文件："];
        [attrStr setAttributes:@{NSForegroundColorAttributeName: NNavBgColor} range:NSMakeRange(0, 1)];
        cell.textLabel.attributedText = attrStr;
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (indexPath.row == 5) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"*歌词文件："];
        [attrStr setAttributes:@{NSForegroundColorAttributeName:[[UIColor darkGrayColor] colorWithAlphaComponent:0.4f]} range:NSMakeRange(0, 1)];
        cell.textLabel.attributedText = attrStr;
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (indexPath.row == 6) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        }
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"*音频类型："];
        [attrStr setAttributes:@{NSForegroundColorAttributeName: NNavBgColor} range:NSMakeRange(0, 1)];
        cell.textLabel.attributedText = attrStr;
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WS(weakSelf);
    if (indexPath.row == 4) {
        NYSDocumentBrowserViewController *audioBrowserVC = [NYSDocumentBrowserViewController new];
        audioBrowserVC.callBack = ^(NSData *contentsData, NSArray *fileType, NSString *fileName, NSURL *fileURL) {
            NLog(@"%@ \nType:%@   \nName:%@   \nURL:%@",contentsData, fileType, fileName, fileURL);
            weakSelf.paramAudioData = contentsData;
            weakSelf.audioName = [NSString stringWithFormat:@"%@.%@", fileName, fileType[2]];
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = weakSelf.audioName;
            [cell reloadInputViews];
        };
        [self presentViewController:audioBrowserVC animated:YES completion:nil];
    } else if (indexPath.row == 5) {
        NYSDocumentBrowserViewController *fileBrowserVC = [NYSDocumentBrowserViewController new];
        fileBrowserVC.callBack = ^(NSData *contentsData, NSArray *fileType, NSString *fileName, NSURL *fileURL) {
            NLog(@"%@ \nType:%@   \nName:%@   \nURL:%@",contentsData, fileType, fileName, fileURL);
            weakSelf.paramFileData = contentsData;
            weakSelf.fileName = [NSString stringWithFormat:@"%@.%@", fileName, fileType[2]];
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = weakSelf.fileName;
            [cell reloadInputViews];
        };
        [self presentViewController:fileBrowserVC animated:YES completion:nil];
    } else if (indexPath.row == 6) {
        NSMutableArray *titleArray = [NSMutableArray array];
        for (NYSMusicMenuModel *musicMenu in self.musicTypeArray) {
            [titleArray addObject:musicMenu.name];
        }
        KHAlertPickerController *alertPicker = [KHAlertPickerController  alertPickerWithTitle:@"音频类型" Separator:nil SourceArr:titleArray];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = [alertPicker.contentStr copy];
            [cell reloadInputViews];
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
    self.paramTitle = titleCell.content.text;
    NYSInputTableViewCell *singerCell = (NYSInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    self.paramSinger = singerCell.content.text;
    NYSInputTableViewCell *wordCell = (NYSInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    self.paramWordAuthor = wordCell.content.text;
    NYSInputTableViewCell *anCell = (NYSInputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    self.paramAnAuthor = anCell.content.text;
    // 音频类型
    NSString *musicType = @"";
    UITableViewCell *musicTypeCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    NSString *musicTypeName = musicTypeCell.detailTextLabel.text;
    for (NYSMusicMenuModel *musicMenu in self.musicTypeArray) {
        if ([musicMenu.name isEqualToString:musicTypeName]) {
            musicType = [NSString stringWithFormat:@"%ld", musicMenu.idField];
            break;
        }
    }
    WS(weakSelf);
    [NYSRequest PublishMusicWithImage:self.bgimageView.image
                            imageName:@"iconImage"
                        audioFileData:_paramAudioData
                       audioParamName:@"musicFile"
                            audioName:_audioName
                             fileData:_paramFileData
                        fileParamName:@"lyricFile"
                             fileName:_fileName
                           parameters:@{@"name" : _paramTitle,
                                        @"singer" : _paramSinger,
                                        @"wordAuthor" : _paramWordAuthor,
                                        @"anAuthor" : _paramAnAuthor,
                                        @"musicType" : musicType,
                                        @"fellowship" : @(NCurrentUser.fellowship)}
                              process:^(NSProgress *progress) {
        
    } success:^(id response) {
        if ([[response objectForKey:@"status"] boolValue]) {
            [NYSAlert showSuccessAlertWithTitle:@"上传音频" message:@"上传成功，快去刷新试听吧🎵" okButtonClickedBlock:^{
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
