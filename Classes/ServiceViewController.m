//
//  ServiceViewController.m
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//

#import "ServiceViewController.h"

@interface TextStyleSheet : TTDefaultStyleSheet
@end

@implementation TextStyleSheet

- (TTStyle*)blueText {
	return [TTTextStyle styleWithColor:[UIColor blueColor] next:nil];
}

- (TTStyle*)largeText {
	return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:32] next:nil];
}

- (TTStyle*)smallText {
	return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:12] next:nil];
}

- (TTStyle*)floated {
	return [TTBoxStyle styleWithMargin:UIEdgeInsetsMake(0, 0, 5, 5)
							   padding:UIEdgeInsetsMake(0, 0, 0, 0)
							   minSize:CGSizeZero position:TTPositionFloatLeft next:nil];
}

- (TTStyle*)blueBox {
	return 
    [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
	 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, -5, -4, -6) next:
	  [TTShadowStyle styleWithColor:[UIColor grayColor] blur:2 offset:CGSizeMake(1,1) next:
	   [TTSolidFillStyle styleWithColor:[UIColor cyanColor] next:
		[TTSolidBorderStyle styleWithColor:[UIColor grayColor] width:1 next:nil]]]]];
}

- (TTStyle*)inlineBox {
	return 
    [TTSolidFillStyle styleWithColor:[UIColor blueColor] next:
	 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(5,13,5,13) next:
	  [TTSolidBorderStyle styleWithColor:[UIColor blackColor] width:1 next:nil]]];
}

- (TTStyle*)inlineBox2 {
	return 
    [TTSolidFillStyle styleWithColor:[UIColor cyanColor] next:
	 [TTBoxStyle styleWithMargin:UIEdgeInsetsMake(5,50,0,50)
						 padding:UIEdgeInsetsMake(0,13,0,13) next:nil]];
}

@end

@implementation ServiceViewController
@synthesize serviceName;
@synthesize serviceDescription;
@synthesize serviceImage;



 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		[TTStyleSheet setGlobalStyleSheet:[[[TextStyleSheet alloc] init] autorelease]];
    }
    return self;
}


- (void)loadView {
	[super loadView];
	
	TTStyledTextLabel* label1 = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
	label1.font = [UIFont systemFontOfSize:17];
	label1.text = [TTStyledText textFromXHTML:serviceDescription lineBreaks:YES URLs:NO];
	label1.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
	//label1.backgroundColor = [UIColor grayColor];
	[label1 sizeToFit];
	[self.view addSubview:label1];
	
	
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
}


- (void)dealloc {
	[TTStyleSheet setGlobalStyleSheet:nil];
	[serviceName release];
	[serviceDescription release];
	[serviceImage release];
    [super dealloc];
}


@end
