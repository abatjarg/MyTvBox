//
//  ABTvShow.m
//  MyTvBox
//
//  Created by Ariunjargal on 11/17/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import "ABTvShow.h"

@implementation ABTvShow

- (id)initWithDictionary:(NSDictionary *)tvShow
{
    self = [super self];
    if (self) {
        self.title = tvShow[@"original_name"];
        self.imageUrl = tvShow[@"poster_path"];
    }
    
    return self;
}

@end
