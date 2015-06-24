//
//  RadialMenu.m
//  Thirteen23RadialMenu
//
//  Created by Brian Sinnicke on 6/22/15.
//  Copyright (c) 2015 Brian Sinnicke. All rights reserved.
//

#import "RadialMenu.h"

@interface RadialMenu()
@property (strong, nonatomic) UIView *centerView;
@property (strong, nonatomic) UIButton *topButton;
@property (strong, nonatomic) UIButton *bottomButton;
@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) UIButton *leftButton;
@property (nonatomic, readwrite) CGPoint centerLocation;
@end

@implementation RadialMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}
- (instancetype)initWithLocation:(CGPoint)location andScreen:(ScreenIndex)screen
{
    self = [super initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self)
    {
        [self setupItemsForLocation:location andScreen:screen];
        
        self.centerLocation = location;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:pan];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
-(void)setupItemsForLocation:(CGPoint)location andScreen:(ScreenIndex)screen
{
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.centerView.backgroundColor = [UIColor clearColor];
    self.centerView.center = location;
    self.centerView.layer.cornerRadius = self.centerView.frame.size.width / 2;
    [self addSubview:self.centerView];
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.rightButton.center = location;
    self.rightButton.layer.cornerRadius = self.rightButton.frame.size.width / 2;
    self.rightButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.rightButton.layer.borderWidth = 2.0f;
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.rightButton];
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.leftButton.center = location;
    self.leftButton.layer.cornerRadius = self.leftButton.frame.size.width / 2;
    self.leftButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.leftButton.layer.borderWidth = 2.0f;
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.leftButton];
    
    self.topButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.topButton.center = location;
    self.topButton.layer.cornerRadius = self.topButton.frame.size.width / 2;
    self.topButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.topButton.layer.borderWidth = 2.0f;
    [self.topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.topButton];
    
    self.bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.bottomButton.center = location;
    self.bottomButton.layer.cornerRadius = self.bottomButton.frame.size.width / 2;
    self.bottomButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.bottomButton.layer.borderWidth = 2.0f;
    [self.bottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.bottomButton];
    
    if (location.x > ([UIScreen mainScreen].bounds.size.width / 2))
    {
        [self.rightButton setHidden:YES];
    }
    else
    {
        [self.leftButton setHidden:YES];
    }
    [self setupScreen:screen];
}
-(void)setupScreen:(ScreenIndex)screen
{
    switch (screen)
    {
        case ScreenIndexHome:
        {
            [self.topButton setTitle:@"1" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"2" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"2" forState:UIControlStateNormal];
            [self.bottomButton setTitle:@"3" forState:UIControlStateNormal];
            break;
        }
        case ScreenIndexOne:
        {
            [self.topButton setTitle:@"h" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"2" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"2" forState:UIControlStateNormal];
            [self.bottomButton setTitle:@"3" forState:UIControlStateNormal];
            break;
        }
        case ScreenIndexTwo:
        {
            [self.topButton setTitle:@"1" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"h" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"h" forState:UIControlStateNormal];
            [self.bottomButton setTitle:@"3" forState:UIControlStateNormal];
            break;
        }
        case ScreenIndexThree:
        {
            [self.topButton setTitle:@"1" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"2" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"2" forState:UIControlStateNormal];
            [self.bottomButton setTitle:@"h" forState:UIControlStateNormal];
            break;
        }
        default:
        {
            break;
        }
    }
}
-(void)showAnimated
{
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.rightButton.center = CGPointMake(self.centerLocation.x+50,self.centerLocation.y);
        self.leftButton.center = CGPointMake(self.centerLocation.x-50,self.centerLocation.y);
        self.topButton.center = CGPointMake(self.centerLocation.x,self.centerLocation.y-50);
        self.bottomButton.center = CGPointMake(self.centerLocation.x,self.centerLocation.y+50);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hideAnimated
{
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.rightButton.center = self.centerLocation;
        self.leftButton.center = self.centerLocation;
        self.topButton.center = self.centerLocation;
        self.bottomButton.center = self.centerLocation;
    } completion:^(BOOL finished) {
        self.alpha = 0;
        [self removeFromSuperview];
    }];
}
-(void)handleTap:(UITapGestureRecognizer *)tap
{
    [self hideAnimated];
}
-(void)handlePan:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [pan locationInView:self];
        UIButton *btn = nil;
        
        if (CGRectContainsPoint(self.rightButton.frame, location))
        {
            NSLog(@"RIGHT");
            btn = self.rightButton;
        }
        else if (CGRectContainsPoint(self.leftButton.frame, location))
        {
            NSLog(@"LEFT");
            btn = self.leftButton;
        }
        else if (CGRectContainsPoint(self.topButton.frame, location))
        {
            NSLog(@"TOP");
            btn = self.topButton;
        }
        else if (CGRectContainsPoint(self.bottomButton.frame, location))
        {
            NSLog(@"BOTTOM");
            btn = self.bottomButton;
        }
        
        if (self.delegate != nil)
        {
            if ([self.delegate respondsToSelector:@selector(selectedButtonAtScreenIndex:)])
            {
                if (btn)
                {
                    [self.delegate selectedButtonAtScreenIndex:[self screenIndexForButton:btn]];
                    [self hideAnimated];
                }
            }
        }
    }
}
-(ScreenIndex)screenIndexForButton:(UIButton *)button
{
    NSString *title = button.titleLabel.text;
    if ([title isEqualToString:@"h"])
    {
        return ScreenIndexHome;
    }
    else
    {
        return (ScreenIndex)[title intValue];
    }
}
@end
