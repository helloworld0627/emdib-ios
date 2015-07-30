//
//  EMAuctionDetailLocationTableViewCell.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface EMAuctionDetailLocationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
