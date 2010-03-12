//
//  PortfolioTableViewController.h
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
#import "GData.h"
#import "GDataPhotos.h"
#import "ProjectsTableView.h"
#import "ProjectViewController.h"
#import "ActivityController.h"
#import "Reachability.h"

@interface PortfolioTableViewController : UITableViewController { //TTTableViewController {

	// services provided as tags
	
	// list of albums = list of projects
	NSArray *services;
	NSMutableArray *iphoneApps;
	NSMutableArray *webDesign;
	NSMutableArray *webDev;
	NSMutableArray *androidApps;
	NSString *selectedService;
	ActivityController *loadingScreen;
	Reachability* hostReach;
    Reachability* internetReach;
}
@property (nonatomic, retain) NSArray *services;
@property (nonatomic, retain) NSMutableArray *iphoneApps;
@property (nonatomic, retain) NSMutableArray *webDesign;
@property (nonatomic, retain) NSMutableArray *webDev;
@property (nonatomic, retain) NSMutableArray *androidApps;
@property (nonatomic, retain) NSString *selectedService;
@property (nonatomic, retain) ActivityController *loadingScreen;

- (GDataServiceGooglePhotos *)googlePhotosService;
- (void)fetchAllAlbums;
@end
