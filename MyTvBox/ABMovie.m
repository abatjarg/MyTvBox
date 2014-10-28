//
//  ABMovie.m
//  MyTvBox
//
//  Created by Ariunjargal on 10/25/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import "ABMovie.h"

@implementation ABMovie

- (id)initWithDictionary:(NSDictionary *)movie
{
    self = [super self];
    if (self) {
        self.title = movie[@"original_title"];
        self.imageUrl = movie[@"backdrop_path"];
        self.posterUrl = movie[@"poster_path"];
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[movie objectForKey:@"genres"]];
        if ([array count] != 0) {
            NSLog(@"%@", [array objectAtIndex:0][@"name"]);
            self.movieGenre = [array objectAtIndex:0][@"name"];
        }
            
    }
    
    return self;
}

@end
