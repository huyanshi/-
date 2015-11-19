//
//  HomePageBeforeModel.h
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class HomePageBeforeStoriesModel;
@interface HomePageBeforeModel : BaseModel

@property (nonatomic, copy) NSString *date;

@property (nonatomic, strong) NSArray<HomePageBeforeStoriesModel *> *stories;

@end
@interface HomePageBeforeStoriesModel : BaseModel

@property (nonatomic, assign) NSInteger aid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray<NSString *> *images;

@property (nonatomic, copy) NSString *ga_prefix;

@end

