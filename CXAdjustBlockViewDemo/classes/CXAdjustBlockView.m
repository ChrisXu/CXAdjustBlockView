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
@property (nonatomic, assign) CXAdjustBlockView *linstenerView;

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

- (id)initWithLinstenerView:(CXAdjustBlockView *)view
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
    [self updateLayoutWithDelegate:YES];
}

#pragma mark - PV
- (void)updateLayoutFromLinstener:(NSNotification *)notify
{
    if ([[notify object] isEqual:self.linstenerView])
    {
        [self updateLayoutWithDelegate:YES];
    }
}


#pragma mark - PB
- (void)updateLayoutWithDelegate:(BOOL)need
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
    CGFloat newHeight = hasSubview ? maxOffsetYOfSubview + self.spacing : self.frame.size.height;
    CGRect updateFrame = self.frame;
    CGSize newSize = CGSizeMake(self.frame.size.width, newHeight);
    if (self.linstenerView)
    {
        updateFrame.origin = CGPointMake(self.frame.origin.x, CGRectGetMaxY(self.linstenerView.frame));
//        NSLog(@"%i --> %i",self.bvID,self.linstenerView.bvID);
    }
    updateFrame.size = newSize;
    [UIView animateWithDuration:self.duration animations:^{
        [self setFrame:updateFrame];
        
    } completion:^(BOOL finished)
     {
         if (need && [self.delegate respondsToSelector:@selector(blockViewDidUpdateFrameWithBVID:)])
         {
             [self.delegate blockViewDidUpdateFrameWithBVID:self.bvID];
         }
     }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CXAdjustBlockViewUpdated object:self];
}

- (void)setLinstener:(CXAdjustBlockView *)view
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CXAdjustBlockViewUpdated object:self.linstenerView];
    self.linstenerView = view;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLayoutFromLinstener:) name:CXAdjustBlockViewUpdated object:view];
}
@end
