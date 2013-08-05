//
//  BarDetailViewController.h
//  DrinkVoucher
//
//  Created by Jitendra on 3/19/13.
//  Copyright (c) 2013 Jitendra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
@interface AddressAnnotation : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
	NSString *mTitle;
	NSString *mSubTitle;
   
}
@end

@interface BarDetailViewController : UIViewController<CLLocationManagerDelegate,UIWebViewDelegate,UIAlertViewDelegate>
{
    IBOutlet MKMapView *mapView;
	
	AddressAnnotation *addAnnotation;
    CLLocationManager *locationManager;
    
    NSString *currentLatitude;
    NSString *currentLongitude;
    
    NSString *BarLatitude;
    NSString *BarLongitude;
    
    IBOutlet UIImageView *imgBack;
    AppDelegate *appDel;
     
    UIWebView *webview;
    
    IBOutlet UIImageView *imgBar;
    IBOutlet UILabel *lblbarAddress;
    IBOutlet UILabel *lblCityState;
    IBOutlet UILabel *lblCountryZip;
    IBOutlet UILabel *lblbarName;
    IBOutlet UILabel *lblvoucherMsg;
    IBOutlet UILabel *lblOpendaily;
    
    IBOutlet UIButton *btnDealAction;
    
    IBOutlet UIImageView *imgBottomBar;
    
     NSMutableData* responseData;
    
    IBOutlet UILabel *lblTimer;
    IBOutlet UIImageView *imgChkbox;
    NSInteger time;
    NSTimer *timer;
    
    IBOutlet UIButton *btnCall;
    IBOutlet UIButton *btnWebSite;
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnMap;
    
    IBOutlet UIScrollView *scrlView;
    IBOutlet UILabel *lblDetail;
    IBOutlet UIView *detailView,*barView;
    
    UILabel *lblRedeemedDate;
    
}
@property(nonatomic,retain) IBOutlet UILabel *lblRedeemedDate;
@property(nonatomic,retain)UIImageView *imgBar;

//@property(nonatomic,retain)NSMutableData* responseData;
@property (nonatomic,retain) NSString *currentLatitude;
@property (nonatomic,retain) NSString *currentLongitude;

@property (nonatomic,retain) NSString *BarLatitude;
@property (nonatomic,retain) NSString *BarLongitude;

@property (nonatomic, retain) CLLocationManager *locationManager;
//-(CLLocationCoordinate2D) addressLocation;
-(IBAction)btnBackAction:(id)sender;
-(IBAction)btnMapAction:(id)sender;
-(IBAction)btnDealAction:(id)sender;

-(IBAction)btnWebsiteAction:(id)sender;
-(IBAction)btnPhoneAction:(id)sender;

@end
