//
//  HomePageViewModel.m
//  BaseProject
//
//  Created by tarena on 15/11/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "HomePageViewModel.h"


@implementation HomePageViewModel
- (NSMutableArray *)stories
{
    if (!_stories) {
        _stories = [NSMutableArray new];
    }
    return _stories;
}
/** 获取数据 */
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    self.dataTask = [XunJieNewsNetManager getHomePageDatacompletionHandle:^(HomePageModel *model, NSError *error) {
        self.topStories = model.top_stories;
        [self.stories addObjectsFromArray:model.stories];
        self.date = model.date.integerValue;
        completionHandle(error);
    }];
}
/** 刷新 */
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle
{
    self.topStories = nil;
    [self.stories removeAllObjects];
    [self getDataFromNetCompleteHandle:completionHandle];
}
/** 获得更多 */
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle
{
    self.date -=1;
    self.dataTask =[XunJieNewsNetManager getHomePageBeforeDateWithLastObjID:[NSString stringWithFormat:@"%ld",self.date] completionHandle:^(HomePageModel *model, NSError *error) {
        [self.stories addObjectsFromArray:model.stories];
        completionHandle(error);
    }];
}
/** 头部滚动图片数量 */
- (NSInteger)indexNumber
{
    return self.topStories.count;
}
/** 获取头部对象模型 */
- (HomePageTop_StoriesModel *)modelForIndex:(NSInteger)index
{
    return self.topStories[index];
}
/** 头部图片地址 */
- (NSURL *)topImageForIndexPic:(NSInteger)index
{
    return [NSURL URLWithString:[self modelForIndex:index].image];
}
/** 头部标题 */
- (NSString *)topTitleForIndexPic:(NSInteger)index
{
    return [self modelForIndex:index].title;
}
/** 头部滚动图片内容Id */
- (NSString *)topIdForIndexPic:(NSInteger)index
{
    return [NSString stringWithFormat:@"%ld",[self modelForIndex:index].aid];
}


/** 页面行数 */
-(NSInteger)rowNumber
{
    return self.stories.count;
}
/** 页面数据模型 */
- (HomePageStoriesModel *)modelForRow:(NSInteger)row
{
    return self.stories[row];
}
/** 单元格标题 */
- (NSString *)titleForRow:(NSInteger)row
{
    return [self modelForRow:row].title;
}
/** 单元格图片 */
- (NSURL *)imageURLForRow:(NSInteger)row
{
    return [NSURL URLWithString:[self modelForRow:row].images.firstObject];
}
/** 内容ID */
- (NSString *)IDForRow:(NSInteger)row
{
    return [NSString stringWithFormat:@"%ld",[self modelForRow:row].aid];
}

@end
