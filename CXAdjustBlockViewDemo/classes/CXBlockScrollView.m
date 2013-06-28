//
//  CXBlockScrollView.m
//  CXAdjustBlockViewDemo
//
//  Created by ChrisXu on 13/5/8.
//  Copyright (c) 2013年 ChrisXu. All rights reserved.
//

#import "CXBlockScrollView.h"
#import "CXAdjustBlockView.h"

@interface CXBlockScrollView ()
{
    NSInteger bvTotalCount;
    NSMutableArray *blockviews;
}

- (void)lastBlockviewDidFinishUpdated:(NSNotification *)notify;
- (void)updateContentSize;

@end

@implementation CXBlockScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        blockviews = [[NSMutableArray alloc] init];
        bvTotalCount = 0;
    }
    return self;
}

#pragma mark - PV
- (void)lastBlockviewDidFinishUpdated:(NSNotification *)notify
{
    if ([notify object] == [blockviews lastObject])
    {
        [self updateContentSize];
    }
}

- (void)updateContentSize
{
    CXAdjustBlockView *lastBlockView = [blockviews lastObject];
    CGFloat height = 0;
    height = CGRectGetMaxY(lastBlockView.frame);
    [self setContentSize:CGSizeMake(self.bounds.size.width, height)];
}

#pragma mark - PB
- (void)addBlockview:(UIView *)view withSpacing:(NSUInteger)spacing;
{
    CXAdjustBlockView *lastBlockView = [blockviews lastObject];
    CXAdjustBlockView *blockView = [[CXAdjustBlockView alloc] initWithLinstenerView:lastBlockView];
    blockView.bvID = bvTotalCount;
    blockView.spacing = spacing;
    
    bvTotalCount ++;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CXAdjustBlockViewUpdated object:lastBlockView];
    
    CGFloat offsetY = lastBlockView == nil ? 0 : CGRectGetMaxY(lastBlockView.frame);
    [blockView setFrame:CGRectMake( 0, offsetY, self.bounds.size.width, view.frame.size.height + spacing)];
    CGRect replaceFrame = CGRectZero;
    replaceFrame.origin = CGPointMake(view.frame.origin.x, 0);
    replaceFrame.size   = view.frame.size;
    [view setFrame:replaceFrame];
    
    [blockView addSubview:view];
    [blockView setBackgroundColor:[UIColor clearColor]];
    
    [blockviews addObject:blockView];
    [self addSubview:blockView];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lastBlockviewDidFinishUpdated:) name:CXAdjustBlockViewUpdated object:blockView];
}

- (void)removeBlockview:(UIView *)view
{
    NSInteger blockViewsCount = [blockviews count];
    CXAdjustBlockView *previousBlockView = nil;
    CXAdjustBlockView *currentBlockView = nil;
    CXAdjustBlockView *nextBlockView = nil;
    BOOL _exist = NO;
    
    for (int i = 0 ; i < blockViewsCount; i++)
    {
        currentBlockView = [blockviews objectAtIndex:i];
        for (UIView *targetView in [currentBlockView subviews])
        {
            if ([targetView isEqual:view])
            {
                _exist = YES;
                if (i != 0)
                {
                    previousBlockView = [blockviews objectAtIndex:(i - 1)];
                }
                
                if (i != (blockViewsCount - 1))
                {
                    nextBlockView = [blockviews objectAtIndex:(i + 1)];
                    [nextBlockView setLinstener:previousBlockView];
                }
                else
                {
                    [[NSNotificationCenter defaultCenter] removeObserver:self name:CXAdjustBlockViewUpdated object:currentBlockView];
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lastBlockviewDidFinishUpdated:) name:CXAdjustBlockViewUpdated object:previousBlockView];
                }
                
                break;
            }
        }
        
        if (_exist)
        {
            break;
        }
    }
    [currentBlockView removeFromSuperview];
    [blockviews removeObject:currentBlockView];
    
    if (previousBlockView)
    {
        [previousBlockView updateLayout];
    }
    else
    {
        [UIView animateWithDuration:nextBlockView.duration animations:^{
            [nextBlockView setFrame:CGRectMake( 0, 0, self.bounds.size.width, nextBlockView.frame.size.height)];
        }];
        [nextBlockView updateLayout];
    }
}

- (CGRect)frameOfBlockview:(UIView *)view
{
    NSInteger blockViewsCount = [[self subviews] count];
    CXAdjustBlockView *currentBlockView = nil;
    for (int i = 0 ; i < blockViewsCount; i++)
    {
        currentBlockView = [[self subviews] objectAtIndex:i];
        for (UIView *targetView in [currentBlockView subviews])
        {
            if ([targetView isEqual:view])
            {
                return currentBlockView.frame;
            }
        }
    }
    
    return CGRectZero;
}
@end
