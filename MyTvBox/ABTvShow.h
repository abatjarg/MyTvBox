//
//  ABTvShow.h
//  MyTvBox
//
//  Created by Ariunjargal on 11/17/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABTvShow : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageUrl;

- (id)initWithDictionary:(NSDictionary *)tvShow;

@end
