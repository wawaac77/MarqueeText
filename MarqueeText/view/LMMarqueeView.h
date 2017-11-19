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

/** 文本颜色 */
@property (strong, nonatomic) UIColor *scrollTitleColor;
/** 滚动内部inset */
@property (assign, nonatomic) UIEdgeInsets scrollInset;
/** 每次循环滚动的间距 */
@property (assign, nonatomic) CGFloat scrollSpace;
/** 文字排版 */
@property (assign, nonatomic) NSTextAlignment textAlignment;
/** 字体大小 */
@property (strong, nonatomic) UIFont *font;
/** 是否根据内容自适应宽度  */
@property (assign, nonatomic) BOOL autoWidth;

//others by Alice
/** 文本颜色 */
@property (strong, nonatomic) UIColor *scrollBackgroundColor;
/** MarqueeView frame */
@property (assign, nonatomic) CGRect frame;

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
