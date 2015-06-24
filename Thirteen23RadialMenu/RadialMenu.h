//
//  RadialMenu.h
//  Thirteen23RadialMenu
//
//  Created by Brian Sinnicke on 6/22/15.
//  Copyright (c) 2015 Brian Sinnicke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ScreenIndex)
{
    ScreenIndexHome,
    ScreenIndexOne,
    ScreenIndexTwo,
    ScreenIndexThree
};

@protocol RadialMenuDelegate <NSObject>
@optional
-(void)selectedButtonAtScreenIndex:(ScreenIndex)index;
@end

@interface RadialMenu : UIView 
@property (weak, nonatomic) id <RadialMenuDelegate> delegate;
-(instancetype)initWithScreen:(ScreenIndex)screen;
-(void)showAnimatedAtLocation:(CGPoint)location;
-(void)hideAnimated:(void (^)(BOOL finished))completion;

@end
