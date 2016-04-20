//
//  MyCarGroupModel.m
//  imitationZhiLian
//
//  Created by fantasy on 15/11/12.
//  Copyright © 2015年 fantasy. All rights reserved.
//

#import "MyCarGroupModel.h"
#import "MyCarModel.h"

@implementation MyCarGroupModel

+(instancetype)MyCarGroupModelWithDict:(NSDictionary *)dict{
  
  return [[self alloc] carGroupModelWithDict:dict];
  
}
-(instancetype)carGroupModelWithDict:(NSDictionary *)dict{
  
  self.title = dict[@"title"];
  
  NSArray *array = dict[@"cars"];
  NSMutableArray *tempArray = [NSMutableArray array];
  for (NSDictionary *tempDict in array) {
    
    MyCarModel *model = [[MyCarModel alloc]init];
    model.icon = tempDict[@"icon"];
    model.name = tempDict[@"name"];
    [tempArray addObject:model];
    
  }
  self.cars = tempArray;
  
  
  
  
  return self;
}

@end
