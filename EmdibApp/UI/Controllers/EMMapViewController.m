//
//  EMMapViewController.m
//  EmdibApp
//
//  Created by Chris Kwok on 9/5/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMMapViewController.h"

static int AUCTION_TAB_ID = 1;

@interface EMMapViewController ()

@end

@implementation EMMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segueAuctionView:(id)sender {
    [self.tabBarController setSelectedIndex:AUCTION_TAB_ID];
    UIViewController *selectedViewController = self.tabBarController.selectedViewController;
    UINavigationController *navController = (UINavigationController*) selectedViewController;
    [navController popToRootViewControllerAnimated:YES];

    // should be Auction List View
    UIViewController *child = navController.childViewControllers[0];
    [child performSegueWithIdentifier:@"AuctionDetailCreateSegue" sender:child];
}

- (IBAction)presentLoginView:(id)sender {
    UIViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
    [self.navigationController presentViewController:loginView animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
