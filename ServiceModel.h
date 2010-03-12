//
//  ServiceModel.h
//  Fresh Blocks
//
//  Created by John Wang on 12/23/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServiceModel : NSObject {
    NSString *name;
    NSString *description;
    NSString *image;
}

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *description;
@property(nonatomic,copy) NSString *image;

@end
