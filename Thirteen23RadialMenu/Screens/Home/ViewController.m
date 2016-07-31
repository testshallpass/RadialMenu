//
//  ViewController.m
//  Thirteen23RadialMenu
//
//  Created by Brian Sinnicke on 6/22/15.
//  Copyright (c) 2015 Brian Sinnicke. All rights reserved.
//

#import "ViewController.h"
#import "RadialMenu.h"

#define FONT_SIZE 150.0f
#define ANIMATION_DURATION 0.5f

@interface ViewController () <RadialMenuDelegate>
@property (strong, nonatomic) RadialMenu *menu;
@property (strong, nonatomic) UILabel *label;
@end

@implementation ViewController
#pragma mark - Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.label = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.label.text = @"h";
    self.label.font = [UIFont boldSystemFontOfSize:FONT_SIZE];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    self.menu = [[RadialMenu alloc] initWithScreen:ScreenIndexHome];
    self.menu.delegate = self;
    [self.view addSubview:self.menu];

    self.view.backgroundColor = [UIColor purpleColor];
}
#pragma mark - Radial Menu Delegate
-(void)touchedButtonWithScreenText:(NSString *)text andDirection:(ScreenDirection)direction
{
    self.label.text = text;
    [self moveLabelForDirection:direction];
}
#pragma mark - Animation Move Label
-(void)moveLabelForDirection:(ScreenDirection)direction
{
    float dx = 0;
    float dy = 0;
    UIColor *color;
    
    switch (direction)
    {
        case ScreenDirectionUp:
        {
            dx = 0;
            dy = self.view.frame.size.height;
            break;
        }
        case ScreenDirectionDown:
        {
            dx = 0;
            dy = -(self.view.frame.size.height);
            break;
        }
        case ScreenDirectionRight:
        {
            dx = self.view.frame.size.width;
            dy = 0;
            break;
        }
        case ScreenDirectionLeft:
        {
            dx = -(self.view.frame.size.width);
            dy = 0;
            break;
        }
        default:
        {
            dx=0;
            dy=0;
            break;
        }
    }
    if ([self.label.text isEqualToString:@"h"])
    {
        color = [UIColor purpleColor];
    }
    else
    {
        ScreenIndex screenIndex = [self.label.text intValue];
        switch (screenIndex)
        {
            case ScreenIndexOne:
                color = [UIColor blueColor];
                break;
            case ScreenIndexTwo:
                color = [UIColor redColor];
                break;
            case ScreenIndexThree:
                color = [UIColor greenColor];
                break;
            default:
                 color = [UIColor purpleColor];
                break;
        }
    }
    self.label.frame = CGRectMake(dx, dy, self.label.frame.size.width, self.label.frame.size.height);
    
    [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.label.frame = CGRectMake(0, 0, self.label.frame.size.width, self.label.frame.size.height);
        self.view.backgroundColor = color;
    } completion:^(BOOL finished) {
        
    }];
}
@end
