//
//  MyCarCell.h
//  imitationZhiLian
//
//  Created by fantasy on 15/11/12.
//  Copyright © 2015年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyCarModel.h"

@interface MyCarCell : UITableViewCell

@property (nonatomic,strong)MyCarModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
