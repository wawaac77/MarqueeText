
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
    /*
    UIView *bgView = [[UIView alloc] initWithFrame:_config.frame];
    bgView.backgroundColor = [UIColor yellowColor];
    [self addSubview:bgView];

     */
    self.backgroundColor = _config.scrollBackgroundColor;
    
    CGFloat width = [self textWidth:self.config.scrollTitle];
    self.testLabel = [[UILabel alloc] initWithFrame:_config.frame];
    //self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, width, 30)];
    self.testLabel.font = _config.font;
    self.testLabel.backgroundColor = [UIColor clearColor];
    self.testLabel.textColor = _config.scrollTitleColor;
    self.testLabel.text = _config.scrollTitle;
    //[self addTapGesture:_testLabel];
    [self addSubview:self.testLabel];
    [self linearAnimation];
    
}

- (void)linearAnimation {
    //CGRect frame = self.testLabel.frame;
    CGRect frame = _config.frame;
    //here pass scroll velocity
    [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        if (_config.scrollType == 0) {
            self.testLabel.frame = CGRectMake(-frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
        } else if (_config.scrollType == 1) {
            self.testLabel.frame = CGRectMake(frame.origin.x, frame.size.height, frame.size.width, frame.size.height);
        } else {
            self.testLabel.frame = CGRectMake(-frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
        }
        
    } completion:^(BOOL finished) {
        //CGRect mainRect = [[UIScreen mainScreen] bounds];
        CGRect mainRect = _config.frame;

        CGFloat width = [self textWidth:_config.scrollTitle];
        if (_config.scrollType == 0) {
            self.testLabel.frame = CGRectMake(mainRect.size.width, 60, width, frame.size.height);
        } else if (_config.scrollType == 1) {
            self.testLabel.frame = CGRectMake(mainRect.origin.x, -mainRect.size.height, width, frame.size.height);
            NSLog(@"mainRect.origin.x %f", mainRect.origin.x);
        } else {
            self.testLabel.frame = CGRectMake(-frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
        }
        
        [self linearAnimation];
    }];
}

- (CGFloat)textWidth:(NSString *)text {
    //CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]} context:nil].size;
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_config.font} context:nil].size;
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
