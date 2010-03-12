//
//  Fresh_BlocksAppDelegate.h
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright Fresh Blocks 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface Fresh_BlocksAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
