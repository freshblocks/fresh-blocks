//
//  ProjectsTableView.h
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GData.h"
#import "GDataPhotos.h"
#import "ProjectViewController.h"
#import "PhotoSource.h"

@interface ProjectsTableView : UITableViewController { //TTTableViewController {
	NSArray *projects;
	GDataServiceGooglePhotos *googlePhotosService;
	NSMutableArray *screenshots;
}

@property (nonatomic, retain) NSArray *projects;
@property (nonatomic, retain) GDataServiceGooglePhotos *googlePhotosService;
@property (nonatomic, retain) NSMutableArray *screenshots;

- (void)fetchSelectedAlbum:(GDataEntryPhotoAlbum *) albumEntry;
- (UIImage *)scale:(UIImage *)inImage toSize:(CGSize)size;
@end
