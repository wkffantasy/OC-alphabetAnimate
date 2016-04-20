//
//  MyCarGroupModel.h
//  imitationZhiLian
//
//  Created by fantasy on 15/11/12.
//  Copyright © 2015年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCarGroupModel : NSObject

@property (nonatomic,copy)NSString * title;

@property (nonatomic,strong)NSArray * cars;

+(instancetype)MyCarGroupModelWithDict:(NSDictionary *)dict;

@end
