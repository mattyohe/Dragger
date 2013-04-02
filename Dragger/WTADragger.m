//
//  WTADragger.m
//  Dragger
//
//  Created by Matt Yohe on 4/1/13.
//  Copyright (c) 2013 Matt Yohe. All rights reserved.
//

#import "WTADragger.h"
#import "UIView+Helpers.h"

@interface WTADragger ()
{
    UIPanGestureRecognizer *_panGesture;
    UIView *_dragger;
    UIView *_background;
}

@end

@implementation WTADragger

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"Setting up from initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialSetup];
        [self setupViewsWithFrame:frame];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"Setting up from initWithCoder");
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialSetup];
    }
    return self;
}

-(void)awakeFromNib
{
    NSLog(@"Frame inside awakeFromNib: %@",NSStringFromCGRect(self.frame));
    [self setupViewsWithFrame:self.frame];
}

-(void)initialSetup
{
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
}

-(void)setupViewsWithFrame:(CGRect)frame
{
    NSLog(@"Setup frame: %@",NSStringFromCGRect(frame));
    [self showDebugFrame];
    
    _dragger = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, self.frameSizeHeight)];
    [_dragger setBackgroundColor:[UIColor greenColor]];
    [self addSubview:_dragger];
    [_dragger addGestureRecognizer:_panGesture];
}

-(void)pan:(UIPanGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self];
    int xmin = CGRectGetMinX(self.bounds);
    int xmax = CGRectGetMaxX(self.bounds) - _dragger.frameSizeWidth;
    
    CGFloat draggerX = (location.x - _dragger.frame.size.width/2);
    
    draggerX = MAX(xmin, draggerX);
    draggerX = MIN(xmax, draggerX);
    
    BOOL isAtEnd = (location.x + _dragger.frameSizeWidth/2 >= CGRectGetMaxX(self.bounds)) ? YES : NO;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            
            [_dragger setFrameOriginX:draggerX];
        }
            
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            [_dragger setFrameOriginX:draggerX];
            if (isAtEnd) {
                NSLog(@"At End");
                [gesture setEnabled:NO];
                [self sendActionsForControlEvents:UIControlEventValueChanged];
                [_dragger setFrameOriginX:0];
                [gesture setEnabled:YES];
            }
        }
            break;
            
        case UIGestureRecognizerStateFailed:
            
            NSLog(@"Failed");
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"Cancelled");
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            [UIView animateWithDuration:0.2 animations:^{
                [_dragger setFrameOriginX:0];
            }];
            
        }
            
            break;
            
        default:
            break;
    }
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
