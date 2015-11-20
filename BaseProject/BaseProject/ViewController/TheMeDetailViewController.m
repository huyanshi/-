//
//  TheMeDetailViewController.m
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TheMeDetailViewController.h"
#import "TheMeDetailViewModel.h"
#import "HomePageCell.h"
#import "StoryViewController.h"
#import "Factory.h"
#import "NTParallaxView.h"
#import "TextCell.h"

@interface TheMeDetailViewController ()<UITableViewDelegate,UITableViewDataSource,NTParallaxViewDelegate,NTParallaxViewDataSource>
@property (nonatomic,strong)TheMeDetailViewModel *theMeDetailVM;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NTParallaxView *parallaxView;
@end

@implementation TheMeDetailViewController
- (instancetype)initWithTypeId:(NSString *)typeId
{
    if (self = [super init]) {
        self.typeId = typeId;
    }
    return self;
}
-(TheMeDetailViewModel *)theMeDetailVM
{
    if (!_theMeDetailVM) {
        _theMeDetailVM = [[TheMeDetailViewModel alloc]initWithTypeId:self.typeId];
}
    return _theMeDetailVM;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HomePageCell class] forCellReuseIdentifier:@"Cell"];
        [_tableView registerClass:[TextCell class] forCellReuseIdentifier:@"TextCell"];
        [self.view addSubview:_tableView];
        _tableView.rowHeight = kWindowW/320*75;
        _tableView.estimatedRowHeight =UITableViewAutomaticDimension;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        /** 头部刷新 */
        _tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.theMeDetailVM getDataFromNetCompleteHandle:^(NSError *error) {
                self.title=self.theMeDetailVM.naviTitle;
                [self.tableView.header endRefreshing];
                [self.tableView reloadData];
            }];
            
        }];
        /** 脚部加载 */
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.theMeDetailVM getMoreDataCompletionHandle:^(NSError *error) {
                [self.tableView.footer endRefreshing];
                [self.tableView reloadData];
            }];
        }];


    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Factory addMenuItemToVC:self];
    [self.tableView.header beginRefreshing];
    // Do any additional setup after loading the view.
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.theMeDetailVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.theMeDetailVM imageURLForRow:indexPath.row] ==nil) {
        TextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell"];
        cell.titleLb.text = [self.theMeDetailVM titleForRow:indexPath.row];
        return cell;
    }else{
        HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.iconIV.imageView setImageWithURL:[self.theMeDetailVM imageURLForRow:indexPath.row]];
    cell.titleLb.text = [self.theMeDetailVM titleForRow:indexPath.row];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

kRemoveCellSeparator
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoryViewController *vc = [[StoryViewController alloc]initWithStoryId:[self.theMeDetailVM IDForRow:indexPath.row]];
    vc.index = indexPath.row;
    vc.storyNews = [self.theMeDetailVM.storiesId copy];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - NTParallaxViewDelegate
-(NTParallaxView *)parallaxView
{
    if (!_parallaxView) {
        UIImageView *imageView = [UIImageView new];
        [imageView setImageWithURL:self.theMeDetailVM.naviImageURL];
        _parallaxView = [[NTParallaxView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) bgroundImages:@[imageView.image] dataSource:self delegate:self];
        [self.view addSubview:_parallaxView];
        [_parallaxView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
       
        
    }
    return _parallaxView;
}
#pragma mark - NTParallaxViewdata
//有几个分区
-(NSInteger)numberOfSectionsInParallaxView:(NTParallaxView *)parallaxView
{
    return 1;
}
//每个分区几行

-(NSInteger)parallaxView:(NTParallaxView *)parallaxView numberOfRowsInSection:(NSInteger)section
{
    return self.theMeDetailVM.rowNumber;
}

-(CGFloat)parallaxView:(NTParallaxView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)parallaxView:(NTParallaxView *)parallaxView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(CGFloat)parallaxView:(NTParallaxView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

static NSString * identifyCell = @"identify";
-(UITableViewCell*)parallaxView:(NTParallaxView *)parallaxView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCell *cell = [parallaxView dequeueReusableCellWithIdentifier:identifyCell];
    if (!cell) {
        cell = [[HomePageCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifyCell];
    }
    [cell.iconIV.imageView setImageWithURL:[self.theMeDetailVM imageURLForRow:indexPath.row]];
    cell.titleLb.text = [self.theMeDetailVM titleForRow:indexPath.row];
    
    return cell;
}

-(CGFloat)parallaxViewBackWindowHeight
{
    return 44;
}
-(UIView*)parallaxView:(NTParallaxView *)parallaxView
viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}

-(UIView*)parallaxView:(NTParallaxView *)parallaxView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(void)parallaxView:(NTParallaxView *)parallaxView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@: click",indexPath);

    StoryViewController *vc = [[StoryViewController alloc]initWithStoryId:[self.theMeDetailVM IDForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
