//
//  NYSBibleViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/19.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSBibleViewController.h"
#import <Ono/Ono.h>
#import "UIColor+NYS.h"
#import "NYSBibleBookCollectionViewCell.h"
#import "NYSBibleChapterViewController.h"

@interface NYSBibleViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSourcesArray;
@property (nonatomic, strong) NSArray *colorVolume; // 颜色区隔
@property (nonatomic, strong) NSArray *volumeColors; // 具体颜色
@end

@implementation NYSBibleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self OnoDecodeXML];
    [self initUI];
}

/// 解析BibleData
- (void)OnoDecodeXML {
    NSError *error = nil;
    NSString *XMLFilePath = [[NSBundle mainBundle] pathForResource:@"zh_cuv" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:XMLFilePath];
    ONOXMLDocument *bibleDocument = [ONOXMLDocument XMLDocumentWithData:data error:&error];
    if (error) {
        NLog(@"[Error] %@", error);
        return;
    }
    
    NSMutableArray *books = [NSMutableArray array];
    for (ONOXMLElement *element in bibleDocument.rootElement.children) {
        NSString *title = element.attributes[@"n"];
        NSString *bigTitle = element.attributes[@"id"];
        [books addObject:@{@"title":bigTitle, @"subtitle":title, @"book":[element stringValue]}];
    }
    self.dataSourcesArray = [NSMutableArray arrayWithArray:books];
    
    
/*
    NLog(@"Bible: %@", document.rootElement.tag);

    NLog(@"\n");
    NLog(@"Book Values:");
    for (ONOXMLElement *bookElement in [[document.rootElement firstChildWithTag:@"b"] children]) {
        NSString *chapterTag = bookElement.tag;
        NSString *ID = bookElement[@"v"];
        NSString *name = bookElement[@"n"];
        NLog(@"- %@ %@ %@", chapterTag, ID, name);
    }

    NLog(@"\n");
    XPath = @"//b/c/v";
    NLog(@"XPath Search: %@", XPath);
    __block ONOXMLElement *blockElement = nil;
    [document enumerateElementsWithXPath:XPath usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        *stop = idx == 1;
        if (*stop) {
            blockElement = element;
        }
    }];
    NLog(@"Second element: %@", [[blockElement tag] stringByTrim]);
 */
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
    cell.titleString = [self.dataSourcesArray[indexPath.row] objectForKey:@"title"];
    cell.subtitleString = [self.dataSourcesArray[indexPath.row] objectForKey:@"subtitle"];
    cell.bgColor = [self colorOfVolumeAtRow:indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NYSBibleChapterViewController *chapterVC = NYSBibleChapterViewController.new;
    chapterVC.title = [self.dataSourcesArray[indexPath.row] objectForKey:@"subtitle"];
    chapterVC.bgColor = [self colorOfVolumeAtRow:indexPath.row];
    chapterVC.bookString = self.dataSourcesArray[indexPath.row][@"book"];
    chapterVC.bookNumber = indexPath.row;
    [self.navigationController pushViewController:chapterVC animated:YES];
}

#pragma mark - color data
- (NSArray *)colorVolume {
    if (!_colorVolume) {
        _colorVolume = @[@0, @5, @21, @28, @34, @46, @50, @51, @64, @72];
    }
    return _colorVolume;
}

- (NSArray *)volumeColors {
    if (!_volumeColors) {
        _volumeColors = @[[UIColor emeraldColor],
                          [UIColor peterRiverColor],
                          [UIColor amethystColor],
                          [UIColor sunFlowerColor],
                          [UIColor alizarinColor],
                          [UIColor turquoiseColor],
                          [UIColor lightPurpleColor],
                          [UIColor carrotColor],
                          [UIColor lightGreenColor],
                          [UIColor lightBlueColor]];
    }
    return _volumeColors;
}

// 根据卷所在row确定其背景色
- (UIColor *)colorOfVolumeAtRow:(NSInteger)row {
    for (NSInteger i = 0; i < self.colorVolume.count - 1; i++) {
        if (row >= [self.colorVolume[i] integerValue] && row < [self.colorVolume[i+1] integerValue]) {
            return self.volumeColors[i];
        }
    }
    return [self.volumeColors lastObject];
}

@end
