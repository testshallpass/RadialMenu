//
//  OneViewController.m
//  Thirteen23RadialMenu
//
//  Created by Brian Sinnicke on 6/22/15.
//  Copyright (c) 2015 Brian Sinnicke. All rights reserved.
//

#import "OneViewController.h"
#import "RadialMenu.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface OneViewController () <RadialMenuDelegate>
@property (strong, nonatomic) RadialMenu *menu;
@end

@implementation OneViewController
#pragma mark - Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"1";
    label.font = [UIFont boldSystemFontOfSize:150.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.menu = [[RadialMenu alloc] initWithScreen:ScreenIndexOne];
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
        case ScreenIndexTwo:
        {
            [self.navigationController pushViewController:[[TwoViewController alloc] init] animated:YES];
            break;
        }
        case ScreenIndexThree:
        {
            self.navigationController.viewControllers = @[[[OneViewController alloc] init],[[TwoViewController alloc] init],[[ThreeViewController alloc] init]];
            [self.navigationController pushViewController:[[ThreeViewController alloc] init] animated:YES];
            break;
        }
        default:
        {
            break;
        }
    }
}
@end
