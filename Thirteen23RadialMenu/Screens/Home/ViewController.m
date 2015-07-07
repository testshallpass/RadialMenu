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

#define HOME @"h"
#define ONE @"1"
#define TWO @"2"
#define THREE @"3"

typedef NS_ENUM(NSUInteger, ScreenDirection)
{
    ScreenDirectionUp,
    ScreenDirectionDown,
    ScreenDirectionRight,
    ScreenDirectionLeft
};

@interface ViewController () <RadialMenuDelegate>
@property (strong, nonatomic) RadialMenu *menu;
@property (strong, nonatomic) UILabel *screenLabel;
@end

@implementation ViewController
#pragma mark - Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.screenLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.screenLabel.text = HOME;
    self.screenLabel.font = [UIFont boldSystemFontOfSize:FONT_SIZE];
    self.screenLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.screenLabel];
    
    self.menu = [[RadialMenu alloc] initWithScreen:ScreenIndexHome];
    self.menu.delegate = self;
    [self.view addSubview:self.menu];
    
    self.navigationItem.hidesBackButton = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - Radial Menu Delegate
-(void)selectedButtonAtScreenIndex:(ScreenIndex)index
{
    switch (index)
    {
        case ScreenIndexHome:
        {
            [self changeScreenLabelWithText:HOME andDirection:ScreenDirectionDown];
            break;
        }
        case ScreenIndexOne:
        {
            [self changeScreenLabelWithText:ONE andDirection:ScreenDirectionLeft];
            break;
        }
        case ScreenIndexTwo:
        {
            [self changeScreenLabelWithText:TWO andDirection:ScreenDirectionRight];
            break;
        }
        case ScreenIndexThree:
        {
            [self changeScreenLabelWithText:THREE andDirection:ScreenDirectionUp];
            break;
        }
    }
}
-(void)changeScreenLabelWithText:(NSString *)text andDirection:(ScreenDirection)direction
{
    self.screenLabel.text = text;
    // TODO: Animate Label to in/out left/right
}
@end
