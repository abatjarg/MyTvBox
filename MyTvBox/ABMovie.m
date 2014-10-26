//
//  ABMovie.m
//  MyTvBox
//
//  Created by Ariunjargal on 10/25/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import "ABMovie.h"

@implementation ABMovie

- (id)initWithDictionary:(NSDictionary *)movies
{
    self = [super self];
    if (self) {
        self.title = movies[@"original_name"];
        self.imageUrl = movies[@"backdrop_path"];
        self.posterUrl = movies[@"poster_path"];
    }
    
    return self;
}

@end
