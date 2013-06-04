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
    NSInteger blockViewsCount = [[self subviews] count];
    CXAdjustBlockView *previousBlockView = nil;
    CXAdjustBlockView *currentBlockView = nil;
    CXAdjustBlockView *nextBlockView = nil;
    
    for (int i = 0 ; i < blockViewsCount; i++)
    {
        currentBlockView = [[self subviews] objectAtIndex:i];
        for (UIView *targetView in [currentBlockView subviews])
        {
            if ([targetView isEqual:view])
            {
                [targetView setFrame:CGRectMake(0, 0, 0, 0)];
                if (i != 0)
                {
                    previousBlockView = [[self subviews] objectAtIndex:(i - 1)];
                }
                
                if (i != (blockViewsCount - 1))
                {
                    nextBlockView = [[self subviews] objectAtIndex:(i + 1)];
                    //                    [nextBlockView setLinstener:previousBlockView];
                }
                break;
            }
        }
    }
    //    [blockviews removeObject:currentBlockView];
    //    [currentBlockView removeCurrentBlockScrollView];
}

- (CGRect)frameOfBlockvie:(UIView *)view
{
    
}
@end
