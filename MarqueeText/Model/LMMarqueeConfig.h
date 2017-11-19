//
//  LMMarqueeConfig.h
//  MarqueeText
//
//  Created by Alice Jin on 18/11/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
