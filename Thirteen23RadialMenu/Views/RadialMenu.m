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
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
        longPressGesture.minimumPressDuration = 0.01f;
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}
-(void)setupButtons
{
    // TODO: Boilerplate
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.leftButton.backgroundColor = [UIColor whiteColor];
    self.leftButton.layer.cornerRadius = self.leftButton.frame.size.width / 2;
    self.leftButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.leftButton.layer.borderWidth = 2.0f;
    self.leftButton.alpha = 0;
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.leftButton];
    [self bringSubviewToFront:self.leftButton];
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.rightButton.backgroundColor = [UIColor whiteColor];
    self.rightButton.layer.cornerRadius = self.rightButton.frame.size.width / 2;
    self.rightButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.rightButton.layer.borderWidth = 2.0f;
    self.rightButton.alpha = 0;
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.rightButton];
    [self bringSubviewToFront:self.rightButton];
    
    self.topButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.topButton.backgroundColor = [UIColor whiteColor];
    self.topButton.layer.cornerRadius = self.topButton.frame.size.width / 2;
    self.topButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.topButton.layer.borderWidth = 2.0f;
    self.topButton.alpha = 0;
    [self.topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.topButton];
    
    self.bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.bottomButton.backgroundColor = [UIColor whiteColor];
    self.bottomButton.layer.cornerRadius = self.bottomButton.frame.size.width / 2;
    self.bottomButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.bottomButton.layer.borderWidth = 2.0f;
    self.bottomButton.alpha = 0;
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
    if (CGPointEqualToPoint(self.centerLocation, location))
    {
        return;
    }
    
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
    // TODO: Boilerplate
    self.rightButton.center = self.centerLocation;
    self.leftButton.center = self.centerLocation;
    self.topButton.center = self.centerLocation;
    self.bottomButton.center = self.centerLocation;
    // TODO: Boilerplate
    self.rightButton.alpha = 1.0f;
    self.leftButton.alpha = 1.0f;
    self.topButton.alpha = 1.0f;
    self.bottomButton.alpha = 1.0f;
    
    [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        // TODO: Boilerplate
        self.rightButton.center = CGPointMake(self.centerLocation.x+50,self.centerLocation.y);
        self.leftButton.center = CGPointMake(self.centerLocation.x-50,self.centerLocation.y);
        self.topButton.center = CGPointMake(self.centerLocation.x,self.centerLocation.y-50);
        self.bottomButton.center = CGPointMake(self.centerLocation.x,self.centerLocation.y+50);
        self.backgroundColor = [self darkBackgroundColor];
    } completion:nil];
    
}
-(void)hideAnimated:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // TODO: Boilerplate
        self.rightButton.center = self.centerLocation;
        self.leftButton.center = self.centerLocation;
        self.topButton.center = self.centerLocation;
        self.bottomButton.center = self.centerLocation;
    } completion:^(BOOL finished) {
       // TODO: Boilerplate
        self.rightButton.alpha = 0;
        self.leftButton.alpha = 0;
        self.topButton.alpha = 0;
        self.bottomButton.alpha = 0;
        self.backgroundColor = [self defaultBackgroundColor];
        completion(finished);
    }];
}
-(void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPress
{
    CGPoint location = [longPress locationInView:self];
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        [self showAnimatedAtLocation:location];
    }
    else if(longPress.state == UIGestureRecognizerStateEnded)
    {
        [self handleTouchDown:location];
    }
}
-(void)handleTouchDown:(CGPoint)location
{
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
-(UIColor *)darkBackgroundColor
{
    return [UIColor darkGrayColor];
}
-(UIColor *)defaultBackgroundColor
{
    return [UIColor colorWithWhite:1.000 alpha:0.000];
}
@end
