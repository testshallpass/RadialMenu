//
//  RadialMenu.m
//  Thirteen23RadialMenu
//
//  Created by Brian Sinnicke on 6/22/15.
//  Copyright (c) 2015 Brian Sinnicke. All rights reserved.
//

#import "RadialMenu.h"

#define ANIMATION_DURATION 0.30f

@interface RadialMenu()
@property (strong, nonatomic) UIButton *topButton;
@property (strong, nonatomic) UIButton *bottomButton;
@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) UIButton *leftButton;
@property (nonatomic, readwrite) CGPoint centerLocation;
@property (nonatomic, readwrite) ScreenIndex screenIndex;
@end

@implementation RadialMenu

-(instancetype)initWithScreen:(ScreenIndex)screen
{
    self = [super initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self)
    {
        [self setupButtons];
        self.screenIndex = screen;

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:pan];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
-(void)setupButtons
{
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.leftButton.backgroundColor = [UIColor whiteColor];
    self.leftButton.layer.cornerRadius = self.leftButton.frame.size.width / 2;
    self.leftButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.leftButton.layer.borderWidth = 2.0f;
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.leftButton];
    [self bringSubviewToFront:self.leftButton];
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.rightButton.backgroundColor = [UIColor whiteColor];
    self.rightButton.layer.cornerRadius = self.rightButton.frame.size.width / 2;
    self.rightButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.rightButton.layer.borderWidth = 2.0f;
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.rightButton];
    [self bringSubviewToFront:self.rightButton];
    
    self.topButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.topButton.backgroundColor = [UIColor whiteColor];
    self.topButton.layer.cornerRadius = self.topButton.frame.size.width / 2;
    self.topButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.topButton.layer.borderWidth = 2.0f;
    [self.topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.topButton];
    
    self.bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.bottomButton.backgroundColor = [UIColor whiteColor];
    self.bottomButton.layer.cornerRadius = self.bottomButton.frame.size.width / 2;
    self.bottomButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.bottomButton.layer.borderWidth = 2.0f;
    [self.bottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.bottomButton];
}
-(NSArray *)titlesForScreen:(ScreenIndex)screen
{
    NSArray *args = [NSArray new];
    switch (screen)
    {
        case ScreenIndexHome:
        {
            args = @[@"1",@"2",@"3"];
            break;
        }
        case ScreenIndexOne:
        {
            args = @[@"h",@"2",@"3"];
            break;
        }
        case ScreenIndexTwo:
        {
            args = @[@"1",@"h",@"3"];
            break;
        }
        case ScreenIndexThree:
        {
            args = @[@"1",@"2",@"h"];
            break;
        }
    }
    return args;
}
-(void)setTitlesForScreen:(ScreenIndex)screen andButtons:(NSArray *)args
{
    NSArray *titles = [self titlesForScreen:screen];
    int index = 0;
    for (UIButton *button in args)
    {
        button.hidden = NO;
        [button setTitle:titles[index] forState:UIControlStateNormal];
        index++;
    }
}
-(void)showAnimatedAtLocation:(CGPoint)location
{
    NSMutableArray *buttonsToShow = @[self.leftButton,self.topButton,self.rightButton,self.bottomButton].mutableCopy;
   
    BOOL showLeft = (location.x > ([UIScreen mainScreen].bounds.size.width / 2));
    BOOL hideTop = (location.y < 154);
    BOOL hideBottom = (location.y > [UIScreen mainScreen].bounds.size.height-75);
    
    if (hideTop || hideBottom)
    {
        if (hideTop)
        {
            self.topButton.hidden = YES;
            [buttonsToShow removeObject:self.topButton];
        }
        if (hideBottom)
        {
            self.bottomButton.hidden = YES;
            [buttonsToShow removeObject:self.bottomButton];
        }
    }
    else
    {
        if (showLeft)
        {
            self.rightButton.hidden = YES;
            [buttonsToShow removeObject:self.rightButton];
        }
        else
        {
            self.leftButton.hidden = YES;
            [buttonsToShow removeObject:self.leftButton];
        }
    }

    [self setTitlesForScreen:self.screenIndex andButtons:buttonsToShow];
    
    self.centerLocation = location;
    self.rightButton.center = self.centerLocation;
    self.leftButton.center = self.centerLocation;
    self.topButton.center = self.centerLocation;
    self.bottomButton.center = self.centerLocation;
    
    self.rightButton.alpha = 1.0f;
    self.leftButton.alpha = 1.0f;
    self.topButton.alpha = 1.0f;
    self.bottomButton.alpha = 1.0f;
    
    [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.rightButton.center = CGPointMake(self.centerLocation.x+50,self.centerLocation.y);
        self.leftButton.center = CGPointMake(self.centerLocation.x-50,self.centerLocation.y);
        self.topButton.center = CGPointMake(self.centerLocation.x,self.centerLocation.y-50);
        self.bottomButton.center = CGPointMake(self.centerLocation.x,self.centerLocation.y+50);
        self.backgroundColor = [self darkBackground];
    } completion:nil];
    
}
-(void)hideAnimated:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.rightButton.center = self.centerLocation;
        self.leftButton.center = self.centerLocation;
        self.topButton.center = self.centerLocation;
        self.bottomButton.center = self.centerLocation;
    } completion:^(BOOL finished) {
        self.rightButton.alpha = 0;
        self.leftButton.alpha = 0;
        self.topButton.alpha = 0;
        self.bottomButton.alpha = 0;
        self.backgroundColor = [self defaultBackground];
        completion(finished);
    }];
}
-(void)handleTap:(UITapGestureRecognizer *)tap
{
    [self hideAnimated:^(BOOL finished) {
        
    }];
}
-(void)handlePan:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [pan locationInView:self];
        UIButton *btn = nil;
        
        if (CGRectContainsPoint(self.rightButton.frame, location))
        {
            btn = self.rightButton;
        }
        else if (CGRectContainsPoint(self.leftButton.frame, location))
        {
            btn = self.leftButton;
        }
        else if (CGRectContainsPoint(self.topButton.frame, location))
        {
            btn = self.topButton;
        }
        else if (CGRectContainsPoint(self.bottomButton.frame, location))
        {
            btn = self.bottomButton;
        }
        
        if (self.delegate != nil)
        {
            if ([self.delegate respondsToSelector:@selector(selectedButtonAtScreenIndex:)])
            {
                if (btn)
                {
                    [self hideAnimated:^(BOOL finished) {
                       [self.delegate selectedButtonAtScreenIndex:[self screenIndexForButton:btn]];
                    }];
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
-(UIColor *)darkBackground
{
    return [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
}
-(UIColor *)defaultBackground
{
    return [UIColor colorWithWhite:1.000 alpha:0.000];
}
@end
