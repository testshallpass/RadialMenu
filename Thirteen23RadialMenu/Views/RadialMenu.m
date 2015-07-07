//
//  RadialMenu.m
//  Thirteen23RadialMenu
//
//  Created by Brian Sinnicke on 6/22/15.
//  Copyright (c) 2015 Brian Sinnicke. All rights reserved.
//

#import "RadialMenu.h"

#define ANIMATION_DURATION 0.30f
#define BUTTON_BORDER_WIDTH 2.0f
#define BUTTON_SIZE 50.0f
#define BUTTON_COUNT 4
#define BUTTON_RADIUS 50.0f

@interface RadialMenu()
@property (nonatomic, readwrite) CGPoint centerLocation;
@property (nonatomic, readwrite) ScreenIndex screenIndex;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@end

@implementation RadialMenu

-(instancetype)initWithScreen:(ScreenIndex)screen
{
    self = [super initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self)
    {
        self.buttonArray = [NSMutableArray new];
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
    for(int index=0; index<BUTTON_COUNT; index++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_SIZE, BUTTON_SIZE)];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = button.frame.size.width / 2.0f;
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.layer.borderWidth = BUTTON_BORDER_WIDTH;
        button.alpha = 0.0f;
        button.tag = index;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
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
-(void)showAnimatedAtLocation:(CGPoint)location
{
    if (CGPointEqualToPoint(self.centerLocation, location))
    {
        return;
    }
    
    BOOL hideRight = (location.x > ([UIScreen mainScreen].bounds.size.width / 2));
    BOOL hideLeft = !(location.x > ([UIScreen mainScreen].bounds.size.width / 2));
    BOOL hideTop = (location.y < 154);
    BOOL hideBottom = (location.y > [UIScreen mainScreen].bounds.size.height-75);
    
    if (hideTop || hideBottom)
    {
        hideLeft = NO;
        hideRight = NO;
    }

    NSArray *statusArray = @[[NSNumber numberWithBool:hideRight],[NSNumber numberWithBool:hideLeft],[NSNumber numberWithBool:hideTop],[NSNumber numberWithBool:hideBottom]];
    self.centerLocation = location;
    [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        NSArray *titles = [self titlesForScreen:self.screenIndex];
        NSMutableArray *buttonsToShow = [NSMutableArray new];
        for (int index=0; index < self.buttonArray.count; index++)
        {
            UIButton *button = (UIButton *)[self.buttonArray objectAtIndex:index];
            if (index == 0) // right
            {
                button.center = CGPointMake(self.centerLocation.x+BUTTON_RADIUS,self.centerLocation.y);
            }
            else if (index == 1) // left
            {
                button.center = CGPointMake(self.centerLocation.x-BUTTON_RADIUS,self.centerLocation.y);
            }
            else if (index == 2) // top
            {
                button.center = CGPointMake(self.centerLocation.x,self.centerLocation.y-BUTTON_RADIUS);
            }
            else if (index == 3) // bottom
            {
                button.center = CGPointMake(self.centerLocation.x,self.centerLocation.y+BUTTON_RADIUS);
            }
            button.alpha = ![[statusArray objectAtIndex:index] intValue];
            if (button.alpha > 0)
            {
                [buttonsToShow addObject:button];
            }
        }
        int index = 0;
        for (UIButton *button in buttonsToShow)
        {
            [button setTitle:titles[index] forState:UIControlStateNormal];
            index++;
        }
        self.backgroundColor = [self darkBackgroundColor];
    } completion:nil];
    
}
-(void)hideAnimated:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        for (UIButton *button in self.buttonArray)
        {
            button.center = self.centerLocation;
        }
    } completion:^(BOOL finished) {
        for (UIButton *button in self.buttonArray)
        {
            button.alpha = 0.0f;
        }
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
    UIButton *touchedButton = nil;
    for (UIButton *button in self.buttonArray)
    {
        if (CGRectContainsPoint(button.frame, location))
        {
            touchedButton = button;
            break;
        }
    }
    if (self.delegate != nil)
    {
        if ([self.delegate respondsToSelector:@selector(selectedButtonAtScreenIndex:)])
        {
            if (touchedButton)
            {
                [self hideAnimated:^(BOOL finished) {
                    self.screenIndex = (ScreenIndex)[self screenIndexForButton:touchedButton];
                    [self.delegate selectedButtonAtScreenIndex:self.screenIndex];
                    
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
