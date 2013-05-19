//
//  CXAdjustBlockView.m
//  CXAdjustBlockViewDemo
//
//  Created by ChrisXu on 13/5/8.
//  Copyright (c) 2013年 ChrisXu. All rights reserved.
//

#import "CXAdjustBlockView.h"
#import <QuartzCore/QuartzCore.h>

@interface CXAdjustBlockView ()
{
    CGFloat maxOffsetYOfSubview;
}
@property (nonatomic, assign) UIView *linstenerView;

- (void)updateLayoutFromLinstener:(NSNotification *)notify;

@end

@implementation CXAdjustBlockView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        maxOffsetYOfSubview = CGRectGetMaxY(self.frame);
    }
    return self;
}

- (id)initWithLinstenerView:(UIView *)view
{
    self = [super init];
    if (self)
    {
        self.duration = 0.3;
        self.linstenerView = view;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLayoutFromLinstener:) name:CXAdjustBlockViewUpdated object:view];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateLayout];
}

#pragma mark - PV
- (void)updateLayoutFromLinstener:(NSNotification *)notify
{
    if ([[notify object] isEqual:self.linstenerView])
    {
        [self updateLayout];
    }
}


#pragma mark - PB
- (void)updateLayout
{
    BOOL hasSubview = NO;
    for (UIView *subview in [self subviews])
    {
        hasSubview = YES;
        if (CGRectGetMaxY(subview.frame) != maxOffsetYOfSubview)
        {
            maxOffsetYOfSubview = CGRectGetMaxY(subview.frame);
        }
    }
    CGFloat newHeight = hasSubview ? maxOffsetYOfSubview : self.frame.size.height;
    CGRect updateFrame = self.frame;
    CGSize newSize = CGSizeMake(self.frame.size.width, newHeight);
    if (self.linstenerView)
    {
        updateFrame.origin = CGPointMake(self.frame.origin.x, CGRectGetMaxY(self.linstenerView.frame));
    }
    updateFrame.size = newSize;
    [UIView animateWithDuration:self.duration animations:^{
        [self setFrame:updateFrame];
        
    } completion:^(BOOL finished)
     {
         
     }];
    [[NSNotificationCenter defaultCenter] postNotificationName:CXAdjustBlockViewUpdated object:self];
}

@end
