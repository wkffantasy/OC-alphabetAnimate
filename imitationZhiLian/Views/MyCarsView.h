//
//  MyCarsView.h
//  imitationZhiLian
//
//  Created by fantasy on 15/11/12.
//  Copyright © 2015年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCarsViewDelegate <NSObject>

-(void)touchEndPoint:(CGPoint )point andWithSelectedTag:(int)tag;

@end


@interface MyCarsView : UIView

@property (nonatomic,weak)id<MyCarsViewDelegate>delegate;

//数据
@property (nonatomic,strong)NSArray *dataArray;

@end
