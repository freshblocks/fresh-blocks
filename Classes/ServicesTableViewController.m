//
//  ServicesTableViewController.m
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//

#import "ServicesTableViewController.h"

//static NSString* kLoremIpsum = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do\
eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud\
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
//Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla\
pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt\
mollit anim id est laborum.


@implementation ServicesTableViewController
@synthesize names;
@synthesize keys;

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
	
	self.title = @"Services";
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"services" ofType:@"plist"];
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
	self.names = dict;
	[dict release];
	//NSArray *array = [names allKeys];
	NSArray *array = [[names allKeys] sortedArrayUsingSelector: @selector(compare:)];
	self.keys = array;
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
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
	
	self.names = nil;
	self.keys = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 1;
	}
	return  4;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSUInteger section = [indexPath section];
	NSUInteger row = [indexPath row];

    NSString *key = [keys objectAtIndex:section];
	
	if (section == 0)
		key = @"Services";
	else if (section == 1)
		key = [keys objectAtIndex:row];
	
	NSArray *nameSection = [names objectForKey:key];
	NSString *imagename = [nameSection objectAtIndex:1];
	NSString *desc = @"Most of our time we make stuff for the web. But we also advise companies, teach people how to make their stuff work and speak about all this web stuff at events.";
	
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	if ([key isEqualToString:@"Services"]) {
		cell.textLabel.text = desc;
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.adjustsFontSizeToFitWidth = YES;
		cell.textLabel.minimumFontSize = 10.0;
		cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];

	}
	else {
		cell.textLabel.text = key;
		NSString *path = [[NSBundle mainBundle] pathForResource:imagename ofType:@"png"];
		UIImage *theImage = [UIImage imageWithContentsOfFile:path];
		cell.imageView.image = theImage;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellText = @"Go get some text for your cell.";
	UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
	CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
	CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	NSUInteger section = [indexPath section];
	CGFloat height = labelSize.height;
	if (section == 0 ) {
		height = height + 80;
	}
	else {
		height = height + 20;
	}	
	return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	
	NSUInteger row = [indexPath row];
	NSUInteger section = [indexPath section];
	if ( section != 0 ) {
		ServiceViewController *serviceView = [[[ServiceViewController alloc] initWithNibName:@"ServiceView" bundle:nil] autorelease];
		NSString *key = [keys objectAtIndex:row];
		NSArray *nameSection = [names objectForKey:key];
		NSString *desc = [nameSection objectAtIndex:0];
		serviceView.title = key;
		serviceView.serviceName = key;
		serviceView.serviceDescription = desc;
		
		[self.navigationController pushViewController:serviceView animated:YES];
	}
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
	[names release];
	[keys release];
    [super dealloc];
}


@end

