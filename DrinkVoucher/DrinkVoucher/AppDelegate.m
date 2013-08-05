    //
//  AppDelegate.m
//  DrinkVoucher
//
//  Created by Jitendra on 3/14/13.
//  Copyright (c) 2013 Jitendra. All rights reserved.
//

#import "AppDelegate.h"

#import "SplashViewController.h"
#import "Reachability.h"
#import <Crashlytics/Crashlytics.h>

@implementation AppDelegate

@synthesize window = _window;
@synthesize splashViewController = _splashViewController;
@synthesize navigationController = _navigationController;
@synthesize dictBardetail;
@synthesize userGetredeemed;
@synthesize strBar,isCurrentVoucherActive;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //NSLog(@"Local Time Zone %@",[[NSTimeZone localTimeZone] name]);
    //NSLog(@"System Time Zone %@",[[NSTimeZone systemTimeZone] name]);
    [Crashlytics startWithAPIKey:@"b53fcf08df9b183b382153735d57a10862fc5348"];
    
    [self logWithString:@"APPLICATION LAUNCHING"];
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirst"])
    {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"New" forKey:@"Status"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirst"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSMutableDictionary *dictPlist=[[NSMutableDictionary alloc]init];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Status"] isEqualToString:@"Current"]) {
        
        if ([self isNetWorkAvailable]) {
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            if ( ![fileManager fileExistsAtPath:[self documentPath]] ) {
            } else
            {
                dictPlist= [NSMutableDictionary dictionaryWithContentsOfFile:[self documentPath]];
                
                //NSLog(@"UserBar Detail : %@",dictPlist);
                
                //[NSString stringWithFormat:@"UserBar Detail : %@",dictPlist];
                [self logWithString:[NSString stringWithFormat:@"UserBar Detail : %@",dictPlist]];
            }
            
            NSDate *currentDateTime = [NSDate date];
            
            // Instantiate a NSDateFormatter
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            // Set the dateFormatter format
            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
            
            // Get the date time in NSString
            NSString *dateInString = [self dateFromLatLong]; // [dateFormatter stringFromDate:currentDateTime];
            
            NSURL * url = [NSURL URLWithString:VOUCHER_ACTIVE];
            
            //Request
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            
            NSString *strUserId=[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"];
            
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            [dic setValue:strUserId forKey:@"userId"];
            [dic setValue:[dictPlist objectForKey:@"bar_id"] forKey:@"bar_id"];
            [dic setValue:dateInString forKey:@"Date"];
            
            NSString *jsonString = [dic JSONRepresentation];
            
            //NSLog(@"jsonString : %@",jsonString);
            
            [self logWithString:[NSString stringWithFormat:@"VOUCHER_ACTIVE (http://itisonth.w13.wh-2.com/WS/IsVocherActive) > request : %@",jsonString]];
            
            NSData* requestData =[jsonString dataUsingEncoding:NSUTF8StringEncoding] ; // [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            
            //prepare http body
            [request setHTTPMethod:@"POST"];
            [request setValue:[NSString stringWithFormat:@"%d",[requestData length]] forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:requestData];
            
            NSError *error;
            NSURLResponse *response;
            
            NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            if (error) {
                
            }else
            {
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                NSDictionary *temp=[responseString JSONValue];
                
                //NSLog(@"temp : %@",temp);
                
                [self logWithString:[NSString stringWithFormat:@"VOUCHER_ACTIVE > response : %@",dictPlist]];
                
                self.isCurrentVoucherActive=[[temp objectForKey:@"IsVocherActive"] integerValue];
                //NSLog(@"self.isCurrentVoucherActive : %d",self.isCurrentVoucherActive);
                
                
                if (self.isCurrentVoucherActive==1) {
                    
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"userGetredeemed"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                if ([[temp objectForKey:@"IsVocherRedeem"] integerValue] == 1) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"Redeemed" forKey:@"Status"];
                    //  [[NSUserDefaults standardUserDefaults] setObject:newDateString forKey:@"redeemedTime"];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"userGetredeemed"];
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                }
            }
            
        }
        else
        {
            //        self.isCurrentVoucherActive=0;
            
            //        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"OntheHouse" message:@"Please check your internet connection and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //        [alert show];
        }
        
        
    }else  if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Status"] isEqualToString:@"Redeemed"])
    {
        NSDate * now = [NSDate date];
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        //[outputFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        //[outputFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *CurrentTime = [outputFormatter stringFromDate:now];
        
        
        
        NSDateFormatter *df=[[NSDateFormatter alloc] init];
        // Set the date format according to your needs
        //[df setTimeZone:[NSTimeZone systemTimeZone]];
        // [df setDateFormat:@"MM/dd/YYYY hh:mm a"]; //for 12 hour format
        //[df setDateFormat:@"MM/dd/yyyy HH:mm:ss"] ; // for 24 hour format
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"] ; // for 24 hour format
        NSDate *dateNow = [df dateFromString:CurrentTime];
        //NSLog(@"dateNow %@", dateNow);
        
        NSString *strRedeemedtime=[[NSUserDefaults standardUserDefaults] valueForKey:@"redeemedTime"];
        NSDate *dateRedeem = [df dateFromString:strRedeemedtime];
        //NSLog(@"dateRedeem %@", dateRedeem);
        
        float diffFrmNow=[dateNow timeIntervalSinceDate:dateRedeem];
        //NSLog(@"diffFrmNow : %f",diffFrmNow);
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        // Extract date components into components1
        NSDateComponents *componentsFromNow = [gregorianCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:now];
        
        // Combine date and time into components3
        NSDateComponents *componentsNew = [[NSDateComponents alloc] init];
        
        [componentsNew setYear:componentsFromNow.year];
        [componentsNew setMonth:componentsFromNow.month];
        [componentsNew setDay:componentsFromNow.day];
        [componentsNew setHour:4];
        [componentsNew setMinute:30];
        [componentsNew setSecond:0];
        
        // Generate a new NSDate from components3.
        NSDate *temDate = [gregorianCalendar dateFromComponents:componentsNew];
        NSString *combinedDateStr = [outputFormatter stringFromDate:temDate];
        NSDate *combinedDate = [df dateFromString:combinedDateStr];
        
        //NSLog(@"combinedDate : %@",combinedDate);
        
        NSDateFormatter *dateformater=[[NSDateFormatter alloc] init];
        // Set the date format according to your needs
        //[dateformater setTimeZone:[NSTimeZone systemTimeZone]];
        // [df setDateFormat:@"MM/dd/YYYY hh:mm a"]; //for 12 hour format
        //[dateformater setDateFormat:@"MM/dd/yyyy HH:mm:ss"] ; // for 24 hour format
        [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"] ; // for 24 hour format
        //NSDate *dateRedeem = [df dateFromString:combinedDate];
        
        float diffFromResetTime=[combinedDate timeIntervalSinceDate:dateRedeem];
        //NSLog(@"diffFromResetTime : %f",diffFromResetTime);
        
        
        if (diffFromResetTime < 0) {
            
            diffFromResetTime = 24*60*60 -diffFromResetTime;
        }
        
        if (diffFrmNow >= diffFromResetTime)
        {
            //NSLog(@"inside");
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"userGetredeemed"];
            [[NSUserDefaults standardUserDefaults] setObject:@"New" forKey:@"Status"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            //NSLog(@"not inside");
        }
        
    }else{
        
        self.isCurrentVoucherActive=1;
    }
    
    //NSLog(@"userGetredeemed %d",[[NSUserDefaults standardUserDefaults] boolForKey:@"userGetredeemed"]);
    
   
    
    self.splashViewController = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.splashViewController];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *arrayPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"userBardetail.plist"];
    
    return arrayPath;
}

#pragma mark - Get User's TimeZone Google Api

-(NSString *)dateFromLatLong
{
     NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/timezone/json?location=null,null&timestamp=1360313094.992256&sensor=true"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSError *error;
    NSURLResponse *response;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSDictionary *temp=[responseString JSONValue];
    
    //NSLog(@"temp TimeZone: %@",temp);
    
     [self logWithString:[NSString stringWithFormat:@"User TimeZone : %@",temp]];
    
    NSString *strTimeZone = [temp objectForKey:@"timeZoneId"];
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:strTimeZone]];
    //NSLog(@"3. %@",[formatter stringFromDate:now]);

    NSString *strReturn= [formatter stringFromDate:now];
    
    //NSLog(@"strReturn : %@",strReturn);
    [self logWithString:[NSString stringWithFormat:@"dateFromLatLong return parameter : %@",strReturn]];

    return strReturn;
}



#pragma mark - Network Reachability method
- (BOOL)isNetWorkAvailable
{
	Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    if ([reach currentReachabilityStatus] == NotReachable)
        return NO;
    else
        return YES;
    
}

#pragma mark
#pragma mark Create log file
- (void)logWithString:(NSString *)string
{
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy hh:mm"];
    
    
    // Create the file
    NSError *error;
    
    // Directory
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"log.txt"];
    
    // Get the file contents
    NSData *localData = [NSData dataWithContentsOfFile:filePath];
    if (localData) {
        NSString *logString = [[NSString alloc] initWithData:localData encoding:NSUTF8StringEncoding];
        string = [logString stringByAppendingFormat:@"\n At time %@\n %@\n", [formatter stringFromDate:now],string];
        //[logString release];
    }
    
    // Write to the file
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    //[formatter release];
    
}

#pragma mark - Application  method
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    exit(0);
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
