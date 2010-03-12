//
//  ServicesTableViewController.h
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceViewController.h"

@interface ServicesTableViewController : UITableViewController { //TTTableViewController {
	NSDictionary *names;
	NSArray *keys;
}

@property (nonatomic, retain) NSDictionary *names;
@property (nonatomic, retain) NSArray *keys;

@end
