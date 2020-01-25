//
//  NYSSettingViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/20.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSSettingViewController.h"
#import <RongIMKit/RongIMKit.h>

@interface NYSSettingViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *datasourceArray;
/// 是否允许通知
@property (nonatomic, assign) BOOL isEnableNotification;
/// 切换中英文圣经版本
@property (nonatomic, strong) UISwitch *bibleEnSwitch;
/// 调整圣经字号大小
@property (nonatomic, strong) UISlider *bibleFontSizeSlider;
@end

@implementation NYSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"设置"];
    
    [self initUI];
}

#pragma mark -- initUI --
- (void)initUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, NScreenWidth, NScreenHeight - NTopHeight) style:UITableViewStyleGrouped];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark —- tableview delegate —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 15.f;
            
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            BOOL addLine = NO;
            
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:1.f].CGColor;
            layer.shadowColor = [UIColor grayColor].CGColor;
            layer.shadowOffset = CGSizeZero;
            layer.shadowOpacity = 0.15f;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-20, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                // 分割线
                NO ? [layer addSublayer:lineLayer] : nil;
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    cell.textLabel.textColor = NNavBgColor;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                cell.textLabel.text = @"清理网络缓存";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"当前网络缓存大小:%.2fKB", [PPNetworkCache getAllHttpCacheSize]/1024.f];
            }
                break;
                
            case 1: {
                cell.textLabel.text = @"清理聊天缓存";
            }
                break;
                
            case 2: {
                cell.textLabel.text = @"重置所有设置";
            }
                break;
                
            case 3: {
                cell.textLabel.text = @"允许通知";
                cell.accessoryType = self.isIsEnableNotification ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            }
                break;
                
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0: {
                cell.textLabel.text = @"使用KJV英文版圣经";
                cell.accessoryView = self.bibleEnSwitch;
            }
                break;
                
            case 1: {
                cell.textLabel.text = @"字体大小";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"当前字号:%.2f", self.bibleFontSizeSlider.value];
                cell.accessoryView = self.bibleFontSizeSlider;
            }
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                [PPNetworkCache removeAllHttpCache];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
                break;
                
            case 1: {
                [[RCIM sharedRCIM] clearUserInfoCache];
                [[RCIM sharedRCIM] clearGroupInfoCache];
                [[RCIM sharedRCIM] clearGroupUserInfoCache];
            }
                break;
                
            case 2: {
                [self loadDefaultAllSettingWarningAlert];
            }
                break;
                
            case 3: {
                self.isEnableNotification = !self.isEnableNotification;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
                break;
                
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0: {
                
            }
                break;
                
            case 1: {
                
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - UI widget lazy load
- (BOOL)isIsEnableNotification {
    if (!_isEnableNotification) {
        BOOL ien = [NUserDefaults boolForKey:SettingKey_IsEnableNotification];
        
        _isEnableNotification = ien;
    }
    return _isEnableNotification;
}

- (void)setIsEnableNotification:(BOOL)isEnableNotification {
    _isEnableNotification = isEnableNotification;
    
    [NUserDefaults setBool:isEnableNotification forKey:SettingKey_IsEnableNotification];
    [NUserDefaults synchronize];
}

- (UISwitch *)bibleEnSwitch {
    if (!_bibleEnSwitch) {
        _bibleEnSwitch = [[UISwitch alloc] init];
        [_bibleEnSwitch setOn:[NUserDefaults boolForKey:SettingKey_IsEnBible]];
        [_bibleEnSwitch setOnTintColor:NNavBgColorShallow];
        [_bibleEnSwitch addTarget:self action:@selector(bibleEnSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _bibleEnSwitch;
}

- (UISlider *)bibleFontSizeSlider {
    if (!_bibleFontSizeSlider) {
        _bibleFontSizeSlider = [[UISlider alloc] init];
        [_bibleFontSizeSlider setMinimumTrackTintColor:NNavBgColorShallow];
        [_bibleFontSizeSlider setMinimumValue:10.f];
        [_bibleFontSizeSlider setMaximumValue:50.f];
        [_bibleFontSizeSlider addTarget:self action:@selector(_bibleFontSizeSliderChanged:) forControlEvents:UIControlEventValueChanged];
        
        CGFloat bibleFontSize = [NUserDefaults floatForKey:SettingKey_BibleFontSize];
        CGFloat bfz = bibleFontSize ? bibleFontSize : Settingdefault_BibleFontSize;
        [_bibleFontSizeSlider setValue:bfz animated:YES];
    }
    return _bibleFontSizeSlider;
}

#pragma mark - UI widget event deal
- (void)bibleEnSwitchChanged:(UISwitch *)sender {
    [NUserDefaults setBool:sender.on forKey:SettingKey_IsEnBible];
    [NUserDefaults synchronize];
    [NBibleManager refreshCurrentBible];
}

- (void)_bibleFontSizeSliderChanged:(UISlider *)sender {
    [NUserDefaults setFloat:sender.value forKey:SettingKey_BibleFontSize];
    [NUserDefaults synchronize];
    [self.tableView reloadData];
}

/// 重置所有设置
- (void)loadDefaultAllSetting {
    // 响应界面
    [self.bibleEnSwitch setOn:NO animated:YES];
    [self.bibleFontSizeSlider setValue:Settingdefault_BibleFontSize animated:YES];
    self.isEnableNotification = YES;
    
    // 持久化数据
    [NUserDefaults setBool:NO forKey:SettingKey_IsEnBible];
    [NUserDefaults setFloat:Settingdefault_BibleFontSize forKey:SettingKey_BibleFontSize];
    [NUserDefaults synchronize];
    
    // 发送bible版本变更通知
    [NBibleManager refreshCurrentBible];

    // 刷新cell
    WS(weakSelf);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
    });
}

#pragma mark - ⚠️WARNING Alert
- (void)loadDefaultAllSettingWarningAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要重置所有设置吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"重置" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self loadDefaultAllSetting];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NLog(@"Cancel Action");
    }];
    
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
