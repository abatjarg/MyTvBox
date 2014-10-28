//
//  ABMovieDetailViewController.m
//  MyTvBox
//
//  Created by Ariunjargal on 10/27/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import "ABMovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ABMovieDetailViewController ()

@end

@implementation ABMovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.posterView setImageWithURL:[NSURL URLWithString:[self grabImageUrl:self.movie.imageUrl]]];
    self.movieTitle.text = self.movie.title;
    self.movieOverview.text = self.movie.movieOverview;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)grabImageUrl:(NSString *)secondPart
{
    NSString *firstPart = @"http://image.tmdb.org/t/p/w500/";
    NSString *url = [NSString stringWithFormat:@"%@%@", firstPart, secondPart];
    return url;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
