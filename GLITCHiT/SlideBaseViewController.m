 //
//  SlideBaseViewController.m
//  GLITCHiT
//
//  Created by Jeremy Hartmann on 2016-03-03.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import "SlideBaseViewController.h"

@interface SlideBaseViewController (){
    CGFloat menuWidth;
    CGFloat menuHeight;
    CGFloat rootViewWidth;
    CGFloat rootViewHeight;
    BOOL menuActive;
    BOOL menuShouldClose;
}

@end

@implementation SlideBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.tag = 1;
    
    // Setting up slide menu
    rootViewHeight = self.view.frame.size.height;
    rootViewWidth  = self.view.frame.size.width;
    menuHeight = rootViewHeight;
    menuWidth = (3*rootViewWidth)/4;
    
    self.menuItems = @[@"Camera", @"Load Images", @"Purchase", @"Settings", @"About"];
    [self setupSlideMenu];
    
    // Create Gesture recognizer for pan
    UIScreenEdgePanGestureRecognizer *screenPanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]
                                                       initWithTarget:self
                                                       action:@selector(respondToSreenPanGesture:)];
    [screenPanRecognizer setMinimumNumberOfTouches:1];
    [screenPanRecognizer setMaximumNumberOfTouches:1];
    [screenPanRecognizer setEdges:UIRectEdgeLeft];
    
    [self.view addGestureRecognizer:screenPanRecognizer];
    
    // Create Gesture for removing menu
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPanGesture:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    
    [panGesture requireGestureRecognizerToFail:screenPanRecognizer];
    [self.view addGestureRecognizer:panGesture];
    menuActive = NO;
    menuShouldClose = NO;
    
    // Create tap gesture for dismissing view.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapGesture:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    
    [tapRecognizer requireGestureRecognizerToFail:screenPanRecognizer];
    tapRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Slide Menu Impelmentation
// Slide menu Methods

- (void)setupSlideMenu
{
    
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(-menuWidth, 0, menuWidth, menuHeight)];
    
    self.menuView.backgroundColor = [UIColor clearColor];
    self.menuView.tag = 100;
    [self.view addSubview:self.menuView];
    
    
    // Set up Table View.
    self.menuTableView = [[UITableView alloc] initWithFrame:self.menuView.bounds style:UITableViewStylePlain];
    self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.menuTableView.scrollEnabled = NO;
    self.menuTableView.alpha = 0.5;
    self.menuTableView.tag = 101;
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    
    
    [self.menuView addSubview:self.menuTableView];
}

- (void)showMenu:(BOOL)state gestureRecognizer:(UIPanGestureRecognizer *)recognizer
{
    // Get the location
    CGPoint location = [recognizer locationInView:self.view];
    
    CGRect frame = [self.menuView frame];
    frame.origin.x = -menuWidth + location.x;
    
    
    if (frame.origin.x <= 0)
        self.menuView.frame = frame;
    
    
    if ([recognizer state] == UIGestureRecognizerStateEnded  ||
        [recognizer state] == UIGestureRecognizerStateCancelled)
    {
        if ((state && location.x > menuWidth/3) ||
            (!state && location.x > menuWidth*2/3))
        {
            frame.origin.x =  0;
            menuActive = YES;
        }
        else
        {
            frame.origin.x = -(menuWidth + 5);
            menuActive = NO;
        }
        
        menuShouldClose = NO;
        
        // Animate the rest automatically
        [UIView animateWithDuration:0.6 animations:^{
            self.menuView.frame = frame;
        }];
    }
}

#pragma mark -
#pragma mark Gesture Control Impl
- (void)respondToSreenPanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    if (!menuActive)
    {
        [self showMenu:YES gestureRecognizer:recognizer];
    }
}

- (void)respondToPanGesture:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state] == UIGestureRecognizerStateBegan)
    {
        UIView *view = [self.view hitTest:[recognizer locationInView:self.view] withEvent:Nil];
        menuShouldClose = (view == self.view);
    }
    
    if (menuActive && menuShouldClose)
    {
        [self showMenu:NO gestureRecognizer:recognizer];
    }
}

- (void)respondToTapGesture:(UITapGestureRecognizer *)recognizer
{
    UIView *view = [self.view hitTest:[recognizer locationInView:self.view] withEvent:Nil];
    NSLog(@"View Tag: %d", view.tag);
}

#pragma mark -
#pragma mark UITableView Delegate and Datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Implement cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSString *text = self.menuItems[indexPath.row];
    cell.textLabel.text = text;
    cell.backgroundColor = [UIColor clearColor];
    cell.tag = 102;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            NSLog(@"CAMERA");
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
            break;
        default:
            break;
    }
}


#pragma mark -
#pragma Gesture recognizer delegate impls
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == self.view)
    {
        return YES;
    }
    
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
