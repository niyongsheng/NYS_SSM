//
//  NYSBibleVerseViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/20.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSBibleVerseViewController.h"

@interface NYSBibleVerseViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSourcesArray;

@end

@implementation NYSBibleVerseViewController

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
    
    ONOXMLElement *chapterDocument = bookDocument.children[self.chapterNumber - 1];
    NSMutableArray *verses = [NSMutableArray array];
    for (ONOXMLElement *element in chapterDocument.children) {
        [verses addObject:@{@"verseNumber":element.attributes[@"n"],
                            @"verse":[element stringValue]}];
    }
    self.dataSourcesArray = verses;
}

#pragma mark -- initUI --
- (void)initUI {
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, NTabBarHeight, 0);
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark —- tableviewdDelegate —-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourcesArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *bibleText = [NSString stringWithFormat:@"%@ %@", [self.dataSourcesArray[indexPath.row] objectForKey:@"verseNumber"], [self.dataSourcesArray[indexPath.row] objectForKey:@"verse"]];
    CGFloat bibleFontSize = [NUserDefaults floatForKey:SettingKey_BibleFontSize];
    UIFont *bibleFont = bibleFontSize ? [UIFont systemFontOfSize:bibleFontSize] : [UIFont systemFontOfSize:Settingdefault_BibleFontSize];
    return [bibleText heightForFont:bibleFont width:NScreenWidth - 30] + 10;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    NSString *bibleText = [NSString stringWithFormat:@"%@ %@", [self.dataSourcesArray[indexPath.row] objectForKey:@"verseNumber"], [self.dataSourcesArray[indexPath.row] objectForKey:@"verse"]];
    CGFloat bibleFontSize = [NUserDefaults floatForKey:SettingKey_BibleFontSize];
    cell.textLabel.font = bibleFontSize ? [UIFont systemFontOfSize:bibleFontSize] : [UIFont systemFontOfSize:Settingdefault_BibleFontSize];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = bibleText;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
