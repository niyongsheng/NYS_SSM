//
//  NYSBibleChapterViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/19.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSBibleChapterViewController.h"
#import "NYSBibleBookCollectionViewCell.h"
#import "NYSBibleVerseViewController.h"

@interface NYSBibleChapterViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSourcesArray;

@end

@implementation NYSBibleChapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self OnoDecodeXML];
    [self initUI];
}

/// 解析BibleData
- (void)OnoDecodeXML {
    NSString *XPath = @"//b";
    __block ONOXMLElement *bookDocument = nil;
    [NBibleManager.currentbible enumerateElementsWithXPath:XPath usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        *stop = idx == self.bookNumber;
        if (*stop) {
            bookDocument = element;
        }
    }];
    NSMutableArray *chapters = [NSMutableArray array];
    for (ONOXMLElement *element in bookDocument.children) {
        [chapters addObject:@{@"chapterNumber":element.attributes[@"n"],
                              @"chapter":element}];
    }
    self.dataSourcesArray = chapters;
//    NLog(@"%@", [self.dataSourcesArray firstObject]);
}

#pragma mark — collection init
- (void)initUI {
    static float Magin = 10;
    int count = 5;
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (NScreenWidth - 15 - count * Magin) / count;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(Magin, Magin, Magin, Magin);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NYSBibleBookCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NYSBibleBookCollectionViewCell"];
    self.collectionView.mj_header.hidden = YES;
    self.collectionView.mj_footer.hidden = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, NTabBarHeight, 0);
    [self.view addSubview:self.collectionView];
}

#pragma mark — UICollectionViewDatasourcesDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourcesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NYSBibleBookCollectionViewCell *cell = (NYSBibleBookCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"NYSBibleBookCollectionViewCell" forIndexPath:indexPath];
    cell.bgColor = self.bgColor;
    cell.titleString = [self.dataSourcesArray[indexPath.row] objectForKey:@"chapterNumber"];
    cell.subtitleString = nil;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NYSBibleVerseViewController *verseVC = NYSBibleVerseViewController.new;
    verseVC.title = [NSString stringWithFormat:@"%@ %@", self.title, [self.dataSourcesArray[indexPath.row] objectForKey:@"chapterNumber"]];
    verseVC.bookNumber = self.bookNumber;
    verseVC.chapterNumber = [self.dataSourcesArray[indexPath.row][@"chapterNumber"] integerValue];
    verseVC.chapter = self.dataSourcesArray[indexPath.row][@"chapter"];
    [self.navigationController pushViewController:verseVC animated:YES];
}


@end
