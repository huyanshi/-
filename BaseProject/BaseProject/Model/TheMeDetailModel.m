//
//  TheMeDetailModel.m
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TheMeDetailModel.h"

@implementation TheMeDetailModel


+ (NSDictionary *)objectClassInArray{
    return @{@"stories" : [TheMeDetailStoriesModel class], @"editors" : [TheMeDetailEditorsModel class]};
}
@end
@implementation TheMeDetailStoriesModel

@end


@implementation TheMeDetailEditorsModel

@end


