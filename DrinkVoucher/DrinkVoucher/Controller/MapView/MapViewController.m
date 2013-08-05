//
//  MapViewController.m
//  DrinkVoucher
//
//  Created by Jitendra on 3/29/13.
//  Copyright (c) 2013 Jitendra. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"

@interface MapViewController ()

@end

@implementation AddressAnnotation1

@synthesize coordinate;

//- (NSString *)subtitle
//{
//	return @"subtitle";
//}
//
- (NSString *)title
{
    AppDelegate *appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
	return [NSString stringWithFormat:@"%@",appDel.strBar];
}


- (id)initWithCoordinate:(CLLocationCoordinate2D) c
{
	coordinate = c;
	//NSLog(@"%f %f",c.latitude, c.longitude);
	return self;
}

@end

@implementation MapViewController

@synthesize strMaplatitude,strMapLongitude,strCurrentlatitude,strCurrentLongitude,strBarName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lblBarName.text=strBarName;
    
    coordinate.latitude=[self.strMaplatitude floatValue];
    coordinate.longitude=[self.strMapLongitude floatValue];
    
    currentCoordinate.latitude=[self.strCurrentlatitude floatValue];
    currentCoordinate.longitude=[self.strCurrentLongitude floatValue];
    
    latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    //NSLog(@"%@",latitude);
    //NSLog(@"%@",longitude);
    AppDelegate *appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDel logWithString:@"MAP SCREEN"];
    
    double miles = 0.62137;
    double scalingFactor = ABS( (cos(2 * M_PI * coordinate.latitude / 360.0) ));
    
    MKCoordinateSpan span;
    
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/(scalingFactor * 69.0);
    
    MKCoordinateRegion region;
    region.span = span;
    region.center.latitude = coordinate.latitude;
    region.center.longitude = coordinate.longitude;
    
    [mapView setRegion:region animated:YES];
    
    mapView.mapType = MKMapTypeStandard;
    
    mapView.showsUserLocation=YES;
	
	if(addAnnotation != nil)
	{
		[mapView removeAnnotation:addAnnotation];
		addAnnotation = nil;
	}
	addAnnotation = [[AddressAnnotation1 alloc]initWithCoordinate:coordinate];
	[mapView addAnnotation:addAnnotation];
}

#pragma mark - Button Action method

-(IBAction)btnBackAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(IBAction)btnGetdirectionmethod:(id)sender
{
    //create MKMapItem out of coordinates
    NSString* versionNum = [[UIDevice currentDevice] systemVersion];
    NSString *nativeMapScheme = @"maps.apple.com";
    if ([versionNum compare:@"6.0" options:NSNumericSearch] == NSOrderedAscending)
        nativeMapScheme = @"maps.google.com";
  
  NSString* url = [NSString stringWithFormat: @"http://%@/maps?saddr=%f,%f&daddr=%f,%f", nativeMapScheme,
                 currentCoordinate.latitude, currentCoordinate.longitude,
                 coordinate.latitude, coordinate.longitude];
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
    
}
-(IBAction)btnCurrentLocation:(id)sender
{
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    [mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];
    [mapView setDelegate:self];
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
