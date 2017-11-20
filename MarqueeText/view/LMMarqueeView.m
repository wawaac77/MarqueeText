
//
//  LMMarqueeView.m
//  MarqueeText
//
//  Created by Alice Jin on 18/11/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "LMMarqueeView.h"

@interface LMMarqueeView () {
    CGFloat width;
    CGFloat height;
    CGFloat label_x;
    CGFloat label_y;
}

@property (strong, nonatomic) NSMutableArray *labelArray;
@property (strong, nonatomic) UILabel *scrollLabel;
@property (strong, nonatomic) NSTimer *scrollTimer;

@end

@implementation LMMarqueeView

#pragma mark - Instance Methods
- (instancetype)initWithConfig:(LMMarqueeConfig *)config {
    if (self = [super init]) {
        _config = [self checkConfig:config]; //protect from exceed limitation
        
        [self setupViews];
        [self beginScrolling];
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
    _config.frame = frame;
}

#pragma mark - check config
- (LMMarqueeConfig *)checkConfig : (LMMarqueeConfig *)config {
    if (config.scrollVelocity < 0) {
        config.scrollVelocity = 0;
    } else if (_config.scrollVelocity > 10) {
        config.scrollVelocity = 10;
    }
    return config;
}

#pragma mark - set views
- (void)setupViews {
    //self.backgroundColor = _config.scrollBackgroundColor;
    //[self setBackgroundColor:_config.scrollBackgroundColor];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:_config.frame];
    //backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.backgroundColor = _config.scrollBackgroundColor;
    backgroundView.clipsToBounds = YES;
    [self addSubview:backgroundView];
    
    label_x = _config.scrollInset.left;
    label_y = _config.scrollInset.top;
    width = _config.frame.size.width - _config.scrollInset.left - _config.scrollInset.right;
    //height = _config.frame.size.height - _config.scrollInset.top - _config.scrollInset.bottom;
    height = [self textHeightWithText:_config.scrollTitle width:width];
    NSLog(@"height %f", height);
    
    self.scrollLabel = [[UILabel alloc] initWithFrame:CGRectMake(_config.scrollInset.left, _config.scrollInset.top, width, height)];
    self.scrollLabel.numberOfLines = 0;
    self.scrollLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.scrollLabel.backgroundColor = [UIColor clearColor];
    self.scrollLabel.textColor = _config.scrollTitleColor;
    self.scrollLabel.font = _config.font;
    self.scrollLabel.textAlignment = _config.textAlignment;
    self.scrollLabel.text = _config.scrollTitle;
    
    /** add tap gesture */
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(labelLongPressed)];
    self.userInteractionEnabled = YES;
    [self.scrollLabel addGestureRecognizer:longPress];
  
    [backgroundView addSubview:self.scrollLabel];
    
}

#pragma mark - timer control scroll function
/** Timer */
- (void)addTimer {
    if (_config.scrollType == 0 || _config.scrollType == 1) {
        self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(continiousAnimation) userInfo:nil repeats:NO];
    } else {
        self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:_config.scrollVelocity target:self selector:@selector(changeLabelPos) userInfo:nil repeats:YES];
    }
    
    [[NSRunLoop mainRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
}

/*
- (void)startAnimation {
    if (_config.scrollType == 0 || _config.scrollType == 1) {
        [self continiousAnimation];
    } else {
        [self changeLabelPos];
    }
}
*/

/** type 0 & 1 scroll function */
- (void)continiousAnimation {
    CGRect frame = _config.frame;
    
    [UIView animateWithDuration:_config.scrollVelocity delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        if (_config.scrollType == 0) {
            self.scrollLabel.frame = CGRectMake(label_x + width, label_y, width, height);
        } else if (_config.scrollType == 1) {
            self.scrollLabel.frame = CGRectMake(label_x, label_y + height, width, height);
        } else {
            self.scrollLabel.frame = CGRectMake(-frame.size.width, frame.origin.y, width, height);
        }
        
    } completion:^(BOOL finished) {
        if (_config.scrollType == 0) {
            self.scrollLabel.frame = CGRectMake(label_x - width, label_y, width, height);
        } else if (_config.scrollType == 1) {
            self.scrollLabel.frame = CGRectMake(label_x, label_y - height, width, height);
        } else {
            self.scrollLabel.frame = CGRectMake(-frame.size.width, frame.origin.y, width, height);
        }
        
        [self continiousAnimation];
    }];
}

/** type 2 & 3 scroll function */
- (void)changeLabelPos {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        if (_config.scrollType == 2) {
            label_x += width;
        } else {
            label_y += _config.frame.size.height;
        }
        self.scrollLabel.frame = CGRectMake(label_x, label_y, width, height);
    } completion:^(BOOL finished) {
        if (label_x > _config.scrollInset.left + width) {
            label_x = _config.scrollInset.left - width;
            self.scrollLabel.frame = CGRectMake(label_x, label_y, width, height);
        }
        if (label_y > _config.scrollInset.top + height) {
            label_y = _config.scrollInset.top - height;
            self.scrollLabel.frame = CGRectMake(label_x, label_y, width, height);
        }
    }];
    
}

#pragma mark - text size calculation
- (CGFloat)textWidthWithText:(NSString *)text
                      height:(CGFloat)height {
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_config.font} context:nil].size;
    return size.width;
}

- (CGFloat)textHeightWithText:(NSString *)text
                        width:(CGFloat)width {
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_config.font} context:nil].size;
    return size.height;
}

#pragma mark - tap gesture
- (void)labelLongPressed {
    NSLog(@"did tap label");
}

#pragma mark - Scroll begin & end
- (void)beginScrolling {
    [self addTimer];
}

- (void)endScrolling {
    [_scrollTimer invalidate];
}



@end
