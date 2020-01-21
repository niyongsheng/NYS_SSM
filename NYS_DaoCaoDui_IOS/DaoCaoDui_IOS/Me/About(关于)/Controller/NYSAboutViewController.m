//
//  NYSAboutViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/20.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSAboutViewController.h"
#import <StoreKit/StoreKit.h>
#import <SafariServices/SafariServices.h>
#import "NYSAboutHeaderView.h"
#import "NYSAboutFooterView.h"

#import "NYSConversationViewController.h"
#import "NYSProtoclViewController.h"

@interface NYSAboutViewController () <UITableViewDelegate, UITableViewDataSource, SKStoreProductViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *datasourceArray;
@property (nonatomic, strong) NYSAboutHeaderView *headerView;
@property (nonatomic, strong) NYSAboutFooterView *footerView;
@end

@implementation NYSAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"关于"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(aboutItemClicked:)];
    
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
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"NYSAboutHeaderView" owner:self options:nil] objectAtIndex:0];
    _headerView.frame = CGRectMake(0, 0, NScreenWidth, 200);
    [self.tableView setTableHeaderView:_headerView];
    
    _footerView = [[[NSBundle mainBundle] loadNibNamed:@"NYSAboutFooterView" owner:self options:nil] objectAtIndex:0];
    _footerView.frame = CGRectMake(0, 0, NScreenWidth, 70);
    [self.tableView setTableFooterView:_footerView];
    
    [self.view addSubview:self.tableView];
}

#pragma mark —- tableview delegate —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        if (tableView == self.tableView) {
            // 圆角尺寸
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
//                [layer addSublayer:lineLayer];
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                cell.textLabel.text = @"评分";
            }
                break;
                
            case 1: {
                cell.textLabel.text = @"版本更新";
            }
                break;
                
            case 2: {
                cell.textLabel.text = @"联系开发者";
                cell.detailTextLabel.text = @"commit bug/issues";
            }
                break;
                
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0: {
                cell.textLabel.text = @"用户协议";
            }
                break;
                
            case 1: {
                cell.textLabel.text = @"API";
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
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                if (@available(iOS 10.3, *)) {
                    [SKStoreReviewController requestReview];
                } else {
                    SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:AppStoreURL]];
                    [self presentViewController:safariVc animated:YES completion:nil];
                }
            }
                break;
                
            case 1: {
                [self loadAppStoreControllerWithAppID:APPID];
            }
                break;
                
            case 2: {
                NYSConversationViewController *privateConversationVC = [[NYSConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:@"7793477"];
                privateConversationVC.title = @"Developer";
                [self.navigationController pushViewController:privateConversationVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0: {
                NYSProtoclViewController *protoclVC = NYSProtoclViewController.new;
                protoclVC.protoclPDFFileName = @"UserPrivacyAgreement";
                protoclVC.title = @"隐私协议";
                [self.navigationController pushViewController:protoclVC animated:YES];
            }
                break;
                
            case 1: {
                SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:AppAPIsURL]];
                [self presentViewController:safariVc animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    }
}

/** 加载App Store评论页 */
- (void)loadAppStoreControllerWithAppID:(NSString *)appID {
    [SVProgressHUD showWithStatus:@"Loading..."];
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    storeProductViewContorller.delegate = self;
    [storeProductViewContorller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:appID} completionBlock:^(BOOL result, NSError * _Nullable error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"Load Error"];
            [SVProgressHUD dismissWithDelay:0.5f];
            NLog(@"error %@ with userInfo %@", error, [error userInfo]);
        } else {
            [SVProgressHUD dismiss];
            [self presentViewController:storeProductViewContorller animated:YES completion:nil];
        }
    }];
}

- (void)aboutItemClicked:(id)sender {
    SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@web", AppWebSiteURL]]];
    [self presentViewController:safariVc animated:YES completion:nil];
}

#pragma mark - SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController*)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
