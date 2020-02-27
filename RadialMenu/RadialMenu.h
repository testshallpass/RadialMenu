//
//  RadialMenu.h
//  RadialMenu
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

typedef NS_ENUM(NSUInteger, ScreenDirection)
{
    ScreenDirectionUp,
    ScreenDirectionDown,
    ScreenDirectionRight,
    ScreenDirectionLeft
};

@protocol RadialMenuDelegate <NSObject>
@optional
-(void)touchedButtonWithScreenText:(NSString *)text andDirection:(ScreenDirection)direction;
@end

@interface RadialMenu : UIView 
@property (weak, nonatomic) id <RadialMenuDelegate> delegate;
-(instancetype)initWithScreen:(ScreenIndex)screen;
-(void)showAnimatedAtLocation:(CGPoint)location;
-(void)hideAnimated:(void (^)(BOOL finished))completion;
@end
