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


#pragma mark - image loading

// TODO improve loading
/*
- (void)requestImages
{
    [HSInstagramUserMedia getUserMediaWithId:@"self" withAccessToken:self.accessToken block:^(NSArray *records) {
        self.images = records;
        int item = 0, row = 0, col = 0;
        //NSLog(@"%@ - records %@ ", NSStringFromClass([self class]) , records);
        
        for (NSDictionary* image in records) {
            UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(col*kthumbnailWidth,
                                                                          row*kthumbnailHeight,
                                                                          kthumbnailWidth,
                                                                          kthumbnailHeight)];
            button.tag = item;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            ++col;++item;
            if (col >= kImagesPerRow) {
                row++;
                col = 0;
            }
            [self.gridScrollView addSubview:button];
            [self.thumbnails addObject:button];
        }
        [self loadImages];
    }];
}

- (void)loadImages
{
    int item = 0;
    
    for (HSInstagramUserMedia* media in self.images) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
            NSString* thumbnailUrl = media.thumbnailUrl;
            NSData* data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:thumbnailUrl]];
            UIImage* image = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                UIButton* button = [self.thumbnails objectAtIndex:item];
                [button setImage:image forState:UIControlStateNormal];
            });
        });
        ++item;
    }
}
*/



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
    // Image loading takes some time ... so load them in another thread is a good idea

    //NSURL * imageURL = [NSURL URLWithString:imageData.imageLowResUrl];
    //NSData * imgData = [NSData dataWithContentsOfURL:imageURL];
    //cell.mediaImage.image = [UIImage imageWithData:imgData];
    
    dispatch_queue_t imageQueue = dispatch_queue_create("Image Loader",NULL);

    dispatch_async(imageQueue, ^{
        // TODO replace with thumbnail images again
        NSURL * url = [NSURL URLWithString:imageData.imageThumbnailUrl];
        //NSURL *url = [NSURL URLWithString:imageData.imageStandardUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
            
        if (!imageData) return;
            
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            cell.mediaImage.image = [UIImage imageWithData:imageData];
        });
    });
    
    // TODO: save Images on Device for faster loading, offlibe watching ?
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowMediaDetail"])
    {
        MediaDetailViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        
        //NSLog(@"%@ - row %li ", NSStringFromClass([self class]), (long)myIndexPath.row );
        
        detailViewController.mediaData = _dataManager.mediaDataReversedArray[myIndexPath.row];
    }
}



@end
