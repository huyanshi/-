//
//  HomePageModel.h
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class HomePageStoriesModel,HomePageTop_StoriesModel;
@interface HomePageModel : BaseModel

@property (nonatomic, copy) NSString *date;

@property (nonatomic, strong) NSArray<HomePageStoriesModel *> *stories;

@property (nonatomic, strong) NSArray<HomePageTop_StoriesModel *> *top_stories;

@end
@interface HomePageStoriesModel : BaseModel

@property (nonatomic, assign) NSInteger aid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray<NSString *> *images;

@property (nonatomic, copy) NSString *ga_prefix;

@end

@interface HomePageTop_StoriesModel : BaseModel

@property (nonatomic, assign) NSInteger aid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *ga_prefix;

@end

