//
//  LMMarqueeView.h
//  MarqueeText
//
//  Created by Alice Jin on 18/11/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMMarqueeConfig.h"

@interface LMMarqueeView : UIView

/** MarqueeView参数*/
@property (strong, nonatomic) LMMarqueeConfig *config;

/**
 *  初始化函数
 */
- (instancetype)initWithConfig:(LMMarqueeConfig *)config;

/**
 *  开始滚动
 */
- (void) beginScrolling;

/**
 *  停止滚动
 */
- (void) endScrolling;


- (void)addTapGesture:(id)target;

@end
