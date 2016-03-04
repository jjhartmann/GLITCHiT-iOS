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
}

@end

@implementation SlideBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create Gesture recognizer for pan
    UIScreenEdgePanGestureRecognizer *screenPanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]
                                                       initWithTarget:self
                                                       action:@selector(respondToSreenPanGesture:)];
    [screenPanRecognizer setMinimumNumberOfTouches:1];
    [screenPanRecognizer setMaximumNumberOfTouches:1];
    [screenPanRecognizer setEdges:UIRectEdgeLeft];
    
    [self.view addGestureRecognizer:screenPanRecognizer];
    

    
    
    
    // Setting up slide menu
    rootViewHeight = self.view.frame.size.height;
    rootViewWidth  = self.view.frame.size.width;
    menuHeight = rootViewHeight;
    menuWidth = (3*rootViewWidth)/4;
    
    self.menuItems = @[@"Camera", @"Load Images", @"Purchase", @"Settings", @"About"];
    [self setupSlideMenu];
    
    // Init animator
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
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
    [self.view addSubview:self.menuView];
    
    
    // Set up Table View.
    self.menuTableView = [[UITableView alloc] initWithFrame:self.menuView.bounds style:UITableViewStylePlain];
    self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.menuTableView.scrollEnabled = NO;
    self.menuTableView.alpha = 0.5;
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
        frame.origin.x =  0;
        // Animate the rest automatically
        [UIView animateWithDuration:0.6 animations:^{
            self.menuView.frame = frame;
        }];
    }
    
    
//    [self.animator removeAllBehaviors];
//    
//    // set Gravity
//    CGFloat gravityX = (state) ? 0.3 : -1.0;
//    CGFloat boundaryPX = (state) ? menuWidth : -(menuWidth + 5);
//    
//    // Set up gravity animation
//    UIGravityBehavior *gb = [[UIGravityBehavior alloc] initWithItems:@[self.menuView]];
//    gb.gravityDirection = CGVectorMake(gravityX, 0.0f);
//    
//    [self.animator addBehavior:gb];
//    
//    
//    // Collision Behaviour
//    UICollisionBehavior *cb = [[UICollisionBehavior alloc] initWithItems:@[self.menuView]];
//    [cb addBoundaryWithIdentifier:@"menuBoundary" fromPoint:CGPointMake(boundaryPX, 580) toPoint:CGPointMake(boundaryPX, 0) ];
//    
//    [self.animator addBehavior:cb];
}

#pragma mark -
#pragma mark Gesture Control Impl
- (void)respondToSreenPanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    [self showMenu:YES gestureRecognizer:recognizer];
}

- (void)respondToPanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    [self showMenu:NO gestureRecognizer:recognizer];
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
    
    return cell;
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
