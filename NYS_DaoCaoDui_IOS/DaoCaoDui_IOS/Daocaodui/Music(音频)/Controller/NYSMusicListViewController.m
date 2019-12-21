//
//  NYSMusicListViewController.m
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/13.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import "NYSMusicListViewController.h"
#import "NYSMusicMenuHeaderView.h"
#import "NYSMusicListModel.h"
#import "NYSMusicModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DFPlayer.h"

@interface NYSMusicListViewController () <UITableViewDelegate, UITableViewDataSource, DFPlayerDelegate, DFPlayerDataSource> {
    NSArray *_dataSource;
    NYSMusicMenuHeaderView *_headerView;
}
@property (nonatomic, strong) NSMutableArray *datasourceArray;
@property (nonatomic, strong) NYSMusicListModel *musicMenu;
@end

@implementation NYSMusicListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self headerRereshing];
    [self initDFPlayer];
}

#pragma mark - 初始化DFPlayer
- (void)initDFPlayer {
    [[DFPlayer shareInstance] df_initPlayerWithUserId:nil];
    [DFPlayer shareInstance].dataSource  = self;
    [[DFPlayer shareInstance] df_reloadData];
}

- (NSArray<DFPlayerModel *> *)df_playerModelArray {
    // 在这里将音频数据传给DFPlayer
    DFPlayerModel *model = [DFPlayerModel new];
    model.audioId = 0;
    model.audioUrl = [self translateIllegalCharacterWtihUrlStr:@"http://image.daocaodui.top/music/%E4%BD%A0%E7%9A%84%E9%A6%99%E6%B0%94%EF%BC%88%E6%AD%8C%E5%94%B1%E7%89%88%EF%BC%89-feat.%E9%99%88%E5%88%A9%E4%BA%9A.mp3"];
    return @[model];
}

//- (DFPlayerInfoModel *)df_audioInfoForPlayer:(DFPlayer *)player{
//    // DFPlayer收到某个音频的播放请求时，会调用这个方法请求该音频的音频名、歌手、专辑名、歌词、配图等信息。
//
//}

- (NSURL *)translateIllegalCharacterWtihUrlStr:(NSString *)yourUrl{
    // 如果链接中存在中文或某些特殊字符，需要通过以下代码转译
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)yourUrl, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
//    NSString *encodedString = [yourUrl stringByAddingPercentEncodingWithAllowedCharacters:charactSet];
    return [NSURL URLWithString:encodedString];
}

#pragma mark -- initUI --
- (void)setupUI {
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, NTabBarHeight + SegmentViewHeight, 0);
    self.tableView.mj_footer.hidden = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"NYSMusicMenuHeaderView" owner:self options:nil] objectAtIndex:0];
    _headerView.frame = CGRectMake(0, 0, NScreenWidth, 200);
    [self.tableView setTableHeaderView:_headerView];
    [self.view addSubview:self.tableView];
}

- (void)headerRereshing {
    WS(weakSelf);
    [NYSRequest GetMusicMenuById:GET parameters:@{@"id" : @(self.musicMenuID)} success:^(id response) {
        [weakSelf.tableView.mj_header endRefreshing];
        [NYSMusicListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"idField" : @"id"};
        }];
        weakSelf.musicMenu = [NYSMusicListModel mj_objectWithKeyValues:[response objectForKey:@"data"]];
        [weakSelf.tableView reloadData];
        [TableViewAnimationKit showWithAnimationType:XSTableViewAnimationTypeToTop tableView:weakSelf.tableView];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
    } isCache:YES];
}

#pragma mark —- tableviewdDelegate —-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.musicMenu musicList] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NYSMusicModel *musicModel = [self.musicMenu musicList][indexPath.row];
    cell.textLabel.text = musicModel.name;
    cell.detailTextLabel.text = musicModel.anAuthor;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:musicModel.icon] placeholderImage:[UIImage imageNamed:@"ic_disc_90x90_"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NYSMusicModel *musicModel = [self.musicMenu musicList][indexPath.row];
    [[DFPlayer shareInstance] df_playerPlayWithAudioId:0];
}

@end
