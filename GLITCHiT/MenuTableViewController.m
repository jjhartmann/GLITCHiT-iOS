//
//  MenuTableViewController.m
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-03-04.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import "MenuTableViewController.h"

@interface MenuTableViewController (){

}
@end

@implementation MenuTableViewController

    static MenuTableViewController *sharedMenu = nil;

// public method to retrieve universal controller
+ (MenuTableViewController *)getController
{
    return sharedMenu;
}

+ (BOOL)isValid
{
    return sharedMenu != nil;
}

+ (void)setController:(MenuTableViewController *)controller
{
    if (sharedMenu == nil)
    {
        sharedMenu = controller;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            NSLog(@"CAMERA");
            if (![self.currentView  isEqual: @"MainCamera"])
            {
                [self.delegate menuItemIsSelected:0];
                [self performSegueWithIdentifier:@"aboutViewSegue" sender:self];
            }
            break;
        case 1:
            NSLog(@"Load Image");
            break;
        case 2:
            NSLog(@"Purchase");
            break;
        case 3:
            NSLog(@"Settings");
            break;
        case 4:
            NSLog(@"About");
            if (![self.currentView  isEqual: @"AboutView"])
            {
                [self.delegate menuItemIsSelected:4];
                [self performSegueWithIdentifier:@"aboutViewSegue" sender:self];
            }
            break;
        default:
            break;
    }
    
    // Call calling class to close menu
    [self.delegate finishedWithMenu];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"aboutViewSegue"])
    {
        AboutViewController *abvc = (AboutViewController *)[segue destinationViewController];
        abvc.delegate = self;
    }
    
    
}

#pragma mark -
#pragma mark Delegate Imeplementations

- (void)aboutViewDidFinish
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/





@end
