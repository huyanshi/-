//
//  XunJieNewsNetManager.h
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "HomePageModel.h"
#import "HomePageBeforeModel.h"
#import "TheMeDetailModel.h"
#import "TheMeDetailBeforeModel.h"
#import "StoryModel.h"
#import "TheMeModel.h"
#import "TheMeListModel.h"


@interface XunJieNewsNetManager : BaseNetManager

/** 获取首页数据 */
+ (id)getHomePageDatacompletionHandle:(void(^)(id model, NSError *error))completionHandle;
/** 获取首页更多数据 */
+ (id)getHomePageBeforeDateWithLastObjID:(NSString *)LastID kCompletionHandle;
/** 获取分页数据 */
+ (id)getTheMeDetailDataWithTypeId:(NSString *)typeId kCompletionHandle;
/** 获取分页更多数据 */
+ (id)getTheMeDetailBeforeDateWithTypeId:(NSString *)typeId LastObjID:(NSString *)LastID kCompletionHandle;
/** 获取内容详情 */
+ (id)getStoryDataWithID:(NSString *)ID kCompletionHandle;
/** 获取theMe列表 */
+ (id)getTheMeListDatakcompletionHandle:(void(^)(id model, NSError *error))completionHandle;

@end
