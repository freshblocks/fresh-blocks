//
//  PortfolioTableViewController.m
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//

#import "PortfolioTableViewController.h"
@implementation PortfolioTableViewController

@synthesize services,iphoneApps, androidApps, webDesign, webDev;
@synthesize selectedService;
@synthesize loadingScreen;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {

	}
    return self;
}*/

/*
// This is the init called by Interface Builder
- (id) initWithCoder:(NSCoder *)inCoder {
	if (self = [super initWithCoder:inCoder] ) {
		
	}
	return self;
}*/

- (void) updateInterfaceWithReachability: (Reachability*) curReach {
	NetworkStatus netStatus = [curReach currentReachabilityStatus];
	NSString* statusString= @"";
	UIAlertView *alert;	
    switch (netStatus)
    {
        case NotReachable:
        {
            statusString = @"Access Not Available";
			//NSLog(@"%@",statusString);
			
			// alert screen saying that internet connection needed to view projects
			alert = [[UIAlertView alloc]
							initWithTitle:statusString
								  message:@"Internet Access needed to view projects"
								  delegate:nil
								  cancelButtonTitle:@"Ok"
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
			break;
        }
            
        case ReachableViaWWAN:
        {
            statusString = @"Reachable WWAN";
            break;
        }
        case ReachableViaWiFi:
        {
			statusString= @"Reachable WiFi";
            break;
		}
    }
	
}
//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Portfolio";
	services = [[NSArray alloc] initWithObjects:@"Android Apps",@"Web Design",@"Web Development",@"iPhone Apps",nil];
	//self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	//[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES]; 
	[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];

	//hostReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	//[hostReach startNotifer];
	//[self updateInterfaceWithReachability: hostReach];
    internetReach = [[Reachability reachabilityForInternetConnection] retain];
	[internetReach startNotifer];
	[self updateInterfaceWithReachability: internetReach];
	
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
 
	// if still loading on leave stop loading and go back
    [loadingScreen.view removeFromSuperview];
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
	iphoneApps = nil;
	androidApps = nil;
	webDev = nil;
	webDesign = nil;
	services = nil;
	selectedService = nil;
	loadingScreen = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [services count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	NSUInteger row = [indexPath row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	//cell.textLabel.text = @"hello";
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = [services objectAtIndex:row];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	
	[self fetchAllAlbums];
	// service selected
	selectedService = [services objectAtIndex:[indexPath row]];
	
	loadingScreen = [[ActivityController alloc] init];
	[self.view addSubview:loadingScreen.view];
	// Deselect the row that was selected
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
	[loadingScreen release];
	[services release];
	[iphoneApps release];
	[androidApps release];
	[webDev release];
	[webDesign release];
	[selectedService release];
    [super dealloc];
}

#pragma mark Google Photo Code
// get an album service object with the current username/password
//
// A "service" object handles networking tasks.  Service objects
// contain user authentication information as well as networking
// state information (such as cookies and the "last modified" date for
// fetched data.)
- (GDataServiceGooglePhotos *) googlePhotosService {
	
	static GDataServiceGooglePhotos* service = nil;
	
	if (!service) {
		service = [[GDataServiceGooglePhotos alloc] init];
		//[service setUserAgent:@"FreshBlocks-FreshBlocksApp-1.0"]; // set this to yourName-appName-appVersion
		[service setShouldCacheDatedData:YES];
		[service setServiceShouldFollowNextLinks:YES];
	}
	
	// update the username/password each time the service is requested
	NSString *username = @"freshblocks.app@gmail.com";//[mUsernameField stringValue];
	NSString *password = @"DkNHhY3Q6aAuQt";//[mPasswordField stringValue];
	if ([username length] && [password length]) {
		[service setUserCredentialsWithUsername:username
									   password:password];
	} else {
		[service setUserCredentialsWithUsername:nil
									   password:nil];
	}
	
	return service;
}

// begin retrieving the list of the user's albums
- (void)fetchAllAlbums {
	
	NSString *userID = @"freshblocks@gmail.com"; //[username text];
	//Show network activity (this works).
	UIApplication *myApp = [ UIApplication sharedApplication ];
	myApp.networkActivityIndicatorVisible = YES;
	
	GDataServiceGooglePhotos *service = [self googlePhotosService];
	GDataServiceTicket *ticket;
	
	NSURL *feedURL = [GDataServiceGooglePhotos photoFeedURLForUserID:userID
															 albumID:nil
														   albumName:nil
															 photoID:nil
																kind:nil
															  access:nil];
	ticket = [service fetchFeedWithURL:feedURL
							  delegate:self
					 didFinishSelector:@selector(albumListFetchTicket:finishedWithFeed:error:)];
}
//
// album list fetch callbacks
//

// finished album list successfully
- (void)albumListFetchTicket:(GDataServiceTicket *)ticket
            finishedWithFeed:(GDataFeedPhotoUser *)feed
                       error:(NSError *)error {
	
	//self.mUserAlbumFeed = feed;
	//Picasa_AppAppDelegate *delegate = (Picasa_AppAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	//[delegate startAnimation];
	
	if (error == nil) {
		//NSMutableArray *marray = [[NSMutableArray alloc] init];
		iphoneApps = [[NSMutableArray alloc] init];
		androidApps = [[NSMutableArray alloc] init];
		webDev = [[NSMutableArray alloc] init];
		webDesign = [[NSMutableArray alloc] init];
		for (int i = 0 ; i < [[feed entries] count] ; i++) {
			GDataEntryPhotoAlbum *firstAlbum = [[feed entries] objectAtIndex:i];
			
			// if album description == iPhone Apps
			//GDataTextConstruct *titleTextConstruct = [firstAlbum title];
			//NSString *title = [titleTextConstruct stringValue];
			NSString * desc = [[firstAlbum photoDescription] stringValue];
			
			// if album desc = iphone app add to the iphone array
			if ([desc isEqualToString:@"iPhone App"]) {
				[iphoneApps addObject:firstAlbum];
			}
			// if album desc = web design
			else if([desc isEqualToString:@"Web Design"]) {
				[webDesign addObject:firstAlbum];
			}
			// if album desc = web dev
			else if ([desc isEqualToString:@"Web Development"]) {
				[webDev addObject:firstAlbum];
			}
			// if album desc = android app
			else if ([desc isEqualToString:@"Android App"]) {
				[androidApps addObject:firstAlbum];
			}			
			//[marray addObject:firstAlbum];
		}
		//self.listData = marray;
		//[marray release];
		//[tableViewController.tableView reloadData];
		
		//NSLog(@"num projects: %d",[webDesign count]);
		
		// create a new table view of ProjectsTableView class to list the projects for the selected service
		ProjectsTableView *selectedServiceProjects = [[ProjectsTableView alloc] init];
		
		selectedServiceProjects.title = selectedService;
		selectedServiceProjects.googlePhotosService = [self googlePhotosService];
		// get projects array for that service
		if ([selectedService isEqualToString:@"iPhone Apps"]) {
			selectedServiceProjects.projects = [NSArray arrayWithArray: iphoneApps];
		}
		else if ([selectedService isEqualToString:@"Android Apps"]) {
			selectedServiceProjects.projects = [NSArray arrayWithArray: androidApps];
		}
		else if ([selectedService isEqualToString:@"Web Design"]) {
			selectedServiceProjects.projects = webDesign;
		}
		else if ([selectedService isEqualToString:@"Web Development"]) {
			selectedServiceProjects.projects = [NSArray arrayWithArray: webDev];
		}
		
		[iphoneApps release];
		[webDev release];
		[webDesign release];
		[androidApps release];
		
		// push the new view
		//[self.view removeAllSubviews];
		[loadingScreen.view removeFromSuperview];
		//Show network activity (this works).
		UIApplication *myApp = [ UIApplication sharedApplication ];
		myApp.networkActivityIndicatorVisible = NO;
		
		[self.navigationController pushViewController:selectedServiceProjects animated:YES];
		[selectedServiceProjects release];
		
	}
	else {
		//[self alertError];
	}
	
	//[delegate stopAnimation];
} 

@end

