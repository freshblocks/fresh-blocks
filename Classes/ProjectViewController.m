//
//  ProjectViewController.m
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//
#import "ProjectViewController.h"
#import "PhotoSource.h"

@implementation ProjectViewController
@synthesize screenshots,projectName;

- (void)viewDidLoad {
	//self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	//[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];	
	self.photoSource = [[PhotoSource alloc]
    initWithType:PhotoSourceNormal
    //initWithType:MockPhotoSourceDelayed
    // initWithType:MockPhotoSourceLoadError
    // initWithType:MockPhotoSourceDelayed|MockPhotoSourceLoadError
    title:projectName
    photos:screenshots
	photos2:nil
//  photos2:[[NSArray alloc] initWithObjects:
//    [[[MockPhoto alloc]
//      initWithURL:@"http://farm4.static.flickr.com/3280/2949707060_e639b539c5_o.jpg"
//      smallURL:@"http://farm4.static.flickr.com/3280/2949707060_8139284ba5_t.jpg"
//      size:CGSizeMake(800, 533)] autorelease],
//    nil]
  ];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	screenshots = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	//self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES]; 
}

- (void)dealloc {
	[screenshots release];
	[projectName release];
    [super dealloc];
}

@end
