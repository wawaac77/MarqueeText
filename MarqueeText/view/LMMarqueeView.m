
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

@property (strong, nonatomic) UILabel *scrollLabel;
@property (strong, nonatomic) NSTimer *scrollTimer;

@end

@implementation LMMarqueeView

#pragma mark - Instance Methods
- (instancetype)initWithConfig:(LMMarqueeConfig *)config {
    if (self = [super init]) {
        _config = config;
        if (_config.scrollVelocity < 0) {
            _config.scrollVelocity = 0;
        } else if (_config.scrollVelocity > 10) {
            _config.scrollVelocity = 10;
        }
        NSLog(@"initWithConfig _config.x %f", config.frame.origin.y);
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
    NSLog(@"origin.y in setFrame %f", _config.frame.origin.y);
}

#pragma mark - functions?? what to describe here?
- (void)scrollAnimation {
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:_config.frame];
    backgroundView.backgroundColor = _config.scrollBackgroundColor;
    [self addSubview:backgroundView];

    //self.backgroundColor = _config.scrollBackgroundColor;
    
    //CGFloat width = [self textWidth:self.config.scrollTitle];
    label_x = _config.scrollInset.left;
    label_y = _config.scrollInset.top;
    width = _config.frame.size.width - _config.scrollInset.left - _config.scrollInset.right;
    height = _config.frame.size.height - _config.scrollInset.top - _config.scrollInset.bottom;
    
    self.scrollLabel = [[UILabel alloc] initWithFrame:CGRectMake(_config.scrollInset.left, _config.scrollInset.top, width, height)];
    //self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, width, 30)];
    self.scrollLabel.font = _config.font;
    self.scrollLabel.numberOfLines = 0;
    self.scrollLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.scrollLabel.backgroundColor = [UIColor clearColor];
    self.scrollLabel.textColor = _config.scrollTitleColor;
    self.scrollLabel.text = _config.scrollTitle;
    //[self addTapGesture:_testLabel];
    [backgroundView addSubview:self.scrollLabel];
    if (_config.scrollType == 2) {
        [self addTimer];
    } else {
        [self linearAnimation];
    }
    
    
}

- (void)linearAnimation {
    //CGRect frame = self.testLabel.frame;
    CGRect frame = _config.frame;
   
    [UIView animateWithDuration:_config.scrollVelocity delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        if (_config.scrollType == 0) {
            self.scrollLabel.frame = CGRectMake(label_x + width, label_y, width, height);
        } else if (_config.scrollType == 1) {
            self.scrollLabel.frame = CGRectMake(label_x, label_y + height, width, height);
        } else {
            self.scrollLabel.frame = CGRectMake(-frame.size.width, frame.origin.y, width, height);
        }
        
        /*
        if (_config.scrollType == 0) {
            self.scrollLabel.frame = CGRectMake(-frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
        } else if (_config.scrollType == 1) {
            self.scrollLabel.frame = CGRectMake(frame.origin.x, frame.size.height, frame.size.width, frame.size.height);
        } else {
            self.scrollLabel.frame = CGRectMake(-frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
        }
        */
        
    } completion:^(BOOL finished) {
        //CGRect mainRect = [[UIScreen mainScreen] bounds];
        if (_config.scrollType == 0) {
            self.scrollLabel.frame = CGRectMake(label_x - width, label_y, width, height);
        } else if (_config.scrollType == 1) {
            self.scrollLabel.frame = CGRectMake(label_x, label_y - height, width, height);
        } else {
            self.scrollLabel.frame = CGRectMake(-frame.size.width, frame.origin.y, width, height);
        }
        
        /*
        CGRect mainRect = _config.frame;

        CGFloat width = [self textWidth:_config.scrollTitle];
        if (_config.scrollType == 0) {
            self.scrollLabel.frame = CGRectMake(frame.size.width, frame.origin.y, width, frame.size.height);
        } else if (_config.scrollType == 1) {
            self.scrollLabel.frame = CGRectMake(frame.origin.x, -frame.size.height, width, frame.size.height);
        } else {
            self.scrollLabel.frame = CGRectMake(-frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
        }
         */
        
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
#pragma mark - Scroll begin & end
- (void)beginScrolling {
    
}

- (void)endScrolling {
    
}

/** Timer */
- (void)addTimer {
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeLabelPos) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
}

- (void)changeLabelPos {
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        //self.scrollLabel.frame = CGRectMake(label_x, label_y, width, height);
        label_y += 50;
    } completion:^(BOOL finished) {
        self.scrollLabel.frame = CGRectMake(label_x, label_y, width, height);
        if (label_y > _config.scrollInset.top + height) {
            label_y = _config.scrollInset.top - height;
        }
        
    }];
    
}

@end
