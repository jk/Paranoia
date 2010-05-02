//
//  ParanoiaAppDelegate.h
//  Paranoia
//
//  Created by Jens Kohl on 22.04.10.
//  Copyright Philipps-Universität Marburg 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class ParanoiaViewController;

@interface ParanoiaAppDelegate : NSObject <UIApplicationDelegate, CLLocationManagerDelegate> {
	UIWindow *window;
	ParanoiaViewController *viewController;
	CLLocationManager *_locationManager;
	UILabel *latString;
	UILabel *lonString;
	UILabel *lastUpdate;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ParanoiaViewController *viewController;
@property (nonatomic, retain) CLLocationManager *locationManager;

@property (nonatomic, retain) IBOutlet UILabel *latString;
@property (nonatomic, retain) IBOutlet UILabel *lonString;
@property (nonatomic, retain) IBOutlet UILabel *lastUpdate;

- (CLLocationManager *)locationManager;

@end

