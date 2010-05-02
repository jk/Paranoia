//
//  ParanoiaViewController.m
//  Paranoia
//
//  Created by Jens Kohl on 22.04.10.
//  Copyright Philipps-Universität Marburg 2010. All rights reserved.
//

#import "ParanoiaViewController.h"
#import "ParanoiaAppDelegate.h"

@implementation ParanoiaViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	CLLocationManager *locationManager = [[[UIApplication sharedApplication] delegate] locationManager];
	[locationManager setPurpose:@"Send your location data to the internet and archive it there."];
	[locationManager setDelegate:self];
	[locationManager startMonitoringSignificantLocationChanges];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	NSLog(@"viewDidAppear");
	
//	(ParanoiaAppDelegate *) appDelegate = [[UIApplication sharedApplication] delegate];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark CoreLocation delegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	NSLog(@"locationManager:didUpdateToLocation:fromLocation: called");
	
   // CLLocationCoordinate2D location = self.mapView.userLocation.coordinate;
	
	NSLog(@"Lat: %f Lon: %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
	
	UIDevice *device = [UIDevice currentDevice];
	
	NSString *url = [NSString stringWithFormat:@"http://jkohl.com/loc_bg/add.php?uuid=%@&latitude=%f&longitude=%f", 
					 device.uniqueIdentifier, newLocation.coordinate.latitude, newLocation.coordinate.longitude];
	NSLog(@"URL %@", url);
	
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

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[[[[UIApplication sharedApplication] delegate] locationManager] stopUpdatingLocation];
}


- (void)dealloc {
    [super dealloc];
}

@end
