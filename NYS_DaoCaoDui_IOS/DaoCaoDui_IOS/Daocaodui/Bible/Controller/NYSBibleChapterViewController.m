//
//  NYSBibleChapterViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/19.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSBibleChapterViewController.h"
#import "NYSBibleBookCollectionViewCell.h"

@interface NYSBibleChapterViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSourcesArray;

@end

@implementation NYSBibleChapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self OnoDecodeXML1];
    [self initUI];
}

/// 解析BibleData
- (void)OnoDecodeXML {
    NLog(@"%@", self.bookString);
    NSError *error = nil;
    ONOXMLDocument *bookDocument = [ONOXMLDocument XMLDocumentWithString:self.bookString encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NLog(@"[Error] %@", error);
        return;
    }
    NLog(@"%@", [bookDocument.rootElement.children firstObject]);
    
    NSMutableArray *chapters = [NSMutableArray array];
    for (ONOXMLElement *element in bookDocument.rootElement.children) {
        if ([element.tag isEqualToString:@"c"]) {
            [chapters addObject:@{@"chapterNumber":element.attributes[@"n"],
                                  @"chapter":element}];
        }
    }
    NLog(@"%@", [self.dataSourcesArray firstObject]);
    self.dataSourcesArray = chapters;
}

- (void)OnoDecodeXML1 {
    NSError *error = nil;
    NSString *XMLFilePath = [[NSBundle mainBundle] pathForResource:@"zh_cuv" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:XMLFilePath];
    ONOXMLDocument *bibleDocument = [ONOXMLDocument XMLDocumentWithData:data error:&error];
    if (error) {
        NLog(@"[Error] %@", error);
        return;
    }
    
    NSString *XPath = @"//b";
    __block ONOXMLElement *bookDocument = nil;
    [bibleDocument enumerateElementsWithXPath:XPath usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
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
    NLog(@"%@", [self.dataSourcesArray firstObject]);
    NLog(@"Second element: %@", [[bookDocument tag] stringByTrim]);
    
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
//    NYSBibleChapterViewController *chapterVC = NYSBibleChapterViewController.new;
//    chapterVC.title = [self.dataSourcesArray[indexPath.row] objectForKey:@"subtitle"];
//
//    [self.navigationController pushViewController:chapterVC animated:YES];
}


@end
