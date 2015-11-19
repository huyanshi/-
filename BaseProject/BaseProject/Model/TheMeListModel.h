//
//  TheMeListModel.h
//  迅捷日报
//
//  Created by tarena on 15/11/18.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class TheMeListOthersModel;

@interface TheMeListModel : BaseModel

@property (nonatomic, assign) NSInteger limit;

@property (nonatomic, strong) NSArray *subscribed;

@property (nonatomic, strong) NSArray<TheMeListOthersModel *> *others;

@end
@interface TheMeListOthersModel : BaseModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger aid;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *thumbnail;

@property (nonatomic, assign) NSInteger color;

@end

