//
//  CXViewController.m
//  CXAdjustBlockViewDemo
//
//  Created by ChrisXu on 13/5/8.
//  Copyright (c) 2013年 ChrisXu. All rights reserved.
//

#import "CXViewController.h"
#import "CXBlockScrollView.h"
#import <QuartzCore/QuartzCore.h>

@interface CXViewController ()
<CXBlockScrollViewDelegate>
{
    NSMutableArray *blockViews;
    
    CXBlockScrollView *scrollview;
    
    NSInteger number;
}

- (void)addDemoBlockview;

- (void)insertDemoBlockview;

- (void)demoBlockviewTapAction:(UITapGestureRecognizer *)tap;

- (void)demoBlockviewSwipAction:(UISwipeGestureRecognizer *)swip;

@end

@implementation CXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    number = 0;
        
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDemoBlockview)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(insertDemoBlockview)];
    
    scrollview = [[CXBlockScrollView alloc] initWithFrame:self.view.frame];
    [scrollview setBlocksDelegate:self];
    [scrollview setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:scrollview];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    for (int i = 0; i < 4; i++)
    {
        [self addDemoBlockview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (void)addDemoBlockview
{
    NSString *title = [NSString stringWithFormat:@"Blockview #%i",number];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( 20, 0, 280, 50)];
    [label setText:title];
    [label setFont:[UIFont systemFontOfSize:14.]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setUserInteractionEnabled:YES];
    
    [label.layer setMasksToBounds:YES];
    [label.layer setCornerRadius:4.0];
    [label.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1, 1, 1 });
    [label.layer setBorderColor:colorref];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(demoBlockviewTapAction:)];
    [label addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(demoBlockviewSwipAction:)];
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [label addGestureRecognizer:swip];
    
    [scrollview addBlockview:label withSpacing:10];
        
    number ++;
}

- (void)insertDemoBlockview
{
    NSString *title = [NSString stringWithFormat:@"Blockview #%i",number];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( 20, 0, 280, 50)];
    [label setText:title];
    [label setFont:[UIFont systemFontOfSize:14.]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setUserInteractionEnabled:YES];
    
    [label.layer setMasksToBounds:YES];
    [label.layer setCornerRadius:4.0];
    [label.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1, 1, 1 });
    [label.layer setBorderColor:colorref];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(demoBlockviewTapAction:)];
    [label addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(demoBlockviewSwipAction:)];
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [label addGestureRecognizer:swip];
    
    [scrollview insertBlockview:label atIndex:1 withSpacing:10];
    
    number ++;
}

- (void)demoBlockviewTapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"--Size Change--");
    UILabel *label = (UILabel *)tap.view;
    
    if (label.frame.size.height == 50)
    {
        [UIView animateWithDuration:0.3 animations:^{
            [label setFrame:CGRectMake(20, 0, 280, 100)];
        }];
    }
    else
    {
        [label setFrame:CGRectMake(20, 0, 280, 50)];
    }
}

- (void)demoBlockviewSwipAction:(UISwipeGestureRecognizer *)swip
{
    NSLog(@"--Remove--");
    UILabel *label = (UILabel *)swip.view;
        
    [label setBackgroundColor:[UIColor redColor]];
    [UIView animateWithDuration:0.3 animations:^{
        [label setAlpha:0.];
    }completion:^(BOOL finished) {
        [scrollview removeBlockview:label];
    }];
}

#pragma mark - CXBlockScrollViewDelegate
- (void)blockScrollView:(CXBlockScrollView *)scrollview didAnimatedAtIndex:(NSUInteger)index frame:(CGRect)frame;
{
    
}
@end
