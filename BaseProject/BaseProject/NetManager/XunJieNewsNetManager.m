//
//  XunJieNewsNetManager.m
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "XunJieNewsNetManager.h"

@implementation XunJieNewsNetManager
+ (id)getHomePageDatacompletionHandle:(void (^)(id, NSError *))completionHandle
{
    NSString *path = @"http://news-at.zhihu.com/api/4/stories/latest?client=0";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HomePageModel objectWithKeyValues:responseObj],error);
    }];
}
/** 获取首页更多数据 */
+ (id)getHomePageBeforeDateWithLastObjID:(NSString *)LastID completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSString *path = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/stories/before/%@?client=0",LastID];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HomePageBeforeModel objectWithKeyValues:responseObj],error);
    }];
}
/** 获取分页数据 */
+ (id)getTheMeDetailDataWithTypeId:(NSString *)typeId completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSString *path = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/theme/%@",typeId];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([TheMeDetailModel objectWithKeyValues:responseObj],error);
    }];
}
/** 获取分页更多数据 */
+ (id)getTheMeDetailBeforeDateWithTypeId:(NSString *)typeId LastObjID:(NSString *)LastID completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSString *path = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/theme/%@/before/%@",typeId,LastID];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([TheMeDetailBeforeModel objectWithKeyValues:responseObj],error);
    }];
}
/** 获取内容详情 */
+ (id)getStoryDataWithID:(NSString *)ID completionHandle:(void (^)(id, NSError *))completionHandle
{
    NSString *path = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/story/%@",ID];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([StoryModel objectWithKeyValues:responseObj],error);
    }];
}
/** 获取TheMe列表 */
+ (id)getTheMeListDatakcompletionHandle:(void (^)(id, NSError *))completionHandle
{
       NSString *path = @"http://news-at.zhihu.com/api/4/themes";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([TheMeListModel objectWithKeyValues:responseObj],error);
    }];
        
}


@end
