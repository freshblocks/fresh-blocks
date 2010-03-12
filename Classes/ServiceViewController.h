//
//  ServiceViewController.h
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>

@interface ServiceViewController : TTViewController {
	NSString *serviceName;
	NSString *serviceDescription;
	NSString *serviceImage;
}

@property (nonatomic, retain) NSString *serviceName;
@property (nonatomic, retain) NSString *serviceDescription;
@property (nonatomic, retain) NSString *serviceImage;

@end
