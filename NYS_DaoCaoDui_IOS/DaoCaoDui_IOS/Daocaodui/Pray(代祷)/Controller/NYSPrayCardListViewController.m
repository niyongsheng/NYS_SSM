//
//  NYSPrayCardListViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSPrayCardListViewController.h"
#import "CCDraggableContainer.h"
#import "NYSPrayCustomCardView.h"
#import "NYSPrayModel.h"
#import "NYSPrayCardInfoViewController.h"

@interface NYSPrayCardListViewController ()
<
CCDraggableContainerDataSource,
CCDraggableContainerDelegate
>

@property (nonatomic, weak) IBOutlet CCDraggableContainer *container;

@property (nonatomic, strong) NSMutableArray *dataSources;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UILabel *bibleLabel;

/// 记录当前cardView index
@property (assign, nonatomic) NSInteger currentIndex;
@end

@implementation NYSPrayCardListViewController

- (IBAction)reloadDataEvent:(UIButton *)sender {
    [UIView animateWithDuration:1 animations:^{
        sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        sender.imageView.transform = CGAffineTransformIdentity;
    }];

    if (self.container) {
        [self loadData];
    }
}

- (IBAction)dislikeEvent:(id)sender {
    [self.container removeForDirection:CCDraggableDirectionLeft];
}

- (IBAction)likeEvent:(id)sender {
    [self.container removeForDirection:CCDraggableDirectionRight];
    [NYSRequest prayCollectionInOrOutWithResMethod:GET
                                           parameters:@{@"prayID" : @([self.dataSources[self.currentIndex] idField])}
                                              success:^(id response) {
        if ([[response objectForKey:@"status"] boolValue]) {
            self.collectionButton.selected = !self.collectionButton.selected;
            [SVProgressHUD showSuccessWithStatus:[[response objectForKey:@"data"] objectForKey:@"info"]];
            [SVProgressHUD dismissWithDelay:1.f];
        }
    } failure:^(NSError *error) {
        
    } isCache:NO];
}

- (void)loadUI {
    // 初始化Container
    self.container.style = 1;
    self.container.delegate = self;
    self.container.dataSource = self;
    [self.view addSubview:self.container];
    
    [self.collectionButton setBackgroundImage:[UIImage imageNamed:@"liked"] forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadUI];
    [self loadData];
}

- (void)loadData {
    WS(weakSelf);
    [NYSRequest GetPrayList:GET parameters:@{@"fellowship" : @(NCurrentUser.fellowship)} success:^(id response) {
        [NYSPrayModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        weakSelf.dataSources = [NYSPrayModel mj_objectArrayWithKeyValuesArray:[response objectForKey:@"data"]];
        [weakSelf.container reloadData];
    } failure:^(NSError *error) {
        
    } isCache:YES];
}

#pragma mark - CCDraggableContainer DataSource
- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    NYSPrayCustomCardView *cardView = [[NYSPrayCustomCardView alloc] initWithFrame:draggableContainer.bounds];
    cardView.pray = self.dataSources[index];
    
    return cardView;
}

- (NSInteger)numberOfIndexs {
    return _dataSources.count;
}

#pragma mark - CCDraggableContainer Delegate
- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio currentIndex:(NSInteger)currentIndex {
    self.currentIndex = currentIndex;
    self.collectionButton.selected = [self.dataSources[currentIndex] isCollection];
    
    CGFloat scale = 1 + ((kBoundaryRatio > fabs(widthRatio) ? fabs(widthRatio) : kBoundaryRatio)) / 4;
    if (draggableDirection == CCDraggableDirectionLeft) {
        self.nextButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
    if (draggableDirection == CCDraggableDirectionRight) {
        self.collectionButton.transform = CGAffineTransformMakeScale(scale, scale);
        [NYSRequest prayCollectionInOrOutWithResMethod:GET
                                               parameters:@{@"prayID" : @([self.dataSources[currentIndex] ID])}
                                                  success:^(id response) {
            if ([[response objectForKey:@"status"] boolValue]) {
                self.collectionButton.selected = !self.collectionButton.selected;
                [SVProgressHUD showSuccessWithStatus:[[response objectForKey:@"data"] objectForKey:@"info"]];
                [SVProgressHUD dismissWithDelay:1.f];
            }
        } failure:^(NSError *error) {
            
        } isCache:NO];
    }
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    NLog(@"点击了Tag为%ld的代祷卡", (long)didSelectIndex);
    NYSPrayCardInfoViewController *prayInfoVC = NYSPrayCardInfoViewController.new;
    prayInfoVC.prayModel = self.dataSources[didSelectIndex];
    prayInfoVC.modalPresentationStyle = UIModalPresentationFullScreen;
    prayInfoVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:prayInfoVC animated:YES completion:nil];
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    [NYSTools shakToShow:self.refreshButton];
}

@end
