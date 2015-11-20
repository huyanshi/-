//
//  HomePageViewModel.h
//  BaseProject
//
//  Created by tarena on 15/11/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@interface HomePageViewModel : BaseViewModel
/** 当前数据时间 */
@property (nonatomic)NSInteger date;

/** 头部数据数组 */
@property (nonatomic,strong)NSArray *topStories;
/** 存放新闻id数组 */
@property (nonatomic,strong)NSMutableArray *topStoriesId;
/** 头部滚动图片数量 */
@property (nonatomic,assign)NSInteger indexNumber;
/** 头部图片地址 */
- (NSURL *)topImageForIndexPic:(NSInteger)index;
/** 头部标题 */
- (NSString *)topTitleForIndexPic:(NSInteger)index;
/** 头部滚动图片内容Id */
- (NSString *)topIdForIndexPic:(NSInteger)index;

/** 页面数据数组 */
@property (nonatomic,strong)NSMutableArray *stories;
/** 存放新闻id数组 */
@property (nonatomic,strong)NSMutableArray *storiesId;
/** 页面行数 */
@property (nonatomic,assign)NSInteger rowNumber;
/** 单元格标题 */
- (NSString *)titleForRow:(NSInteger)row;
/** 单元格图片 */
- (NSURL *)imageURLForRow:(NSInteger)row;
/** 内容ID */
- (NSString *)IDForRow:(NSInteger)row;



@end
