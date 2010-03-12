//
//  ContactViewController.m
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//

#import "ContactViewController.h"


@implementation ContactViewController

@synthesize unknownPerson;
@synthesize navController;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"ContactView" bundle:nil]) {
        // Custom initialization
 
    }
    return self;
}*/


/* ABUnknownPersonViewControllerDelegate */
// This function is the return after a user adds the contact to a new entry or existing entry
- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person {
	NSString *msg = nil;
	if (person != NULL ) {
		msg = @"Fresh Blocks was added to your Address Book.";
		// Show a Alert Modal box that the contact was added
		UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"Success!"
						  message:msg
						  delegate:nil
						  cancelButtonTitle:@"Ok"
						  otherButtonTitles:nil];
		[alert show];
		[alert release];	

		// Get the record ID of the newly created Contact and save it in data.plist
		ABRecordID personID = ABRecordGetRecordID(person);		
		NSNumber *recordID = [NSNumber numberWithInt:personID];
		NSMutableArray *array = [[NSMutableArray alloc] init];
		[array addObject:recordID];
		[array writeToFile:[self dataFilePath] atomically:YES];
		[array release];	
	
		// Disable Add to Address Book option for newly created contact
		[unknownPerson release];
		[self createPerson];
		
		// refresh the screen
		[unknownPerson.view setNeedsDisplay];
		[self.view setNeedsDisplay];
	}
}

- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
						   property:(ABPropertyID)property 
						 identifier:(ABMultiValueIdentifier)identifier {
	return YES;  // allow phone call, text message, web url click to mobile safari and email link to mail app
}

- (NSString *)dataFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void) createPerson {
	ABAddressBookRef addressBook = ABAddressBookCreate();
	
	ABRecordRef person = ABPersonCreate();
	CFErrorRef error = NULL;
	// set the company name and show as company properties
	ABRecordSetValue(person, kABPersonOrganizationProperty, CFSTR("Fresh Blocks"), &error);
	ABRecordSetValue(person, kABPersonKindProperty, kABPersonKindOrganization, &error);
	if(NULL != error) {
		NSLog(@"an error occurred" );
	}
	
	// set contact image
	NSData *dataRef = UIImagePNGRepresentation([UIImage imageNamed:@"Fresh_Blocks_iPhone_App.png"]);
	ABPersonSetImageData(person, (CFDataRef)dataRef, nil);
	
	// set phone numbers
	ABMutableMultiValueRef multi =
	ABMultiValueCreateMutable(kABMultiStringPropertyType);
	ABMultiValueAddValueAndLabel(multi, CFSTR("123-456-7890" ), kABWorkLabel, NULL);
	// add the phone numbers to the person record
	ABRecordSetValue(person, kABPersonPhoneProperty, multi, &error);
	CFRelease(multi);
	if(NULL != error) {
		NSLog(@"an error occurred" );
	}
	
	// set the mailing address
	CFStringRef keys[4] = {kABPersonAddressStreetKey, kABPersonAddressCityKey, kABPersonAddressStateKey, kABPersonAddressZIPKey};
	CFStringRef values[4] = {CFSTR("Street" ),CFSTR("City" ), CFSTR("ST" ), CFSTR("12345" )};
	CFDictionaryRef data = CFDictionaryCreate(NULL, (void *)keys, (void *)values, 4, &kCFCopyStringDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
	multi = ABMultiValueCreateMutable(kABDictionaryPropertyType);
	ABMultiValueAddValueAndLabel(multi, data, kABWorkLabel, NULL);
	// add the address to the person record
	ABRecordSetValue(person, kABPersonAddressProperty, multi, &error);
	CFRelease(multi);
	
	// set websites URLs
	multi =
	ABMultiValueCreateMutable(kABMultiStringPropertyType);
	ABMultiValueAddValueAndLabel(multi, CFSTR("http://url.com"), kABWorkLabel, NULL);
	// add the websites to the person record
	ABRecordSetValue(person, kABPersonURLProperty, multi, &error);
	CFRelease(multi);
	if(NULL != error) {
		NSLog(@"an error occurred" );
	}
	
	// set email addresses
	multi =
	ABMultiValueCreateMutable(kABMultiStringPropertyType);
	ABMultiValueAddValueAndLabel(multi, CFSTR("email@address.com"), kABWorkLabel, NULL);
	// add the phone numbers to the person record
	ABRecordSetValue(person, kABPersonEmailProperty, multi, &error);
	CFRelease(multi);
	if(NULL != error) {
		NSLog(@"an error occurred" );
	}
	unknownPerson = [[ABUnknownPersonViewController alloc] init];
	unknownPerson.unknownPersonViewDelegate = self;
	unknownPerson.allowsActions = YES;
	unknownPerson.displayedPerson = person;
	unknownPerson.alternateName = @"Fresh Blocks";

	// Check if the record was previously saved
	NSNumber *recordID = NULL;
	NSString *filePath = [self dataFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
		recordID = [array objectAtIndex:0];
		// Check if the record already exists in the address book
		ABRecordID personID = [recordID intValue];
		ABRecordRef existing = ABAddressBookGetPersonWithRecordID (addressBook, personID);
		if (existing == NULL) {
			unknownPerson.allowsAddingToAddressBook = YES;
		}
		else {
			unknownPerson.allowsAddingToAddressBook = NO;
		}
		[array release];
		
	}
	else {
		unknownPerson.allowsAddingToAddressBook = YES;
	}		
	unknownPerson.title = @"Contact";
	[unknownPerson.navigationItem setHidesBackButton:YES animated:NO];
	[self.navigationController initWithRootViewController:unknownPerson];
	CFRelease(person);
	CFRelease(addressBook);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Contact";
	[self createPerson];

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


- (void)dealloc {
	[unknownPerson release];
	[navController release];
    [super dealloc];
}


@end
