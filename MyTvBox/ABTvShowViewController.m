//
//  ABTvShowViewController.m
//  MyTvBox
//
//  Created by Ariunjargal on 11/12/14.
//  Copyright (c) 2014 Ariunjargal Batjargal. All rights reserved.
//

#import "ABTvShowViewController.h"

@interface ABTvShowViewController ()

@property (strong, nonatomic) NSMutableArray *tvShows;

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
