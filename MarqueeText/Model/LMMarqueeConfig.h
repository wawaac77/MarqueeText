//
//  LMMarqueeConfig.h
//  MarqueeText
//
//  Created by Alice Jin on 18/11/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LMMarqueeConfig : NSObject

typedef NS_ENUM(NSInteger , TXScrollLabelViewType){
    LeftToRightScrolling = 0,
    UpToDownScrolling = 1,
    LeftToRightTimedScrolling = 2,
    UpToDownTimedScrolling = 3,
};

/** 滚动文字 */
@property (copy, nonatomic) NSString *scrollTitle;
/** 滚动类型 */
@property (assign, nonatomic) TXScrollLabelViewType scrollType;
/** 滚动速率([0, 10])，单位秒s */
@property (assign, nonatomic) NSTimeInterval scrollVelocity;
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

@end
