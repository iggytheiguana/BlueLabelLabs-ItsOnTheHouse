#import <UIKit/UIKit.h>
//#import "NetworkReachability.h"
#import "FBConnect.h"
#import "JSON.h"

@class SplashViewController;

@interface AppDelegate : UIResponder  <UIApplicationDelegate>
{
    NSMutableDictionary *dictBardetail;
    BOOL userGetredeemed;
    NSString *strBar;
    
    NSInteger isCurrentVoucherActive;
    
}
- (BOOL)isNetWorkAvailable;


@property(nonatomic,assign) BOOL userGetredeemed;
@property(nonatomic,assign) NSInteger isCurrentVoucherActive;
@property(nonatomic,retain) NSMutableDictionary *dictBardetail;
@property(nonatomic,retain) NSString *strBar;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SplashViewController *splashViewController;

-(NSString *)dateFromLatLong;
- (void)logWithString:(NSString *)string;

@end
