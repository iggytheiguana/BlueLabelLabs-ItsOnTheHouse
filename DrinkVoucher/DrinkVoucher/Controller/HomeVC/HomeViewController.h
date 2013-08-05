//
//  HomeViewController.h
//  DrinkVoucher
//
//  Created by Jitendra on 3/14/13.
//  Copyright (c) 2013 Jitendra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>

@interface HomeViewController : UIViewController<CLLocationManagerDelegate,MFMailComposeViewControllerDelegate>
{
    NSMutableData* responseData;
    CLLocationManager *locationManager;
    NSString *currentLatitude;
    NSString *currentLongitude;
    
    IBOutlet UIImageView *imgBack;
    IBOutlet UIButton *btnGetdrink;
    
    IBOutlet UILabel *lblInstruction;
    IBOutlet UIButton *btnTerms;
    
    NSMutableDictionary *dictPlist;
    
    BOOL MethodUpdateCall;
    
    AppDelegate *appDelegate;
    
    IBOutlet UILabel *lblRedeemedDate;
    
}
@property (nonatomic,retain)  IBOutlet UILabel *lblRedeemedDate;
@property (nonatomic,retain)  NSMutableDictionary *dictPlist;
@property (nonatomic,retain) UILabel *lblInstruction;
@property (nonatomic,retain) NSString *currentLatitude;
@property (nonatomic,retain) NSString *currentLongitude;
//@property (retain, nonatomic) NSMutableData* responseData;
@property (nonatomic, retain) CLLocationManager *locationManager;

-(IBAction)btnGetaFreedrink:(id)sender;
-(IBAction)termsOfUse:(id)sender;

-(IBAction)email_Clicked:(id)sender;

@end
