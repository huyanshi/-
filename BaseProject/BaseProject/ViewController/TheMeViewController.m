//
//  TheMeViewController.m
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TheMeViewController.h"
#import "TheMeViewModel.h"
#import "DSNavigationBar.h"
#import "TheMeDetailViewController.h"
#import "HomePageViewController.h"
#import "SettingViewController.h"
@interface TheMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)TheMeViewModel *theMeVM;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIView *bottomView;
@end

@implementation TheMeViewController
- (TheMeViewModel *)theMeVM {
    if(_theMeVM == nil) {
        _theMeVM = [[TheMeViewModel alloc] init];
    }
    return _theMeVM;
}
- (UIView *)topView
{
    if (!_topView) {
        _topView = [UIView new];
        [self.view addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(45);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(215, 90));
        }];
        UIImageView *icon = [UIImageView new];
        [icon setImage:[UIImage imageNamed:@"star4"]];
        [_topView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            
        }];
        UILabel *name = [UILabel new];
        name.text = @"心不在焉";
        name.font = [UIFont boldFlatFontOfSize:20];
        name.textColor = [UIColor whiteColor];
        [_topView addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(icon.mas_centerY);
            make.left.mas_equalTo(icon.mas_right).mas_equalTo(15);
        }];
        /**
         *  消息按钮
         */
        UIButton *message = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topView addSubview:message];
        [message mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(25, 40));
        }];
        
        [message setImage:[UIImage imageNamed:@"Menu_Icon_Message"] forState:(UIControlStateNormal)];
        message.imageEdgeInsets = UIEdgeInsetsMake(-15, 2,0 , message.titleLabel.bounds.size.width);
        [message setTitle:@"消息" forState:(UIControlStateNormal)];
        [message setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        message.titleLabel.font = [UIFont systemFontOfSize:10];
        message.tintColor = [UIColor whiteColor];
        message.titleLabel.textAlignment = NSTextAlignmentCenter;
        message.titleEdgeInsets = UIEdgeInsetsMake(20, -message.titleLabel.bounds.size.height-21, 0, 0);
        message.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        /**
         *  设置按钮
         */
        UIButton *setting = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topView addSubview:setting];
        [setting mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(message.mas_right).mas_equalTo(45);
            make.bottom.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(25, 40));
        }];
        
        [setting setImage:[UIImage imageNamed:@"Menu_Icon_Setting"] forState:(UIControlStateNormal)];
        setting.imageEdgeInsets = UIEdgeInsetsMake(-15, 2,0 , setting.titleLabel.bounds.size.width);
        [setting setTitle:@"设置" forState:(UIControlStateNormal)];
        [setting setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        setting.titleLabel.font = [UIFont systemFontOfSize:10];
        setting.tintColor = [UIColor whiteColor];
        setting.titleLabel.textAlignment = NSTextAlignmentCenter;
        setting.titleEdgeInsets = UIEdgeInsetsMake(20, -setting.titleLabel.bounds.size.height-21, 0, 0);
        setting.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [setting bk_addEventHandler:^(id sender) {
            SettingViewController *vc = kVCFromSb(@"SettingViewController", @"Main");
//            [self.navigationController pushViewController:kVCFromSb(@"Main", @"SettingViewController") animated:YES];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
            [self.sideMenuViewController setContentViewController:navi animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];

            
        } forControlEvents:(UIControlEventTouchUpInside)];
        /**
         *  收藏按钮
         */
        UIButton *collect = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topView addSubview:collect];
        [collect mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(message.mas_left).mas_equalTo(-45);
            make.bottom.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(25, 40));
        }];
        
        [collect setImage:[UIImage imageNamed:@"Menu_Icon_Collect"] forState:(UIControlStateNormal)];
        collect.imageEdgeInsets = UIEdgeInsetsMake(-15, 2,0 , collect.titleLabel.bounds.size.width);
        [collect setTitle:@"收藏" forState:(UIControlStateNormal)];
        [collect setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        collect.titleLabel.font = [UIFont systemFontOfSize:10];
        collect.tintColor = [UIColor whiteColor];
        collect.titleLabel.textAlignment = NSTextAlignmentCenter;
        collect.titleEdgeInsets = UIEdgeInsetsMake(20, -collect.titleLabel.bounds.size.height-21, 0, 0);
        collect.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

    }

    return _topView;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topView.mas_bottomMargin);
            make.left.right.mas_equalTo(self.topView);
            make.bottom.mas_equalTo(self.bottomView.mas_top).mas_equalTo(-28);
        }];
    }
    return _tableView;
}
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(60);
        }];
        UIImageView *offLineIV = [UIImageView new];
        [offLineIV setImage:[UIImage imageNamed:@"Menu_Download"]];
        [_bottomView addSubview:offLineIV];
        [offLineIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
//            make.bottom.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        UILabel *offLineLb = [UILabel new];
        offLineLb.text = @"离线";
        offLineLb.textColor = [UIColor whiteColor];
        offLineLb.font = [UIFont systemFontOfSize:13];
        [_bottomView addSubview:offLineLb];
        [offLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(offLineIV.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(0);
        }];
//        UIImageView *darkIV = [UIImageView new];
//        [darkIV setImage:[UIImage imageNamed:@"Menu_Dark"]];
//        [_bottomView addSubview:darkIV];
//        [darkIV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(offLineLb.mas_right).mas_equalTo(50);
//            make.centerY.mas_equalTo(0);
//            make.size.mas_equalTo(CGSizeMake(20, 20));
//        }];
//        UILabel *darkLb = [UILabel new];
//        darkLb.text = @"夜间";
//        darkLb.textColor = [UIColor whiteColor];
//        darkLb.font = [UIFont systemFontOfSize:13];
//        [_bottomView addSubview:darkLb];
//        [darkLb mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(darkIV.mas_right).mas_equalTo(10);
//            make.centerY.mas_equalTo(0);
//        }];
        /**
         *  收藏按钮
         */
        UIButton *dark = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomView addSubview:dark];
        [dark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(offLineLb.mas_right).mas_equalTo(50);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
        
        [dark setImage:[UIImage imageNamed:@"Menu_Dark"] forState:UIControlStateNormal];
        [dark setImage:[UIImage imageNamed:@"Menu_Day"] forState:UIControlStateSelected];
        dark.imageEdgeInsets = UIEdgeInsetsMake(0, -5,0 , dark.titleLabel.bounds.size.width);
        [dark setTitle:@"夜间" forState:(UIControlStateNormal)];
        [dark setTitle:@"白天" forState:UIControlStateSelected];
        [dark setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [dark setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        dark.titleLabel.font = [UIFont systemFontOfSize:13];
        dark.tintColor = [UIColor whiteColor];
        dark.titleLabel.textAlignment = NSTextAlignmentCenter;
        dark.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        dark.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [dark bk_addEventHandler:^(id sender) {
            dark.selected = !dark.selected;
        } forControlEvents:(UIControlEventTouchUpInside)];

    }
    return _bottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.theMeVM getDataFromNetCompleteHandle:^(NSError *error) {
            [self.tableView reloadData];
        }];
        
    });
    
    [self.tableView.header beginRefreshing];

}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.theMeVM.rowNumber+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    cell.accessoryType = 1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor =kRGBColor(200, 200, 200);
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"首页";
    }else{
    cell.textLabel.text = [self.theMeVM titleForRow:indexPath.row-1];
    }
//    cell.selectedTextColor = [UIColor whiteColor];
    
    return cell;
}
kRemoveCellSeparator
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",indexPath.row);
    if (indexPath.row == 0) {
        [self.sideMenuViewController setContentViewController:[HomePageViewController standardHomePageNavi] animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }else{
        TheMeDetailViewController *vc = [[TheMeDetailViewController alloc]initWithTypeId:[self.theMeVM URLIdForRow:indexPath.row-1]];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
        [self.sideMenuViewController setContentViewController:navi animated:YES];
//    [self.sideMenuViewController setContentViewController:[TheMeDetailViewController standardHomePageNaviWithTypeId:[self.theMeVM URLIdForRow:indexPath.row]] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
