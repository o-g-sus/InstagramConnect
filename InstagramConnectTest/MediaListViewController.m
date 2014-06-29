//
//  MediaListViewController.h
//  InstagramConnectTest
//
//  Created by Oliver Greschke on 17.06.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//

#import "MediaListViewController.h"

#import "InstagramDataManager.h"
#import "MediaData.h"
#import "MediaTableViewCell.h"
#import "MediaDetailViewController.h"

@interface MediaListViewController ()

@property (nonatomic, strong) NSString* endpoint;
@property (nonatomic, strong) InstagramDataManager * dataManager ;

@end



@implementation MediaListViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataManager = [InstagramDataManager sharedData];
    
    [self.tableView reloadData];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%@ - _dataManager.imagesDataArray.count %i ", NSStringFromClass([self class]) ,_dataManager.imagesDataArray.count);
    return _dataManager.mediaDataReversedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mediaTableCell";
    MediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //NSLog(@"%@ - indexPath.row %i ", NSStringFromClass([self class]) ,indexPath.row);
    
    MediaData * imageData = _dataManager.mediaDataReversedArray[indexPath.row];
    
    
    cell.captionLabel.text = imageData.caption;
    if (imageData.location) {
        if (imageData.locationName) cell.locationLabel.text = [NSString stringWithFormat:@"@ %@", imageData.locationName];
        else cell.locationLabel.text = [NSString stringWithFormat:@"@ %@:%@", imageData.locationLatitude, imageData.locationLongitude];
    }
    else cell.locationLabel.text=@"";
    
    cell.LikesNo.text = [NSString stringWithFormat:@"Likes: %lu",(unsigned long)imageData.likes];
    
    // @Annotation
    // Image loading takes some time - so load them in another thread is a good idea:
    // One option is to use GCD for that. Another option would be, to use ADNetworking, which has already
    // an asynchrone ImageLoader build in (AFImageResponseSerializer).
    // But our networking jobs are still rather simple, so GCD is enough here
    
    //NSURL * imageURL = [NSURL URLWithString:imageData.imageLowResUrl];
    //NSData * imgData = [NSData dataWithContentsOfURL:imageURL];
    //cell.mediaImage.image = [UIImage imageWithData:imgData];
    
    dispatch_queue_t imageQueue = dispatch_queue_create("Image Loader",NULL);
    
    dispatch_async(imageQueue, ^{
        NSURL * url = [NSURL URLWithString:imageData.imageThumbnailUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        if (!imageData) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update  UI
            cell.mediaImage.image = [UIImage imageWithData:imageData];
        });
    });
    
    // TODO: save Images on Device for faster loading, offline use ?
    
    return cell;
}


#pragma mark - Storyboard


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowMediaDetail"])
    {
        MediaDetailViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        //NSLog(@"%@ - row %li ", NSStringFromClass([self class]), (long)myIndexPath.row );
        
        detailViewController.mediaData = _dataManager.mediaDataReversedArray[myIndexPath.row];
    }
}



@end
