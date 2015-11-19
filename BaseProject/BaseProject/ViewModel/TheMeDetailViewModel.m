//
//  TheMeDetailViewModel.m
//  BaseProject
//
//  Created by tarena on 15/11/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TheMeDetailViewModel.h"

@implementation TheMeDetailViewModel
- (NSMutableArray *)stories
{
    if (!_stories) {
        _stories = [NSMutableArray new];
    }
    return _stories;
}
-(instancetype)initWithTypeId:(NSString *)typeId
{
    if (self = [super init]) {
        self.typeId = typeId;
    }
    return self;
}
/** 获取数据 */
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    self.dataTask = [XunJieNewsNetManager getTheMeDetailDataWithTypeId:self.typeId completionHandle:^(TheMeDetailModel *model, NSError *error) {
        [self.stories removeAllObjects];
        [self.stories addObjectsFromArray:model.stories];
        self.naviTitle = model.name;
        self.naviImageURL = [NSURL URLWithString:model.background];
        completionHandle(error);
    }];
}
/** 获得更多 */
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle
{
    TheMeDetailStoriesModel *model = self.stories.lastObject;
    self.dataTask =[XunJieNewsNetManager getTheMeDetailBeforeDateWithTypeId:self.typeId LastObjID:[NSString stringWithFormat:@"%ld",model.aid] completionHandle:^(TheMeDetailModel *model, NSError *error) {
        [self.stories addObjectsFromArray:model.stories];
        completionHandle(error);
    }];
    
}
/** 页面行数 */
-(NSInteger)rowNumber
{
    return self.stories.count;
}
- (TheMeDetailStoriesModel *)modelForRow:(NSInteger)row
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
    return [NSString stringWithFormat:@"%ld", [self modelForRow:row].aid];
}
@end
