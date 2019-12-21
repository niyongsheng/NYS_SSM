//
//  NYSTodayItemView.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/12.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSTodayItemView.h"
#import <PYSearchViewController.h>
#import "NYSBaseNavigationController.h"
#import "NYSRootViewController.h"

@interface NYSTodayItemView ()
@property (weak, nonatomic) IBOutlet UIView *myCustomView;

@end
@implementation NYSTodayItemView
@synthesize myCustomView;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code.
        [[NSBundle mainBundle] loadNibNamed:@"NYSTodayItemView" owner:self options:nil];
        [self addSubview:self.myCustomView];
    }
    return self;
}
 
- (void)awakeFromNib {
    [super awakeFromNib];
    
    myCustomView.layer.cornerRadius = 10;
    myCustomView.clipsToBounds = YES;
    
    self.layer.cornerRadius = 10;
//    self.clipsToBounds = YES;
    
    // 添加边框
//    CALayer *layer = [myCustomView layer];
//    layer.borderColor = [UIColor grayColor].CGColor;
//    layer.borderWidth = 1.0f;

    // 添加四个边阴影
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 5.0f;
    
    [self addSubview:self.myCustomView];
}


- (IBAction)item1Clicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];

    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches
                                                                                          searchBarPlaceholder:@"你找啥？"
                                                                                                didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        [searchViewController.navigationController pushViewController:[[NYSRootViewController alloc] init] animated:YES];
    }];
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleARCBorderTag;
//    searchViewController.delegate = self.fromController;
    NYSBaseNavigationController *nav = [[NYSBaseNavigationController alloc] initWithRootViewController:searchViewController];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.fromController presentViewController:nav animated:YES completion:nil];
}
- (IBAction)item2Clicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
}
- (IBAction)item3Clicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
}
- (IBAction)item4Clicked:(UIButton *)sender {
    [NYSTools zoomToShow:sender];
}

@end
