//
//  MarqueeBannerViewController.m
//  MarqueeText
//
//  Created by Alice Jin on 17/11/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "MarqueeBannerViewController.h"
#import "LMMarqueeView.h"
#import "LMMarqueeConfig.h"

@interface MarqueeBannerViewController ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic, strong) NSString *scrollText;

@end

@implementation MarqueeBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addScrollBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)addScrollBanner {
    LMMarqueeConfig *config = [[LMMarqueeConfig alloc] init];
    config.scrollTitle = @"hahahahahahahahahahahfkhfjkahfkjhsakshjksahfkhskafhahfkshjakfj";
    config.scrollType = 0;
    //config.scrollVelocity = 8;
    config.scrollTitleColor = [UIColor blueColor];
    config.scrollBackgroundColor = [UIColor greenColor];
    config.frame = CGRectMake(5, 20, 300, 150);
    //config.scrollInset = 0; //what's this??
    //config.scrollSpace = 50;
    //config.textAlignment =
    config.font = [UIFont systemFontOfSize:16];
    //config.autoWidth = NO;
    
    LMMarqueeView *marqueeView = [[LMMarqueeView alloc] initWithConfig:config];
    [marqueeView setFrame:CGRectMake(5, 20, 300, 60)];
    [self.view addSubview:marqueeView];
    
    //MarqueeBanner2
    LMMarqueeConfig *config1 = [[LMMarqueeConfig alloc] init];
    config1.scrollTitle = @"hahahahahahahahahahahfkhfjkahfkjhsakshjksahfkhskafhahfkshjakfj";
    config1.scrollType = 1;
    //config.scrollVelocity = 8;
    config1.scrollTitleColor = [UIColor yellowColor];
    config1.scrollBackgroundColor = [UIColor greenColor];
    config1.frame = CGRectMake(5, 170, 300, 60);
    //config1.scrollInset = 0; //what's this??
    //config1.scrollSpace = 50;
    //config1.textAlignment =
    config1.font = [UIFont systemFontOfSize:14];
    //config1.autoWidth = NO;
    
    LMMarqueeView *marqueeView1 = [[LMMarqueeView alloc] initWithConfig:config1];
    [marqueeView1 setFrame:CGRectMake(5, 170, 300, 150)];
    [self.view addSubview:marqueeView1];
    
}

/*
-(void)scrollAnimation {
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, mainRect.size.width, 100)];
    bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView];
    self.scrollText = @"hahahahahhahahahahahahahahahahahahahahahahaha";
    CGFloat width = [self textWidth:self.scrollText];
    self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,60,width,30)];
    self.testLabel.backgroundColor = [UIColor clearColor];
    self.testLabel.text = self.scrollText;
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
        CGFloat width = [self textWidth:self.scrollText];
        self.testLabel.frame = CGRectMake(mainRect.size.width, 60, width, 30);
        [self linearAnimation];
    }];
}

- (CGFloat)textWidth:(NSString *)text {
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]} context:nil].size;
    return size.width;
}
*/

@end
