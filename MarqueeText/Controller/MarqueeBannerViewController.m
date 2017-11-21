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

@interface MarqueeBannerViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic, strong) NSString *scrollText;

@end

@implementation MarqueeBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //self.view.backgroundColor = [UIColor blueColor];
    [self addScrollBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)addScrollBanner {
    LMMarqueeConfig *config = [[LMMarqueeConfig alloc] init];
    config.scrollTitle = @"hahahah";
    config.scrollType = 0;
    config.scrollVelocity = 3;
    config.scrollTitleColor = [UIColor blueColor];
    config.scrollBackgroundColor = [UIColor lightGrayColor];
    config.frame = CGRectMake(10, 40, [UIScreen mainScreen].bounds.size.width - 20, 40);
    config.scrollInset = UIEdgeInsetsMake(5, 5, 5, 5);
    config.scrollSpace = 50;
    config.textAlignment = NSTextAlignmentRight;
    config.font = [UIFont systemFontOfSize:16];
    config.autoWidth = YES;
    
    LMMarqueeView *marqueeView = [[LMMarqueeView alloc] initWithConfig:config];
    [self.view addSubview:marqueeView];
    
    /** MarqueeBanner1 */
    LMMarqueeConfig *config1 = [[LMMarqueeConfig alloc] init];
    config1.scrollTitle = @"hahahahahahahahahahahfkhfjkahfkjhsakshjksahfkhskafhahfkshjakfjtyuiklkjbvcxcvbnm,jytrewsxcvbnkloiuytrewasxcvbnmkiuytrecvbnkuytrf";
    config1.scrollType = 1;
    config1.scrollVelocity = 10;
    config1.scrollTitleColor = [UIColor purpleColor];
    config1.scrollBackgroundColor = [UIColor greenColor];
    config1.frame = CGRectMake(10, 140, [UIScreen mainScreen].bounds.size.width - 20, 40);
    //config1.scrollSpace = 50;
    config1.textAlignment = NSTextAlignmentCenter;
    config1.font = [UIFont systemFontOfSize:14];
    config1.autoWidth = YES;
    
    LMMarqueeView *marqueeView1 = [[LMMarqueeView alloc] initWithConfig:config1];
    //[marqueeView1 setFrame:CGRectMake(5, 170, 300, 150)];
    [self.view addSubview:marqueeView1];
    
    /** MarqueeBanner2 */
    LMMarqueeConfig *config2 = [[LMMarqueeConfig alloc] init];
    config2.scrollTitle = @"hahahahahahahahahahahfkhfjkahfkjhsakshjksahfkhskafhahfkshjakfjfghjk,mnbvcxsdfkl;lmnbvcxfghjk,mnbvc";
    config2.scrollType = 2;
    config2.scrollVelocity = 2;
    config2.scrollTitleColor = [UIColor orangeColor];
    config2.scrollBackgroundColor = [UIColor yellowColor];
    config2.frame = CGRectMake(10, 240, [UIScreen mainScreen].bounds.size.width - 20, 40);
    //config2.scrollInset = 0; //what's this??
    //config2.scrollSpace = 50;
    config2.textAlignment = NSTextAlignmentLeft;
    config2.font = [UIFont systemFontOfSize:14];
    config2.autoWidth = YES;
    
    LMMarqueeView *marqueeView2 = [[LMMarqueeView alloc] initWithConfig:config2];
    //[marqueeView1 setFrame:CGRectMake(5, 170, 300, 150)];
    [self.view addSubview:marqueeView2];
    
    /** MarqueeBanner3 */
    LMMarqueeConfig *config3 = [[LMMarqueeConfig alloc] init];
    config3.scrollTitle = @"hahahahahahahahahahahfkhfjkahfkjhsakshjksahfkhskafhahfkshjakfjdfghjkllmnbvcxxcvbnm,.kjhgfdsasdfghjkloiuytrewscvbnm,;oiuytresxcvbnm,liuytreshahahahahahahahahahahfkhfjkahfkjhsakshjksahfkhskafhahfkshjakfjdfghjkllmnbvcxxcvbnm,.kjhgfdsasdfghjkloiuytrewscvbnm,;oiuytresxcvbnm,liuytreshahahahahahahahahahahfkhfjkahfkjhsakshjksahfkhskafhahfkshjakfjdfghjkllmnbvcxxcvbnm,.kjhgfdsasdfghjkloiuytrewscvbnm,;oiuytresxcvbnm,liuytres";
    config3.scrollType = 3;
    config3.scrollVelocity = 2;
    config3.scrollTitleColor = [UIColor blackColor];
    config3.scrollBackgroundColor = [UIColor redColor];
    config3.frame = CGRectMake(10, 340, [UIScreen mainScreen].bounds.size.width - 20, 40);;
    //config2.scrollInset = 0;
    //config2.scrollSpace = 50;
    config3.textAlignment = NSTextAlignmentRight;
    config3.font = [UIFont systemFontOfSize:14];
    config2.autoWidth = YES;
    
    LMMarqueeView *marqueeView3 = [[LMMarqueeView alloc] initWithConfig:config3];
    [self.view addSubview:marqueeView3];
    
}

@end
