//
//  PhotoSource.h
//  Fresh Blocks
//
//  Created by John Wang on 11/21/09.
//  Copyright 2009 Fresh Blocks. All rights reserved.
//
#import <Three20/Three20.h>

///////////////////////////////////////////////////////////////////////////////////////////////////

typedef enum {
  PhotoSourceNormal = 0,
  PhotoSourceDelayed = 1,
  PhotoSourceVariableCount = 2,
  PhotoSourceLoadError = 4,
} PhotoSourceType;

///////////////////////////////////////////////////////////////////////////////////////////////////

@interface PhotoSource : TTURLRequestModel <TTPhotoSource> {
  PhotoSourceType _type;
  NSString* _title;
  NSMutableArray* _photos;
  NSArray* _tempPhotos;
  NSTimer* _fakeLoadTimer;
}

- (id)initWithType:(PhotoSourceType)type title:(NSString*)title
      photos:(NSArray*)photos photos2:(NSArray*)photos2;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@interface Photo : NSObject <TTPhoto> {
  id<TTPhotoSource> _photoSource;
  NSString* _thumbURL;
  NSString* _smallURL;
  NSString* _URL;
  CGSize _size;
  NSInteger _index;
  NSString* _caption;
}

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size;

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size
      caption:(NSString*)caption;

@end
