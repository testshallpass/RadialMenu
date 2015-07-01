//
//  ViewController.m
//  Thirteen23RadialMenu
//
//  Created by Brian Sinnicke on 6/22/15.
//  Copyright (c) 2015 Brian Sinnicke. All rights reserved.
//

#import "HomeViewController.h"
#import "RadialMenu.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface HomeViewController () <RadialMenuDelegate>
@property (strong, nonatomic) RadialMenu *menu;
@end

@implementation HomeViewController
#pragma mark - Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // TODO: Animate Label to in/out left/right
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"h";
    label.font = [UIFont boldSystemFontOfSize:150.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.menu = [[RadialMenu alloc] initWithScreen:ScreenIndexHome];
    self.menu.delegate = self;
    [self.view addSubview:self.menu];
    
    self.navigationItem.hidesBackButton = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - Radial Menu Delegate
-(void)selectedButtonAtScreenIndex:(ScreenIndex)index
{
    // TODO: Animate label and remove navigation
    UINavigationController *navController = [[UINavigationController alloc] init];
    switch (index)
    {
        case ScreenIndexOne:
        {
            [navController setViewControllers:@[[[OneViewController alloc] init]] animated:YES];
            [self.navigationController presentViewController:navController animated:YES completion:nil];
            break;
        }
        case ScreenIndexTwo:
        {
            [navController setViewControllers:@[[[OneViewController alloc] init],[[TwoViewController alloc] init]] animated:YES];
            [self.navigationController presentViewController:navController animated:YES completion:nil];
            break;
        }
        case ScreenIndexThree:
        {
            [navController setViewControllers:@[[[OneViewController alloc] init],[[TwoViewController alloc] init],[[ThreeViewController alloc] init]] animated:YES];
            [self.navigationController presentViewController:navController animated:YES completion:nil];
            break;
        }
        default:
        {
            break;
        }
    }
}
@end
