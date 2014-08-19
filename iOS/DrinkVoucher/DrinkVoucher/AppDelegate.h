#import <UIKit/UIKit.h>
//#import "NetworkReachability.h"
#import "FBConnect.h"
#import "JSON.h"
#import <MapKit/MapKit.h>
@class SplashViewController;

@interface AppDelegate : UIResponder  <UIApplicationDelegate, CLLocationManagerDelegate>
{
    NSMutableDictionary *dictBardetail;
    BOOL userGetredeemed;
    NSString *strBar;
    CLLocationManager *locationManager;
    NSInteger isCurrentVoucherActive;
    NSString *currentLatitude;
    NSString *currentLongitude;
    
}
- (BOOL)isNetWorkAvailable;


@property(nonatomic,assign) BOOL userGetredeemed;
@property(nonatomic,assign) NSInteger isCurrentVoucherActive;
@property(nonatomic,retain) NSMutableDictionary *dictBardetail;
@property(nonatomic,retain) NSString *strBar;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SplashViewController *splashViewController;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic,retain) NSString *currentLatitude;
@property (nonatomic,retain) NSString *currentLongitude;
-(NSString *)dateFromLatLong;
- (void)logWithString:(NSString *)string;

@end
