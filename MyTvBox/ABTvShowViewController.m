//
//  ABTvShowViewController.m
//  MyTvBox
//
//  Created by Ariunjargal on 11/12/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import "ABTvShowViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ABTvShow.h"
#import "ABTvShowCell.h"

@interface ABTvShowViewController ()

@property (strong, nonatomic) NSMutableArray *tvShows;

@property (weak, nonatomic) IBOutlet UICollectionView *tvShowView;

@end

@implementation ABTvShowViewController

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
    [self.tvShowView setDataSource:self];
    [self.tvShowView setDelegate:self];
    [self loadDataAiringToday];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataOnAir
{
    NSString *url = @"http://api.themoviedb.org/3/tv/on_the_air?api_key=0e7bf9123871b0fe728caf5636fd7e47";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:12];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (!connectionError && responseCode == 200) {
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[object objectForKey:@"results"]];
            self.tvShows = [[NSMutableArray alloc] init];
            
            for(NSDictionary *item in array){
                ABTvShow *tvShow = [[ABTvShow alloc] initWithDictionary:item];
                [self.tvShows addObject:tvShow];
                [self.tvShowView reloadData];
            }
        }
        else
        {
            NSLog(@"Error!!!");
        }
        
    }];
}

- (void)loadDataTopRated
{
    NSString *url = @"http://api.themoviedb.org/3/tv/top_rated?api_key=0e7bf9123871b0fe728caf5636fd7e47";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:12];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (!connectionError && responseCode == 200) {
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[object objectForKey:@"results"]];
            self.tvShows = [[NSMutableArray alloc] init];
            
            for(NSDictionary *item in array){
                ABTvShow *tvShow = [[ABTvShow alloc] initWithDictionary:item];
                [self.tvShows addObject:tvShow];
                [self.tvShowView reloadData];
            }
        }
        else
        {
            NSLog(@"Error!!!");
        }
        
    }];
}

- (void)loadDataAiringToday
{
    NSString *url = @"http://api.themoviedb.org/3/tv/airing_today?api_key=0e7bf9123871b0fe728caf5636fd7e47";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:12];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (!connectionError && responseCode == 200) {
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[object objectForKey:@"results"]];
            self.tvShows = [[NSMutableArray alloc] init];
            
            for(NSDictionary *item in array){
                ABTvShow *tvShow = [[ABTvShow alloc] initWithDictionary:item];
                [self.tvShows addObject:tvShow];
                [self.tvShowView reloadData];
            }
        }
        else
        {
            NSLog(@"Network error");
            //[self showNetworkError];
        }
        
    }];
}

- (NSString *)grabImageUrl:(NSString *)secondPart
{
    NSString *firstPart = @"http://image.tmdb.org/t/p/w500/";
    NSString *url = [NSString stringWithFormat:@"%@%@", firstPart, secondPart];
    return url;
}

#pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.tvShows count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ABTvShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tvShowCell" forIndexPath:indexPath];
    
    ABTvShow *tvShow = self.tvShows[indexPath.row];
    cell.titleLabel.text = tvShow.title;
    [cell.posterView setImageWithURL:[NSURL URLWithString:[self grabImageUrl:tvShow.imageUrl]]];
    
    return cell;
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
