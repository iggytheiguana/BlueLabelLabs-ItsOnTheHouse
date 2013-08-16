//
//  LoginViewController.m
//  DrinkVoucher
//
//  Created by Jitendra on 3/14/13.
//  Copyright (c) 2013 Jitendra. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "JSON.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import <Social/Social.h>
#import <Accounts/ACAccountType.h>
#import <Accounts/ACAccountCredential.h>

static NSString* kAppId = @"164117317078099";
#define KFBAccessToken		@"104051569693502"
#define KFBExpirationDate	@"KFBExpirationDate"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize btnAge,btnFacebook;
@synthesize facebook;
@synthesize accountStore;
@synthesize facebookAccount;
@synthesize imgBack;
//@synthesize arrayOfAccounts;

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
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //[appDelegate logWithString:@"LOGIN SCREEN"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountChanged:)name:ACAccountStoreDidChangeNotification object:nil];

    if([[NSUserDefaults standardUserDefaults] boolForKey:@"UserLogin"])
    {
        HomeViewController *obj_homeView=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        [self.navigationController pushViewController:obj_homeView animated:YES];
        [obj_homeView release];
    }
    
        permissions  = [[NSArray alloc] initWithObjects:@"offline_access",@"email",@"user_birthday",nil];
	
        facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [imgBack setImage:[UIImage imageNamed:@"Signup_screen_new_5.png"]];
        [btnFacebook setFrame:CGRectMake(37, 458, 247, 58)];
        [lblAgeverify setFrame:CGRectMake(110, 396, 133, 21)];
        [btnTerms setImage:[UIImage imageNamed:@"termsuse_1-1.png"] forState:UIControlStateNormal];
    }
    else
    {
        [imgBack setImage:[UIImage imageNamed:@"signup_screen.png"]];
        [btnFacebook setFrame:CGRectMake(37, 460, 247, 58)];
        [lblAgeverify setFrame:CGRectMake(110, 414, 133, 21)];
        [btnTerms setImage:[UIImage imageNamed:@"termsuse_1-1.png"] forState:UIControlStateNormal];
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Action method

-(IBAction)btnAgeVerification:(id)sender
{
    if (btnAge.selected)
    {
        btnAge.selected=NO;
        btnFacebook.userInteractionEnabled=NO;
    }
    else
    {
        btnAge.selected=YES;
        btnFacebook.userInteractionEnabled=YES;
    }
}

-(IBAction)btnFacebook:(id)sender
{
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"This app is age restricted. Click OK to confirm that you are 21 or over." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.tag=10;
    [alert show];
    [alert release];
    
}

-(IBAction)termsOfUse:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.itisonthehouse.com/terms-of-service--privacy-policy.html"]];
}

#pragma mark - Facebook API Calls
/**
 * Make a Graph API Call to get information about the current logged in user.
 */
- (void)apiFQLIMe {
    // Using the "pic" picture since this currently has a maximum width of 100 pixels
    // and since the minimum profile picture size is 180 pixels wide we should be able
    // to get a 100 pixel wide version of the profile picture
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, email, first_name,last_name, birthday, sex FROM user WHERE uid=me()", @"query",
                                   nil];
    [self.facebook requestWithMethodName:@"fql.query"
                                     andParams:params
                                 andHttpMethod:@"POST"
                                   andDelegate:self];
}

- (void)apiGraphUserPermissions {

    [self.facebook requestWithGraphPath:@"me/permissions" andDelegate:self];
}


#pragma - Private Helper Methods

/**
 * Show the logged in menu
 */

- (void)showLoggedIn {
    
    [self apiFQLIMe];
}

/**
 * Show the logged in menu
 */

- (void)showLoggedOut {
}

/**
 * Show the authorization dialog.
 */
- (void)login {

    if (![self.facebook isSessionValid]) {
        [self.facebook authorize:permissions];
    } else {
        [self showLoggedIn];
    }
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {

    [self.facebook logout];
}
#pragma mark - FBSessionDelegate Methods
/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    
    [self showLoggedIn];
    
    [self storeAuthData:[self.facebook accessToken] expiresAt:[self.facebook expirationDate]];
    
//    [pendingApiCallsController userDidGrantPermission];
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
     //NSLog(@"token extended");
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
//    [pendingApiCallsController userDidNotGrantPermission];
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
//    pendingApiCallsController = nil;
    
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     [defaults removeObjectForKey:@"FBAccessTokenKey"];
     [defaults removeObjectForKey:@"FBExpirationDateKey"];
     [defaults synchronize];
    
     [self showLoggedOut];
}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:@"Your session has expired."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    [alertView release];
    [self fbDidLogout];
}

#pragma mark - FBRequestDelegate Methods
/**
 * Called when the Facebook API request has returned a response.
 *
 * This callback gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    ////NSLog(@"received response");
}

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array or a string, depending
 * on the format of the API response. If you need access to the raw response,
 * use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
    
     //NSLog(@"Inside didLoad");
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    ////NSLog(@"result : %@",result);
    
   // [appDelegate logWithString:[NSString stringWithFormat:@"Facebook user detail :\n %@",result]];
    
    // When we ask for user infor this will happen.
    if ([result isKindOfClass:[NSDictionary class]]){
 
    }
    if ([result isKindOfClass:[NSData class]])
    {
        //NSLog(@"Profile Picture");
    }
    //   //NSLog(@"request returns %@",result);
    
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"MMMM DD, YYYY"];
     NSDate *date = [NSDate date];
     NSString *todayDate = [dateFormatter stringFromDate:date];
     [dateFormatter release];
    
     NSString *userDate= [result objectForKey:@"birthday"];
    
     NSDateFormatter *formater = [[NSDateFormatter alloc] init];
     [formater setDateFormat:@"MMMM DD, YYYY"];
    
     NSDate *startDate = [formater dateFromString:userDate];
    
     NSDateFormatter *formater1 = [[NSDateFormatter alloc] init];
     [formater1 setDateFormat:@"MMMM DD, YYYY"];
     NSDate *endDate = [formater1 dateFromString:todayDate];
     [formater release];
     [formater1 release];
    
     NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
     NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
     [gregorianCalendar release];
   
     int age=[components day];
     NSString *strAge=[NSString stringWithFormat:@"%d",age/365];
    
     NSMutableDictionary * dic = [NSMutableDictionary dictionary];
     responseData = [[NSMutableData alloc] init];
    
     NSDate *currentDateTime = [NSDate date];
    
     // Instantiate a NSDateFormatter
     NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    
     // Set the dateFormatter format
//    2013-06-21  20:12 :00
     [dateFormatter1 setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
//    [dateFormatter1 setDateFormat:@"DD-MMMM-yyyy HH:mm:ss"];
    
     // Get the date time in NSString
     //09NSString *dateInString = [dateFormatter1 stringFromDate:currentDateTime];
    
     NSString *dateInString = [appDelegate dateFromLatLong];
    
     // Release the dateFormatter
     [dateFormatter1 release];
    

    
     [dic setValue:[result objectForKey:@"first_name"] forKey:@"Fname"];
     [dic setValue:[result objectForKey:@"last_name"] forKey:@"Lname"];
    
    //[dic setValue:@"testsoft123.255@gmail.com" forKey:@"Email"];
     [dic setValue:[result objectForKey:@"email"] forKey:@"Email"];
     [dic setValue:strAge forKey:@"Age"];
     [dic setValue:[result objectForKey:@"sex"] forKey:@"Sex"];
     [dic setValue:dateInString forKey:@"Date"];
    
     [self execMethod:dic];
    
};


/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    //NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    //NSLog(@"Err code: %d", [error code]);
}

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array or a string, depending
 * on the format of the API response. If you need access to the raw response,
 * use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */


#pragma mark -
#pragma mark Process  data


-(void) execMethod:(NSMutableDictionary *)dic{
    
    NSURL * url = [NSURL URLWithString:REGISTER];
    
    //NSMutableDictionary * headerDic = [NSMutableDictionary dictionary];
    //[headerDic setObject:@"AddPhoto" forKey:@"name"];
//    NSMutableDictionary * bodyDic = [NSMutableDictionary dictionary];
//        
//    // Release the dateFormatter
//    [bodyDic setValue:@"nignesh.patel@tatvasoft.com" forKey:@"Email"];
//    [bodyDic setValue:@"Patel" forKey:@"LName"];
//    [bodyDic setValue:@"Nignesh" forKey:@"Fname"];
//    [bodyDic setValue:@"25" forKey:@"Age"];
//    [bodyDic setValue:@"M" forKey:@"Sex"];
//    [bodyDic setValue:@"2013-07-29 12:18:16" forKey:@"Date"];
//    //[headerDic setObject:bodyDic forKey:@"body"];
    
    
    //Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *jsonString = [dic JSONRepresentation];
    //NSString *jsonString = [dic JSONRepresentation];
    
    //NSLog(@"jsonString user: %@",jsonString);
    
    //[appDelegate logWithString:[NSString stringWithFormat:@"REGISTER (http://itisonth.w13.wh-2.com/WS/register) > request : %@",jsonString]];
    
    NSData* requestData =[jsonString dataUsingEncoding:NSUTF8StringEncoding] ; // [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    //prepare http body
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d",[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:requestData];
    
    //  NSURLConnection *urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
     [NSURLConnection connectionWithRequest:request delegate:self];
    //  //NSLog(@"%@",urlConnection);
    [request release];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"%@",[error description]);
   // [appDelegate logWithString:[NSString stringWithFormat:@"REGISTER > request didFailWithError : %@",[error description]]];
    
	//[connection release];
	responseData = nil;
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"The request timed out. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    //[connection release];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString* userID = nil;
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *temp=[responseString JSONValue];
    //NSLog(@"temp : %@",temp);
    //[appDelegate logWithString:[NSString stringWithFormat:@"REGISTER > response : %@",responseString]];
    
    if (temp) {
        
        if ([temp objectForKey:@"bar_Detail"]==[NSNull null]) {
            NSLog(@"get bar detail null");
            
        }
        else if ([temp objectForKey:@"bar_Detail"])
        {
            NSString *strBarId=[NSString stringWithFormat:@"%@",[temp objectForKey:@"bar_id"]];
            
            if (![strBarId isEqualToString:@"0"])
            {
                if ([[[[responseString JSONValue] objectForKey:@"bar_Detail"] objectForKey:@"vochr_IsRedeem"] isEqualToString:@"1"])
                {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"Redeemed" forKey:@"Status"];
                    
                    NSString *str=[[temp objectForKey:@"bar_Detail"] objectForKey:@"vochr_date_Redeem"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"redeemedTime"];
                    
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"userGetredeemed"];
                    
                    NSString *newDateString=[[temp objectForKey:@"bar_Detail"] objectForKey:@"vochr_date_Redeem"];
                    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
                    [formater setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
                    NSDate *date=[formater dateFromString:newDateString];
                    
                    [formater setDateFormat:@"MM/dd/yyyy hh:mm a"];
                    NSString *strDate=[formater stringFromDate:date];
                    
                    //NSLog(@"strDate : %@",strDate);
                    [[NSUserDefaults standardUserDefaults] setObject:strDate forKey:@"UserRedeemedTime"];
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                }else if ([[[temp objectForKey:@"bar_Detail"] objectForKey:@"vochr_IsRedeem"] isEqualToString:@"0"]){
                    
                    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                    
                    appDelegate.isCurrentVoucherActive=1;
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"Current" forKey:@"Status"];
                    
                    NSString *str=[[temp objectForKey:@"bar_Detail"] objectForKey:@"vochr_date_Redeem"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"redeemedTime"];
                    
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"userGetredeemed"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[[responseString JSONValue] objectForKey:@"bar_Detail"] objectForKey:@"bar_ToHours"] forKey:@"barEndtime"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [[temp objectForKey:@"bar_Detail"] writeToFile:[self documentPath] atomically:YES];
                    
                }
            }
        }
        
        if ([temp objectForKey:@"userId"]) {
            
            userID = [temp objectForKey:@"userId"];
        }
        else if ([temp objectForKey:@"UserId"])
        {
            userID = [temp objectForKey:@"UserId"];
        }
        [responseString release];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:[userID integerValue]] forKey:@"userID"];
        responseData = nil;
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UserLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        HomeViewController *obj_Home=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        [self.navigationController pushViewController:obj_Home animated:YES];
        [obj_Home release];
        
    }else{
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"The request error. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }    
}


-(NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *arrayPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"userBardetail.plist"];
    
    return arrayPath;
}

-(void)facebookLogin
{
    if ([self.facebook isSessionValid])
        // [self logout];
        [self performSelector:@selector(logout) withObject:nil afterDelay:0.01];
    else
        [self performSelector:@selector(login) withObject:nil afterDelay:0.01];
        //    if ([_facebook isSessionValid]) {
        //		[self sharewithFacebook:nil];
        //	} else {
        //[self login];
        //}
}

#pragma mark - Alert delegate method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==10&&buttonIndex==1)
    {
        
        [self performSelector:@selector(getLoginwithFacebook) withObject:nil afterDelay:0.2];
    }
}

#pragma mark - Fetch data from facebook

-(void)getLoginwithFacebook
{
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (ver >= 6.0)
    {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        accountStore = [[ACAccountStore alloc]init];
        ACAccountType *FBaccountType= [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
        
        NSString *key =@"164117317078099";
        NSDictionary *dictFB = [NSDictionary dictionaryWithObjectsAndKeys:key,ACFacebookAppIdKey,@[@"email",@"user_location",@"user_hometown",@"user_birthday"],ACFacebookPermissionsKey, nil];
        
        
        [self.accountStore requestAccessToAccountsWithType:FBaccountType options:dictFB completion:
         ^(BOOL granted, NSError *e) {
             if (granted) {
                 NSArray *accounts = [self.accountStore accountsWithAccountType:FBaccountType];
                 //it will always be the last object with single sign on
                 self.facebookAccount = [accounts lastObject];
                 //NSLog(@"facebook account =%@",self.facebookAccount);
                 
                // [appDelegate logWithString:@"Facebook account Authenticated"];
                 
                 [self get];
             } else {
                 //Fail gracefully...
                 //NSLog(@"error getting permission %@",e);
                 //AppDelegate *appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
                 
                // [appDelegate logWithString:@"Open Facebook dialog IOS > 6"];
                 
                 if ([appDelegate isNetWorkAvailable]) {
                     //  [self performSelector:@selector(facebookLogin) withObject:nil afterDelay:0.5];
                     [self performSelectorOnMainThread:@selector(facebookLogin) withObject:nil waitUntilDone:YES];
                 }
                 else
                 {
                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"Please check your internet connection and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     [alert show];
                     [alert release];
                 }
                 
             }
         }];
        
    }
    else
    {
        AppDelegate *appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
      //  [appDelegate logWithString:@"Open Facebook dialog IOS < 6"];
        
        if ([appDel isNetWorkAvailable]) {
            [self performSelector:@selector(facebookLogin) withObject:nil afterDelay:0.5];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"Please check your internet connection and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }

}

-(void)get
{
    
          NSURL *requestURL = [NSURL URLWithString:@"https://graph.facebook.com/me"];
    
          SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                            requestMethod:SLRequestMethodGET
                                                      URL:requestURL
                                               parameters:nil];
          request.account = self.facebookAccount;
    
          [request performRequestWithHandler:^(NSData *data,
                                         NSHTTPURLResponse *response,
                                         NSError *error) {
        
        if(!error)
        {
            list =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            NSLog(@"Dictionary contains: %@", list );
            
            //[appDelegate logWithString:[NSString stringWithFormat:@"Facebook user detail :\n %@",list]];
            
            
            if([list objectForKey:@"error"]!=nil)
            {
                [self attemptRenewCredentials];
            }
            dispatch_async(dispatch_get_main_queue(),^{
            //nameLabel.text = [list objectForKey:@"username"];
            });
        }
        else{
            //handle error gracefully
            //NSLog(@"error from get%@",error);
            //attempt to revalidate credentials
        }
        //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/DD/YYYY"];
        NSDate *date = [NSDate date];
        NSString *todayDate = [dateFormatter stringFromDate:date];
        [dateFormatter release];
        
        NSString *userDate= [list objectForKey:@"birthday"];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"MM/DD/YYYY"];
        
        NSDate *startDate = [formater dateFromString:userDate];
        
        NSDateFormatter *formater1 = [[NSDateFormatter alloc] init];
        [formater1 setDateFormat:@"MM/DD/YYYY"];
        NSDate *endDate = [formater1 dateFromString:todayDate];
        [formater release];
        [formater1 release];
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                            fromDate:startDate
                                                              toDate:endDate
                                                             options:0];
        [gregorianCalendar release];
        //NSLog(@"%d", [components day]);
        int age=[components day];
        NSString *strAge=[NSString stringWithFormat:@"%d",age/365];
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        responseData = [[NSMutableData alloc] init];
        
        NSDate *currentDateTime = [NSDate date];
        
        // Instantiate a NSDateFormatter
//        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
//        
//        // Set the dateFormatter format
//              
//        [dateFormatter1 setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        
        // Get the date time in NSString
        //      NSString *dateInString = @"2013-07-29 13:39:50"; // [appDelegate dateFromLatLong]; // [dateFormatter1 stringFromDate:currentDateTime];
        
        // Release the dateFormatter
//        [dateFormatter1 release];

        NSString *dateInString = [appDelegate dateFromLatLong];
        
        [dic setValue:[list objectForKey:@"first_name"] forKey:@"Fname"];
        [dic setValue:[list objectForKey:@"last_name"] forKey:@"Lname"];
        [dic setValue:[list objectForKey:@"email"] forKey:@"Email"];
        [dic setValue:strAge forKey:@"Age"];
        [dic setValue:[list objectForKey:@"gender"] forKey:@"Sex"];
        [dic setValue:dateInString forKey:@"Date"];
        
       // [self execMethod:dic];
        
       // [self performSelector:@selector(execMethod:) withObject:dic afterDelay:0.1];
        [self performSelectorOnMainThread:@selector(execMethod:) withObject:dic waitUntilDone:YES];

        
    }];
}

-(void)accountChanged:(NSNotification *)notif//no user info associated with this notif
{
    [self attemptRenewCredentials];
}
-(void)attemptRenewCredentials{
    [self.accountStore renewCredentialsForAccount:(ACAccount *)self.facebookAccount completion:^(ACAccountCredentialRenewResult renewResult, NSError *error){
        if(!error)
        {
            switch (renewResult) {
                case ACAccountCredentialRenewResultRenewed:
                    //NSLog(@"Good to go");
                   // [self get];
                    break;
                case ACAccountCredentialRenewResultRejected:
                    //NSLog(@"User declined permission");
                    break;
                case ACAccountCredentialRenewResultFailed:
                    //NSLog(@"non-user-initiated cancel, you may attempt to retry");
                    break;
                default:
                    break;
            }
            
        }
        else{
            //handle error gracefully
            //NSLog(@"error from renew credentials%@",error);
        }
    }];
    
    
}

#pragma mark - Memory Management method
-(void)dealloc
{
    [responseData release];
    [super dealloc];
}
- (void)viewDidUnload
{
    [self setImgBack:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
