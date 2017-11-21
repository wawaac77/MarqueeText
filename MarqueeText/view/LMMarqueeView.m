
//
//  LMMarqueeView.m
//  MarqueeText
//
//  Created by Alice Jin on 18/11/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "LMMarqueeView.h"

@interface LMMarqueeView () <UIGestureRecognizerDelegate> {
    CGFloat width;
    CGFloat height;
    CGFloat label_x;
    CGFloat label_y;
    CGFloat label_width;
    CGFloat scroll_width;
}

@property (strong, nonatomic) NSMutableArray *labelArray;
@property (strong, nonatomic) UILabel *scrollLabel;
@property (strong, nonatomic) UIView *scrollView;
@property (strong, nonatomic) UIView *scrollView1;
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
- (LMMarqueeConfig *)checkConfig:(LMMarqueeConfig *)config {
    if (config.scrollVelocity < 0) {
        config.scrollVelocity = 0;
    } else if (_config.scrollVelocity > 10) {
        config.scrollVelocity = 10;
    }
    return config;
}

#pragma mark - set views
- (void)setupViews {
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:_config.frame];
    backgroundView.backgroundColor = _config.scrollBackgroundColor;
    backgroundView.clipsToBounds = YES;
    [self addSubview:backgroundView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(labelLongPressed)];
    longPress.delegate = self;
    self.userInteractionEnabled = YES;
    backgroundView.userInteractionEnabled = YES;
    [backgroundView addGestureRecognizer:longPress];
    
    /** size calculation*/
    label_x = _config.scrollInset.left;
    label_y = _config.scrollInset.top;
    width = _config.frame.size.width - _config.scrollInset.left - _config.scrollInset.right;
    //height = _config.frame.size.height - _config.scrollInset.top - _config.scrollInset.bottom;
    height = [self textHeightWithText:_config.scrollTitle width:width];
    label_width = [self textWidthWithText:_config.scrollTitle height:_config.font.lineHeight];
    
    /** scrollView */
    int n = [UIScreen mainScreen].bounds.size.width / (label_width + _config.scrollSpace);
    scroll_width = (label_width + _config.scrollSpace) * (n + 1);
    
    self.scrollView = [[UIView alloc] initWithFrame:CGRectMake(label_x, label_y, scroll_width, height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.clipsToBounds = YES;

    self.scrollView1 = [[UIView alloc] initWithFrame:CGRectMake(label_x - scroll_width, label_y, scroll_width, height)];
    _scrollView1.backgroundColor = [UIColor clearColor];
    _scrollView1.clipsToBounds = YES;
    
    for (int i = 0; i <= n; i ++) {
        for (int j = 0; j < 2; j ++) {
            UILabel *scrollLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * (label_width + _config.scrollSpace), 0, label_width, height)];
            scrollLabel.numberOfLines = 0;
            if (_config.autoWidth == YES) {
                scrollLabel.lineBreakMode = NSLineBreakByWordWrapping;
            }
            scrollLabel.backgroundColor = [UIColor clearColor];
            scrollLabel.textColor = _config.scrollTitleColor;
            scrollLabel.font = _config.font;
            scrollLabel.textAlignment = _config.textAlignment;
            scrollLabel.text = _config.scrollTitle;
            
            if (j == 0) {
                [_scrollView addSubview:scrollLabel];
            } else {
                [_scrollView1 addSubview:scrollLabel];
            }
        }
    }
    
    /** scroll label*/
    self.scrollLabel = [[UILabel alloc] initWithFrame:_config.frame];
    _scrollLabel.numberOfLines = 0;
    if (_config.autoWidth == YES) {
        _scrollLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    _scrollLabel.backgroundColor = [UIColor clearColor];
    _scrollLabel.textColor = _config.scrollTitleColor;
    _scrollLabel.font = _config.font;
    _scrollLabel.textAlignment = _config.textAlignment;
    _scrollLabel.text = _config.scrollTitle;
    
    if (_config.scrollType == 0) {
        [backgroundView addSubview:_scrollView];
        [backgroundView addSubview:_scrollView1];
    } else {
        [backgroundView addSubview:_scrollLabel];
    }

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

/** type 0 & 1 scroll function */
- (void)continiousAnimation {
    
    [UIView animateWithDuration:_config.scrollVelocity delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        if (_config.scrollType == 0) {
            self.scrollView.frame = CGRectMake(label_x + scroll_width, label_y, scroll_width, height);
            self.scrollView1.frame = CGRectMake(label_x, label_y, scroll_width, height);
        } else if (_config.scrollType == 1) {
            self.scrollLabel.frame = CGRectMake(label_x, label_y + height, width, height);
        }
        
    } completion:^(BOOL finished) {
        if (_config.scrollType == 0) {
            self.scrollView.frame = CGRectMake(label_x, label_y, scroll_width, height);
            self.scrollView1.frame = CGRectMake(label_x - scroll_width, label_y, scroll_width, height);
        } else if (_config.scrollType == 1) {
            self.scrollLabel.frame = CGRectMake(label_x, label_y - height, width, height);
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

- (void)addTapGesture:(id)target sel:(SEL)selector {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}

#pragma mark - Scroll begin & end
- (void)beginScrolling {
    [self addTimer];
}

- (void)endScrolling {
    [_scrollTimer invalidate];
}



@end
