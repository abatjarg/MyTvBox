//
//  ABMovieViewController.m
//  MyTvBox
//
//  Created by Ariunjargal on 10/25/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import "ABMovieViewController.h"
#import "ABMovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ABMovie.h"
#import "ABMovieCell.h"
#import "CBStoreHouseRefreshControl.h"

@interface ABMovieViewController ()

@property (nonatomic, strong) CBStoreHouseRefreshControl *storeHouseRefreshControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *movies;

@end

@implementation ABMovieViewController

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
    [self getNowPlaying];
    
    self.tableView.rowHeight = 160;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ABMovieCell" bundle:nil] forCellReuseIdentifier:@"ABMovieCell"];
    
    self.storeHouseRefreshControl = [CBStoreHouseRefreshControl attachToScrollView:self.tableView target:self refreshAction:@selector(refreshTriggered:) plist:@"custom" color:[UIColor whiteColor] lineWidth:1.5 dropHeight:80 scale:1 horizontalRandomness:150 reverseLoadingAnimation:YES internalAnimationFactor:0.5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getNowPlaying
{
    NSString *url = @"http://api.themoviedb.org/3/movie/now_playing?api_key=0e7bf9123871b0fe728caf5636fd7e47";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:12];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (!connectionError && responseCode == 200) {
            self.movies = [[NSMutableArray alloc] init];
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[object objectForKey:@"results"]];
            
            for(NSDictionary *item in array){
                NSString *movieID = [NSString stringWithFormat:@"%@", item[@"id"]];
                [self loadMovieData:movieID];
            }
        }
        else
        {
            NSLog(@"Error!!!");
        }
        
    }];
}

- (void)loadMovieData:(NSString *)movieID
{
    NSString *url = [NSString stringWithFormat:@"http://api.themoviedb.org/3/movie/%@?api_key=0e7bf9123871b0fe728caf5636fd7e47", movieID];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:12];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (!connectionError && responseCode == 200) {
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //NSLog(@"%@", object);
            ABMovie *movie = [[ABMovie alloc] initWithDictionary:object];
            [self.movies addObject:movie];
            [self.tableView reloadData];
        }
        else
        {
            NSLog(@"Error!!!");
        }
        
    }];
}

- (NSString *)grabImageUrl:(NSString *)secondPart
{
    NSString *firstPart = @"http://image.tmdb.org/t/p/w500/";
    NSString *url = [NSString stringWithFormat:@"%@%@", firstPart, secondPart];
    return url;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ABMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABMovieCell"];
    
    ABMovie *movie = self.movies[indexPath.row];
    cell.movieTitle.text = movie.title;
    cell.movieGenre.text = movie.movieGenre;
    [cell.posterView setImageWithURL:[NSURL URLWithString:[self grabImageUrl:movie.imageUrl]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"toMovieDetailViewController" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.destinationViewController isKindOfClass:[ABMovieDetailViewController class]]) {
            ABMovieDetailViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            ABMovie *movie = self.movies[path.row];
            targetViewController.movie = movie;
        }
    }
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - Notifying refresh control of scrolling

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.storeHouseRefreshControl scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.storeHouseRefreshControl scrollViewDidEndDragging];
}

#pragma mark - Listening for the user to trigger a refresh

- (void)refreshTriggered:(id)sender
{
    [self performSelector:@selector(finishRefreshControl) withObject:nil afterDelay:3 inModes:@[NSRunLoopCommonModes]];
}

- (void)finishRefreshControl
{
    [self.storeHouseRefreshControl finishingLoading];
}

@end























