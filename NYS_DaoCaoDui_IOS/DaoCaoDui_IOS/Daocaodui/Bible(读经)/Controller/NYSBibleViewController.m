//
//  NYSBibleViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/19.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSBibleViewController.h"
#import "UIColor+NYS.h"
#import "NYSBibleBookCollectionViewCell.h"
#import "NYSBibleChapterViewController.h"

@interface NYSBibleViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSourcesArray;
@property (nonatomic, strong) NSArray *colorVolume; // 目录分色
@property (nonatomic, strong) NSArray *volumeColors; // 颜色分类
@property (nonatomic, strong) NSArray *bibleCatalog; // 中文目录
@end

@implementation NYSBibleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 监听圣经版本变更通知
    [NNotificationCenter addObserver:self selector:@selector(bibleVersionChanged:) name:NNotificationBibleVersionChange object:nil];
    
    [self OnoDecodeXMLIsEngBibleVersion:[NUserDefaults boolForKey:SettingKey_IsEnBible]];
    [self initUI];
}

- (void)bibleVersionChanged:(NSNotification *)notification {
//    NSString *bibleVersion = [notification.object stringValue];
    
    [self OnoDecodeXMLIsEngBibleVersion:[NUserDefaults boolForKey:SettingKey_IsEnBible]];
    [self.collectionView reloadData];
}

/// 解析BibleData
- (void)OnoDecodeXMLIsEngBibleVersion:(BOOL)isEngBibleVersion {
    NSMutableArray *books = [NSMutableArray arrayWithCapacity:60];
    NSArray<ONOXMLElement *> *bookElements = NBibleManager.currentbible.rootElement.children;
    if (self.bibleCatalog.count == bookElements.count) {
        for (int i = 0; i < bookElements.count; i ++) {
            NSString *title = bookElements[i].attributes[@"n"];
            NSString *bigTitle = bookElements[i].attributes[@"id"];
            [books addObject:@{@"title":isEngBibleVersion ? bigTitle : [self.bibleCatalog[i] objectForKey:@"abbr"],
                               @"subtitle":isEngBibleVersion ? title : [self.bibleCatalog[i] objectForKey:@"book"],
                               @"book":[bookElements[i] stringValue]}];
        }
    }
    self.dataSourcesArray = books;
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
        _colorVolume = @[@0, @5, @17, @22, @39, @43, @44, @45, @53, @57, @65, @66];
    }
    return _colorVolume;
}

- (NSArray *)volumeColors {
    if (!_volumeColors) {
        _volumeColors = @[RGBColor(144, 180, 75),
                          [UIColor peterRiverColor],
                          [UIColor amethystColor],
                          [UIColor alizarinColor],
                          RGBColor(221, 210, 59),
                          [UIColor turquoiseColor],
                          [UIColor carrotColor],
                          [UIColor whiteColor],
                          [UIColor redColor],
                          RGBColor(51, 166, 184),
                          [UIColor lightGrayColor]];
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

- (NSArray *)bibleCatalog {
    if (!_bibleCatalog) {
        _bibleCatalog = @[
            @{@"book" : @"创世记", @"id" : @"1", @"abbr" : @"创"},
            @{@"book" : @"出埃及记", @"id" : @"2", @"abbr" : @"出"},
            @{@"book" : @"利未记", @"id" : @"3", @"abbr" : @"利"},
            @{@"book" : @"民数记", @"id" : @"4", @"abbr" : @"民"},
            @{@"book" : @"申命记", @"id" : @"5", @"abbr" : @"申"},
            @{@"book" : @"约书亚记", @"id" : @"6", @"abbr" : @"书"},
            @{@"book" : @"士师记", @"id" : @"7", @"abbr" : @"士"},
            @{@"book" : @"路得记", @"id" : @"8", @"abbr" : @"得"},
            @{@"book" : @"撒母耳记上", @"id" : @"9", @"abbr" : @"撒上"},
            @{@"book" : @"撒母耳记下", @"id" : @"10", @"abbr" : @"撒下"},
            @{@"book" : @"列王纪上", @"id" : @"11", @"abbr" : @"王上"},
            @{@"book" : @"列王纪下", @"id" : @"12", @"abbr" : @"王下"},
            @{@"book" : @"历代志上", @"id" : @"13", @"abbr" : @"代上"},
            @{@"book" : @"历代志下", @"id" : @"14", @"abbr" : @"代下"},
            @{@"book" : @"以斯拉记", @"id" : @"15", @"abbr" : @"拉"},
            @{@"book" : @"尼希米记", @"id" : @"16", @"abbr" : @"尼"},
            @{@"book" : @"以斯帖记", @"id" : @"17", @"abbr" : @"斯"},
            @{@"book" : @"约伯记", @"id" : @"18", @"abbr" : @"伯"},
            @{@"book" : @"诗篇", @"id" : @"19", @"abbr" : @"诗"},
            @{@"book" : @"箴言", @"id" : @"20", @"abbr" : @"箴"},
            @{@"book" : @"传道书", @"id" : @"21", @"abbr" : @"传"},
            @{@"book" : @"雅歌", @"id" : @"22", @"abbr" : @"歌"},
            @{@"book" : @"以赛亚书", @"id" : @"23", @"abbr" : @"赛"},
            @{@"book" : @"耶利米书", @"id" : @"24", @"abbr" : @"耶"},
            @{@"book" : @"耶利米哀歌", @"id" : @"25", @"abbr" : @"哀"},
            @{@"book" : @"以西结书", @"id" : @"26", @"abbr" : @"结"},
            @{@"book" : @"但以理书", @"id" : @"27", @"abbr" : @"但"},
            @{@"book" : @"何西阿书", @"id" : @"28", @"abbr" : @"何"},
            @{@"book" : @"约珥书", @"id" : @"29", @"abbr" : @"珥"},
            @{@"book" : @"阿摩司书", @"id" : @"30", @"abbr" : @"摩"},
            @{@"book" : @"俄巴底亚书", @"id" : @"31", @"abbr" : @"俄"},
            @{@"book" : @"约拿书", @"id" : @"32", @"abbr" : @"拿"},
            @{@"book" : @"弥迦书", @"id" : @"33", @"abbr" : @"弥"},
            @{@"book" : @"那鸿书", @"id" : @"34", @"abbr" : @"鸿"},
            @{@"book" : @"哈巴谷书", @"id" : @"35", @"abbr" : @"哈"},
            @{@"book" : @"西番雅书", @"id" : @"36", @"abbr" : @"番"},
            @{@"book" : @"哈该书", @"id" : @"37", @"abbr" : @"该"},
            @{@"book" : @"撒迦利亚书", @"id" : @"38", @"abbr" : @"亚"},
            @{@"book" : @"玛拉基书", @"id" : @"39", @"abbr" : @"玛"},
            
            @{@"book" : @"马太福音", @"id" : @"40", @"abbr" : @"太"},
            @{@"book" : @"马可福音", @"id" : @"41", @"abbr" : @"可"},
            @{@"book" : @"路加福音", @"id" : @"42", @"abbr" : @"路"},
            @{@"book" : @"约翰福音", @"id" : @"43", @"abbr" : @"约"},
            @{@"book" : @"使徒行传", @"id" : @"44", @"abbr" : @"徒"},
            @{@"book" : @"罗马书", @"id" : @"45", @"abbr" : @"罗"},
            @{@"book" : @"哥林多前书", @"id" : @"46", @"abbr" : @"林前"},
            @{@"book" : @"哥林多后书", @"id" : @"47", @"abbr" : @"林后"},
            @{@"book" : @"加拉太书", @"id" : @"48", @"abbr" : @"加"},
            @{@"book" : @"以弗所书", @"id" : @"49", @"abbr" : @"弗"},
            @{@"book" : @"腓立比书", @"id" : @"50", @"abbr" : @"腓"},
            @{@"book" : @"歌罗西书", @"id" : @"51", @"abbr" : @"西"},
            @{@"book" : @"帖撒罗尼迦前书", @"id" : @"52", @"abbr" : @"帖前"},
            @{@"book" : @"帖撒罗尼迦后书", @"id" : @"53", @"abbr" : @"帖后"},
            @{@"book" : @"提摩太前书", @"id" : @"54", @"abbr" : @"提前"},
            @{@"book" : @"提摩太后书", @"id" : @"55", @"abbr" : @"提后"},
            @{@"book" : @"提多书", @"id" : @"56", @"abbr" : @"多"},
            @{@"book" : @"腓利门书", @"id" : @"57", @"abbr" : @"门"},
            @{@"book" : @"希伯来书", @"id" : @"58", @"abbr" : @"来"},
            @{@"book" : @"雅各书", @"id" : @"59", @"abbr" : @"雅"},
            @{@"book" : @"彼得前书", @"id" : @"60", @"abbr" : @"彼前"},
            @{@"book" : @"彼得后书", @"id" : @"61", @"abbr" : @"彼后"},
            @{@"book" : @"约翰一书", @"id" : @"62", @"abbr" : @"约壹"},
            @{@"book" : @"约翰二书", @"id" : @"63", @"abbr" : @"约貳"},
            @{@"book" : @"约翰三书", @"id" : @"64", @"abbr" : @"约叁"},
            @{@"book" : @"犹大书", @"id" : @"65", @"abbr" : @"犹"},
            @{@"book" : @"启示录", @"id" : @"66", @"abbr" : @"启"}
            ];
    }
    return _bibleCatalog;
}

@end
