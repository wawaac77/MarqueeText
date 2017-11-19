
//
//  LMMarqueeView.m
//  MarqueeText
//
//  Created by Alice Jin on 18/11/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "LMMarqueeView.h"

@interface LMMarqueeView ()

@property (strong, nonatomic) UILabel *testLabel;

@end

@implementation LMMarqueeView

#pragma mark - Instance Methods
- (instancetype)initWithConfig:(LMMarqueeConfig *)config {
    if (self = [super init]) {
        _config = config;
        [self scrollAnimation]; //set config, and make it scroll
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _config.frame = frame; //is this okay?
}

#pragma mark - functions?? what to describe here?
- (void)scrollAnimation {
    UIView *bgView = [[UIView alloc] initWithFrame:_config.frame];
    bgView.backgroundColor = [UIColor greenColor];
    [self addSubview:bgView];

    CGFloat width = [self textWidth:self.config.scrollTitle];
    self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, width, 30)];
    self.testLabel.backgroundColor = _config.scrollBackgroundColor;
    self.testLabel.text = _config.scrollTitle;
    //[self addTapGesture:_testLabel];
    [bgView addSubview:self.testLabel];
    [self linearAnimation];
    
}

- (void)linearAnimation {
    CGRect frame = self.testLabel.frame;
    //here pass scroll velocity
    [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.testLabel.frame = CGRectMake(-frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        CGRect mainRect = [[UIScreen mainScreen] bounds];
        CGFloat width = [self textWidth:_config.scrollTitle];
        self.testLabel.frame = CGRectMake(mainRect.size.width, 60, width, 30);
        [self linearAnimation];
    }];
}

- (CGFloat)textWidth:(NSString *)text {
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]} context:nil].size;
    return size.width;
}


/** tap gesture */
/*
- (void)addTapGesture:(id)target {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:@selector(didTap)];
    self.userInteractionEnabled = YES;
    [self addTapGesture:tap];
}

- (void)didTap {
    NSLog(@"did tap label");
}
 */

@end
