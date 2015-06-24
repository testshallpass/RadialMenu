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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"3";
    label.font = [UIFont boldSystemFontOfSize:200.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.view addGestureRecognizer:longPressGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        if (self.menu)
        {
            [self.menu hideAnimated];
        }
        CGPoint location = [longPress locationInView:self.view];
        self.menu = [[RadialMenu alloc] initWithLocation:location andScreen:ScreenIndexThree];
        self.menu.delegate = self;
        [self.menu showAnimated];
        [self.view addSubview:self.menu];
    }
}
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
