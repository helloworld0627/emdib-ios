//
//  EMLoginViewController.m
//  EmdibApp
//
//  Created by Chris Kwok on 8/28/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMLoginViewController.h"
#import "EMAuctionListViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface EMLoginViewController()<FBSDKLoginButtonDelegate>

@property (nonatomic, strong) FBSDKLoginButton *loginButton;
@property (nonatomic, strong) UILabel *continueLabel;

@end

@implementation EMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];

    // FB log in button
    _loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    _loginButton.center = CGPointMake(centerView.center.x, centerView.center.y);
    _loginButton.delegate = self;

    // continue label
    _continueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _loginButton.frame.size.width, _loginButton.frame.size.height)];
    _continueLabel.text = @"tap to continue";
    _continueLabel.center = CGPointMake(centerView.center.x, centerView.center.y + 30);
    _continueLabel.hidden = ([FBSDKAccessToken currentAccessToken])? NO : YES;

    // _continueLabel tap gesture
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateToAuctionListView)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [_continueLabel addGestureRecognizer:tapGestureRecognizer];
    _continueLabel.userInteractionEnabled = YES;

    [centerView addSubview:_loginButton];
    [centerView addSubview:_continueLabel];

    centerView.center = self.view.center;
    [self.view addSubview:centerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigateToAuctionListView {
    EMAuctionListViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionListView"];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma marks - FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error {
    if (error) {
        return;
    }
    [FBSDKAccessToken refreshCurrentAccessToken:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
    }];
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
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
