//
//  MapViewController.h
//  DrinkVoucher
//
//  Created by Jitendra on 3/29/13.
//  Copyright (c) 2013 Jitendra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation1 : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
	NSString *mTitle;
	NSString *mSubTitle;
}

@end
@interface MapViewController : UIViewController<MKMapViewDelegate>
{
    IBOutlet MKMapView *mapView;
	
	AddressAnnotation1 *addAnnotation;
    
    NSString *strMaplatitude;
    NSString *strMapLongitude;
    
    NSString *strCurrentlatitude;
    NSString *strCurrentLongitude;
    
    NSString *latitude;
    NSString *longitude;
    
    CLLocationCoordinate2D coordinate;
    CLLocationCoordinate2D currentCoordinate;
    
    NSString *strBarName;
    
    IBOutlet UILabel *lblBarName;
    
}
@property(nonatomic,retain)  NSString *strBarName;
@property(nonatomic,retain) NSString *strMaplatitude;
@property(nonatomic,retain) NSString *strMapLongitude;

@property(nonatomic,retain) NSString *strCurrentlatitude;
@property(nonatomic,retain) NSString *strCurrentLongitude;

-(IBAction)btnBackAction:(id)sender;
-(IBAction)btnGetdirectionmethod:(id)sender;
-(IBAction)btnCurrentLocation:(id)sender;
@end
