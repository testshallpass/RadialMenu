//
//  ThreeViewController.m
//  Thirteen23RadialMenu
//
//  Created by Brian Sinnicke on 6/22/15.
//  Copyright (c) 2015 Brian Sinnicke. All rights reserved.
//

#import "ThreeViewController.h"
#import "RadialMenu.h"
#import "OneViewController.h"
#import "TwoViewController.h"

@interface ThreeViewController () <RadialMenuDelegate>
@property (strong, nonatomic) RadialMenu *menu;
@end

@implementation ThreeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"3";
    label.font = [UIFont boldSystemFontOfSize:150.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.menu = [[RadialMenu alloc] initWithScreen:ScreenIndexThree];
    self.menu.delegate = self;
    [self.view addSubview:self.menu];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.view addGestureRecognizer:longPressGesture];
    
    self.navigationItem.hidesBackButton = YES;
}
#pragma mark - Long Press Handler
-(void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        CGPoint location = [longPress locationInView:self.view];
        [self.menu showAnimatedAtLocation:location];
    }
}
#pragma mark - Radial Menu Delegate
-(void)selectedButtonAtScreenIndex:(ScreenIndex)index
{
    switch (index)
    {
        case ScreenIndexHome:
        {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case ScreenIndexOne:
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        }
        case ScreenIndexTwo:
        {
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        default:
        {
            break;
        }
    }
}
@end
