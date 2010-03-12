//
//  Fresh_BlocksAppDelegate.m
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright Fresh Blocks 2009. All rights reserved.
//

#import "Fresh_BlocksAppDelegate.h"


@implementation Fresh_BlocksAppDelegate

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
   
    // Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
    // method "reachabilityChanged" will be called. 



	
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

