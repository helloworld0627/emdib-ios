//
//  EMAuction+MKAnnotation.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/29/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMAuction+MKAnnotation.h"

@implementation EMAuction(MKAnnotation)

// Center latitude and longitude of the annotation view.
// The implementation of this property must be KVO compliant.
-(CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longtitude.doubleValue);
}

// Title and subtitle for use by selection UI.
- (NSString*)title {
    return self.auctionTitle;
}

@end
