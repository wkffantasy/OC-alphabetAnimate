//
//  MyCarsView.h
//  imitationZhiLian
//
//  Created by fantasy on 15/11/12.
//  Copyright © 2015年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchEndSelectedTagBlock)(int tag);

@interface MyCarsView : UIView


- (instancetype)initWithDataArray:(NSArray *)dataArray
                  withSinglLabelH:(CGFloat)singleH
                 andTouchEndBlock:(TouchEndSelectedTagBlock)touchEndBlock;


@end
