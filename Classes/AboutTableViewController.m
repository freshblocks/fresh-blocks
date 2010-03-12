//
//  AboutTableViewController.m
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//

#import "AboutTableViewController.h"


static NSString* aboutText = @"Fresh Blocks LLC is a small company based in Honolulu, Hawaii. \
We specialize in making beautiful, standards-compliant websites, web applications, and iPhone apps.\
 We help individuals and businesses of all sizes, industries and locations grow their web presence.";

static NSString* peopleText = @"We love what we do and believe that it shows in our work. \
Making iPhone apps, websites and web apps isn’t just a job for us, it’s our passion. \
We wake up every day and just can’t wait to get creating. The team has over 10 years of experience \
in web design and development along with 1 year of iPhone app development experience.";

static NSString *john = @"John has been creating web sites since 1997 and specializes in building standards-based\
 HTML/CSS web sites, web apps and iPhone apps. He is a graduate from University of Maryland at College Park\
 with a BS degree in Computer Engineering and a minor in American Cultures.<br/><br/>\
When he’s not designing beautiful websites and iPhone apps, John can be found passionately taking photos\
 of anything in sight, learning new things, and spending time climbing fake rock walls.";

static NSString *fiona = @"Fiona graduated from University of Hawaii at Manoa with a BS degree in Computer Science.<br/><br/>\
When she’s not at work, Fiona can be found playing with kittens, fighting with the rubik’s cube, reading\
 Japanese manga and watching Japanese anime.";


@implementation AboutTableViewController

@synthesize data;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
	
    return self;
}
*/

- (void)viewDidLoad {
	//data = [NSArray arrayWithObjects: @"one", @"two", @"three", nil];
	self.title = @"About";
    [super viewDidLoad];
	//[self.tableView reloadData];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

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
	
    return 3;//[data count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
	NSUInteger row = [indexPath row];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	//NSUInteger row = [indexPath row];
	//NSLog(@"selected row: %d", row);
	
    // Set up the cell...
	if (section == 0 || (section == 1 && row == 0 ) ) {
		if (section == 0) {
			cell.textLabel.text = aboutText;
		}
		else {
			cell.textLabel.text = peopleText;
		}
		//cell.textLabel.text = aboutText;
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.adjustsFontSizeToFitWidth = YES;
		cell.textLabel.minimumFontSize = 10.0;
		cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	else {
		if (row == 1) {
			cell.textLabel.text = @"John Wang";
		}
		else {
			cell.textLabel.text = @"Fiona Lam";
		}
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	//cell.textLabel.text = aboutText;
	
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
	if (section == 0 || (section == 1 && [indexPath row] == 0)) {
		height = height + 150;
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
		//NSString *key = [keys objectAtIndex:row];
		//NSArray *nameSection = [names objectForKey:key];
		//NSString *desc = [nameSection objectAtIndex:0];
		if (row == 1) {
			serviceView.title = @"John Wang";
			serviceView.serviceName = @"John Wang";
			serviceView.serviceDescription = john;
		}
		else {
			serviceView.title = @"Fiona Lam";
			serviceView.serviceName = @"Fiona Lam";
			serviceView.serviceDescription =  fiona;
		}
		
		[self.navigationController pushViewController:serviceView animated:YES];
	}
	
	
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if(section == 0)
		return @"The Company";
	else
		return @"The People";
}

#pragma mark -
#pragma mark Table view delegate method

/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
/*- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}*/

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
	[data release];
    [super dealloc];
}


@end

