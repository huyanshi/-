//
//  TheMeDetailBeforeModel.h
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class TheMeDetailBeforeStoriesModel;
@interface TheMeDetailBeforeModel : BaseModel

@property (nonatomic, strong) NSArray<TheMeDetailBeforeStoriesModel *> *stories;

@end
@interface TheMeDetailBeforeStoriesModel : BaseModel

@property (nonatomic, assign) NSInteger aid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray<NSString *> *images;

@end

