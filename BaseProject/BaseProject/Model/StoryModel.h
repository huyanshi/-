//
//  StoryModel.h
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface StoryModel : BaseModel

@property (nonatomic, copy) NSString *image_source;

@property (nonatomic, copy) NSString *ga_prefix;

@property (nonatomic, assign) NSInteger aid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) NSArray<NSString *> *css;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *body;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, strong) NSArray *js;

@end
