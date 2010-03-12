//
//  ProjectsTableView.m
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//

#import "ProjectsTableView.h"


@implementation ProjectsTableView
@synthesize projects;
@synthesize googlePhotosService;
@synthesize screenshots;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	//self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	//[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES]; 
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	projects = nil;
	googlePhotosService = nil;
	screenshots = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [projects count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }	
	
	GDataEntryPhotoAlbum *album = [projects objectAtIndex:[indexPath row]];

	GDataTextConstruct *titleTextConstruct = [album title];
	NSString *title = [titleTextConstruct stringValue];

	NSArray *thumbnails = [[album mediaGroup] mediaThumbnails];
	NSString *imageURLString = [[thumbnails objectAtIndex:0] URLString];
	UIImage *thumbnail = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]]];
	// need to resize the thumbnail
	CGSize itemSize = CGSizeMake(32.0,32.0);
	
	
    // Set up the cell...
	cell.textLabel.text = @"hello";
	cell.imageView.image = [self scale:thumbnail toSize:itemSize];	
	cell.textLabel.text = title;
	
	
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];

	GDataEntryPhotoAlbum *album = [projects objectAtIndex:[indexPath row]];
	
	//GDataTextConstruct *titleTextConstruct = [album title];
	//NSString *title = [titleTextConstruct stringValue];
	
	
	[self fetchSelectedAlbum:album];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
	[projects release];
	[googlePhotosService release];
	[screenshots release];  // this is causing the EXEC_BAD_ACCESS. Why? this is not there to release?
    [super dealloc];
}

#pragma mark Google Photos Methods

// function to resize the thumbnails
- (UIImage *)scale:(UIImage *)inImage toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [inImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


// for the album selected in the top list, begin retrieving the list of photos
- (void)fetchSelectedAlbum:(GDataEntryPhotoAlbum *) albumEntry {
	//Show network activity (this works).
	UIApplication *myApp = [ UIApplication sharedApplication ];
	myApp.networkActivityIndicatorVisible = YES;
	
	//NSLog(@"starting");
	GDataEntryPhotoAlbum *album = albumEntry;
	if (album) {
		//NSLog(@"album");
		// fetch the photos feed
		NSURL *feedURL = [[album feedLink] URL];
		//NSLog(@"feed url: %@",feedURL);
		if (feedURL) {
			GDataServiceGooglePhotos *service = [self googlePhotosService];
			GDataServiceTicket *ticket;
			ticket = [service fetchFeedWithURL:feedURL
									  delegate:self
							 didFinishSelector:@selector(photosTicket:finishedWithFeed:error:)];
		}
	}
}
//
// entries list fetch callbacks
//

// fetched photo list successfully
- (void)photosTicket:(GDataServiceTicket *)ticket
    finishedWithFeed:(GDataFeedPhotoAlbum *)feed error:(NSError *)error{
	
	NSArray *photos = [feed entries];
	
	//[self setPhotoFeed:feed];
	//[self setPhotoFetchError:nil];
	//[self setPhotoFetchTicket:nil];
	//NSLog(@"count: %d", [photos count]);
	//NSString *imageURLString = [[thumbnails objectAtIndex:0] URLString];
	screenshots = [[NSMutableArray alloc] init];
	for (int i = 0 ; i < [photos count]; i ++ ) {
		GDataEntryPhoto *photo = [photos objectAtIndex:i];
		NSArray *thumbnails = [[photo mediaGroup] mediaThumbnails];
		NSArray *images = [[photo mediaGroup] mediaContents];
		//NSLog(@"%d %d",[images objectAtIndex:1], [images objectAtIndex:2]);
		[screenshots addObject:[[[Photo alloc]
							  initWithURL:[[images objectAtIndex:0] URLString]
							  smallURL:[[thumbnails objectAtIndex:0] URLString]
							  size:CGSizeMake([[photo width] floatValue], [[photo height] floatValue])] autorelease]];
	}
	//NSLog(@"done");
	//[self updateUI];
	
	// Create the new view for the selected Project
	ProjectViewController *projectView = [[ProjectViewController alloc] init];
	
	// Set the source for the project. Array of screenshots
	projectView.screenshots = [NSArray arrayWithArray:screenshots];
	//[screenshots release];
	
	// Set the name of the selected Project
	GDataTextConstruct *titleTextConstruct = [feed title];
	projectView.projectName = [titleTextConstruct stringValue];;
	
	// only push after finished - TODO
	//Show network activity (this works).
	UIApplication *myApp = [ UIApplication sharedApplication ];
	myApp.networkActivityIndicatorVisible = NO;
	
	[[self navigationController] pushViewController:projectView animated:YES];
	[projectView release];
} 


@end

