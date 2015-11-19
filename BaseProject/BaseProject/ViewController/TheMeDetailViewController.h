//
//  TheMeDetailViewController.h
//  BaseProject
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheMeDetailViewController : UIViewController
//+(UINavigationController *)standardHomePageNaviWithTypeId:(NSString *)typeId;
- (instancetype)initWithTypeId:(NSString *)typeId;
@property (nonatomic,strong)NSString *typeId;

@end
