//
//  ContactViewController.h
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#define kFilename @"data.plist"

@interface ContactViewController : UIViewController <ABUnknownPersonViewControllerDelegate> {
	UINavigationController *navController;
	ABUnknownPersonViewController *unknownPerson;
}

@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) ABUnknownPersonViewController *unknownPerson;
- (NSString *)dataFilePath;
- (void) createPerson;
@end
