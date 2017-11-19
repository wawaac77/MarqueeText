//
//  ViewController.m
//  MarqueeText
//
//  Created by Alice Jin on 15/11/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "ViewController.h"
#import "MarqueeBannerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 100, 50)];
    [startButton setTitle:@"Start" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClicked {
    MarqueeBannerViewController *marqueVC = [[MarqueeBannerViewController alloc] init];
    [self.navigationController pushViewController:marqueVC animated:YES];
}


@end
