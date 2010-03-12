//
//  ProjectViewController.h
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//
#import <Three20/Three20.h>

@interface ProjectViewController : TTThumbsViewController {
	NSString *projectName;
	NSArray *screenshots;
}
@property (nonatomic, retain) NSArray *screenshots;
@property (nonatomic, retain) NSString *projectName;

@end
