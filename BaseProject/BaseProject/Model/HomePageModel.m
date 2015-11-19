//
//  HomePageModel.m
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel


+ (NSDictionary *)objectClassInArray{
    return @{@"stories" : [HomePageStoriesModel class], @"top_stories" : [HomePageTop_StoriesModel class]};
}
@end
@implementation HomePageStoriesModel

@end


@implementation HomePageTop_StoriesModel


@end


