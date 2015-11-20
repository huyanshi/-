//
//  HomePageViewController.m
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageViewModel.h"
#import "HomePageCell.h"
#import "iCarousel.h"
#import "StoryViewController.h"
#import "UINavigationBar+Awesome.h"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,iCarouselDelegate,iCarouselDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)HomePageViewModel *homePageVM;

@end

@implementation HomePageViewController
{//成员变量
    iCarousel *_ic;
    UIPageControl *_pageControl;
    UILabel *_titleLb;
     NSTimer *_timer;
}
/** 头部滚动视图 */
- (UIView *)headerView
{
    [_timer invalidate];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, kWindowW/320*215)];
    
    _ic = [iCarousel new];
    [headView addSubview:_ic];
    [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    _ic.delegate = self;
    _ic.dataSource = self;
    _ic.pagingEnabled = YES;
    _ic.scrollSpeed = 1;
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = self.homePageVM.indexNumber;
    [_ic addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(200);
        make.width.mas_greaterThanOrEqualTo(120);
        
    }];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.userInteractionEnabled = NO;

    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:3 block:^(NSTimer *timer) {
        [_ic scrollToItemAtIndex:_ic.currentItemIndex+1 animated:YES];
    } repeats:YES];

    return headView;
    
}
#pragma Mark - iCarouselDelegate
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.homePageVM.indexNumber;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW/320*215)];
        UIImageView *imageView = [UIImageView new];
        [view addSubview:imageView];
        imageView.tag = 100;
        imageView.contentMode = 2;
        view.clipsToBounds = YES;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _titleLb = [UILabel new];
        _titleLb.font = [UIFont boldFlatFontOfSize:20];
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.numberOfLines = 0;
        [imageView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(145);
        }];
        _titleLb.text = [self.homePageVM topTitleForIndexPic:0];
    }
    UIImageView *imageView = (UIImageView *)[view viewWithTag:100];
    [imageView setImageWithURL:[self.homePageVM topImageForIndexPic:index] placeholderImage:[UIImage imageNamed:@"composevideo_pic"]];
     return view;
    
}
/** 允许循环滚动 */
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}
/** 监控当前滚到到第几个 */
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    _titleLb.text = [self.homePageVM topTitleForIndexPic:carousel.currentItemIndex];
    _pageControl.currentPage = carousel.currentItemIndex;
}
/** 滚动栏中被选中后触发 */
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    StoryViewController *vc = [[StoryViewController alloc]initWithStoryId:[self.homePageVM topIdForIndexPic:index]];
    vc.storyNews = [self.homePageVM.topStoriesId copy];
    vc.index = index;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//单例的首页
+(UINavigationController *)standardHomePageNavi
{
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HomePageViewController *vc = [HomePageViewController new];
        navi = [[UINavigationController alloc]initWithRootViewController:vc];
    });
    return navi;
}
- (HomePageViewModel *)homePageVM
{
    if (!_homePageVM) {
        _homePageVM = [HomePageViewModel new];
    }
    return _homePageVM;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        self.tableView.showsVerticalScrollIndicator = false;
        _tableView.bounces = NO;
        [_tableView registerClass:[HomePageCell class] forCellReuseIdentifier:@"HomeCell"];
        [self.view addSubview:_tableView];
        _tableView.estimatedRowHeight =UITableViewAutomaticDimension;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).mas_equalTo(-64);
            make.left.right.bottom.mas_equalTo(0);
        }];
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Factory addMenuItemToVC:self];
    self.title = @"今日热闻";
       //设置透明NaviBar
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.shadowImage = [UIImage new];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.homePageVM refreshDataCompletionHandle:^(NSError *error) {
            self.tableView.tableHeaderView = [self headerView];
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
        }];
 
    });
//    /** 头部刷新 */
//    self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//       [self.homePageVM refreshDataCompletionHandle:^(NSError *error) {
//            self.tableView.tableHeaderView = [self headerView];
//           [self.tableView.header endRefreshing];
//           [self.tableView reloadData];
//       }];
//        
//    }];
/** 脚部加载 */
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       [self.homePageVM getMoreDataCompletionHandle:^(NSError *error) {
           [self.tableView.footer endRefreshing];
           [self.tableView reloadData];
       }];
    }];
    [self.tableView.header beginRefreshing];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homePageVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    [cell.iconIV.imageView setImageWithURL:[self.homePageVM imageURLForRow:indexPath.row]];
    cell.titleLb.text = [self.homePageVM titleForRow:indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
kRemoveCellSeparator
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoryViewController *vc = [[StoryViewController alloc]initWithStoryId:[self.homePageVM IDForRow:indexPath.row]];
    vc.storyNews = [self.homePageVM.storiesId copy];
    vc.index = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
