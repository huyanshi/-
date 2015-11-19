//
//  TheMeDetailModel.h
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class TheMeDetailStoriesModel,TheMeDetailEditorsModel;
@interface TheMeDetailModel : BaseModel

@property (nonatomic, assign) NSInteger color;

@property (nonatomic, strong) NSArray<TheMeDetailStoriesModel *> *stories;

@property (nonatomic, copy) NSString *image_source;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) NSArray<TheMeDetailEditorsModel *> *editors;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *background;

@property (nonatomic, copy) NSString *name;

@end
@interface TheMeDetailStoriesModel : BaseModel

@property (nonatomic, assign) NSInteger aid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray<NSString *> *images;

@end

@interface TheMeDetailEditorsModel : BaseModel

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, assign) NSInteger aid;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *bio;

@end

