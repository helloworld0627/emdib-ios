//
//  EMMapViewController.h
//  EmdibApp
//
//  Created by Chris Kwok on 9/5/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface EMMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addAuctionBarItemButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBarItemButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
