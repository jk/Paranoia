//
//  ParanoiaAppDelegate.m
//  Paranoia
//
//  Created by Jens Kohl on 22.04.10.
//  Copyright Philipps-Universität Marburg 2010. All rights reserved.
//

#import "ParanoiaAppDelegate.h"
#import "ParanoiaViewController.h"

@implementation ParanoiaAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize locationManager = _locationManager;
@synthesize latString, lonString, lastUpdate;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
	
	UIDevice *device = [UIDevice currentDevice];
	
	
	NSLog(@"System: %@ %@\n  Name: %@, Model: %@, L-Model: %@\n  UUID: %@", device.systemName, device.systemVersion,
		 device.name, device.model, device.localizedModel, device.uniqueIdentifier);
	
	if ([launchOptions objectForKey:@"UIApplicationLaunchOptionsLocationKey"] != nil) {
		CLLocationManager *locationManager = [self locationManager];
		[locationManager setDelegate:self];
		[locationManager startMonitoringSignificantLocationChanges];
	}
	
	return YES;
}

#pragma mark CoreLocation delegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	NSLog(@"locationManager:didUpdateToLocation:fromLocation: called");
	
	// CLLocationCoordinate2D location = self.mapView.userLocation.coordinate;
	
	NSLog(@"Lat: %f Lon: %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
	
	UIDevice *device = [UIDevice currentDevice];
	
	NSString *url = [NSString stringWithFormat:@"http://jkohl.com/loc_bg/add.php?uuid=%@&latitude=%f&longitude=%f", 
					 device.uniqueIdentifier, newLocation.coordinate.latitude, newLocation.coordinate.longitude];
	NSLog(@"URL %@", url);
	
//	[self.latString setText:[NSString stringWithFormat:@"%f", newLocation.coordinate.latitude]];
//	[self.lonString setText:[NSString stringWithFormat:@"%f", newLocation.coordinate.longitude]];
//	[self.lastUpdate setText:[[NSDate date] description]];
	
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy
										  timeoutInterval:20.0];
	// create the connection with the request
	// and start loading the data
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (theConnection) {
		NSLog(@"Connection established");
	} else {
		NSLog(@"Something went wrong with the network request");
	}
}

-(CLLocationManager *)locationManager {
	if (_locationManager != nil) {
		return _locationManager;
	}
	
	_locationManager = [[CLLocationManager alloc] init];
	[_locationManager setPurpose:@"Send your location data to the internet and archive it there."];
//	_locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
	//_locationManager.delegate = self;
	
	NSLog(@"locationManager initialized");
	
	return _locationManager;
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
