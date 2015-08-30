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
@property (nonatomic, strong) UIButton *continueButton;

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
    _continueButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _loginButton.frame.size.width, _loginButton.frame.size.height)];
    [_continueButton setTitle:@"Tap to continue" forState:UIControlStateNormal];
    [_continueButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _continueButton.center = CGPointMake(centerView.center.x, centerView.center.y + 30);
    [self showContinueButton];

    // _continueButton tap gesture
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateToAuctionListView)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [_continueButton addGestureRecognizer:tapGestureRecognizer];
    _continueButton.userInteractionEnabled = YES;

    [centerView addSubview:_loginButton];
    [centerView addSubview:_continueButton];

    centerView.center = self.view.center;
    [self.view addSubview:centerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigateToAuctionListView {
    [self performSegueWithIdentifier:@"TarBarSegue" sender:self];
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
    [self showContinueButton];
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    [self showContinueButton];
}

- (void)showContinueButton {
    _continueButton.hidden = ([FBSDKAccessToken currentAccessToken])? NO : YES;
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
