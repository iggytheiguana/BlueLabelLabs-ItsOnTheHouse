
#import "HomeViewController.h"
#import "BarDetailViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "JSON.h"
@interface HomeViewController ()

@end


@implementation HomeViewController

//@synthesize responseData;
@synthesize locationManager;
@synthesize currentLatitude,currentLongitude;
@synthesize lblInstruction,dictPlist;
@synthesize lblRedeemedDate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - NSDate Component

-(NSDateComponents *)componenetFromDate:(NSString *)strDate 
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    
    //    NSString *strTimeZone=[self timeZoneFromFromLatLong];
    //
    //    if ([strTimeZone isEqualToString:@"Error"]) {
    //
    //        [formatter setTimeZone:[NSTimeZone localTimeZone]];
    //
    //    }else{
    //
    //        [formatter setTimeZone:[NSTimeZone timeZoneWithName:strTimeZone]];
    //    }
    //
    
    
    NSDate *date=[formatter dateFromString:strDate];
    
    //NSLog(@"date : %@",date);
    
    //NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit)
													 fromDate:date];
    
    return offsetComponents;
}


#pragma mark - view life Cycle

-(void)viewWillAppear:(BOOL)animated
{
    NSString *strStatus=[[NSUserDefaults standardUserDefaults] valueForKey:@"Status"];
    
    //NSLog(@"strStatus : %@",strStatus);
    
    self.lblRedeemedDate.hidden=YES;
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([strStatus isEqualToString:@"New"])
    {
        [appDelegate logWithString:@"New Voucher"];
        
        [btnGetdrink setTitle:@"drinking_button" forState:UIControlStateDisabled];
        [btnGetdrink setImage:[UIImage imageNamed:@"ge_drinksontheHouse.png"] forState:UIControlStateNormal];
        self.lblInstruction.text=@"Simply press the button below to discover a great bar or restaurant nearby and receive an exclusive deal On the House!";
        self.lblInstruction.shadowColor=[UIColor whiteColor];
        self.lblInstruction.shadowOffset=CGSizeMake(0, 1.0);
        
    }
    else if ([strStatus isEqualToString:@"Current"])
    {
        [appDelegate logWithString:@"Current Voucher"];
        
        if (appDelegate.isCurrentVoucherActive == 1) {
            
            [btnGetdrink setTitle:@"currentvoucher_btn" forState:UIControlStateDisabled];
            [btnGetdrink setImage:[UIImage imageNamed:@"currentvoucher_btn.png"] forState:UIControlStateNormal];
            //  self.lblInstruction.text=@"Your current voucher expires at 4AM!press the button below to view the voucher.A new voucher will be available tomorrow";
            
            NSString *strToHours= [[NSUserDefaults standardUserDefaults] valueForKey:@"barEndtime"];
            NSDateComponents *ToComponent=[self componenetFromDate:strToHours];
            NSString *strMonth1=[NSString stringWithFormat:@"%i",ToComponent.month];
            NSString *strDay1=[NSString stringWithFormat:@"%i",ToComponent.day];
            NSString *strHour1=[NSString stringWithFormat:@"%i",ToComponent.hour];
            NSString *strMin1=[NSString stringWithFormat:@"%i",ToComponent.minute];
            
            //NSLog(@"strMonth1 : %@ strDay1 : %@ strHour1 : %@ strMin1 : %@",strMonth1,strDay1,strHour1,strMin1);
            
            NSString *ToTime;
            if ([strHour1 intValue] >= 0 && [strHour1 intValue] < 12) {
                
                if ([strHour1 intValue] == 0)
                {
                    ToTime=[NSString stringWithFormat:@"12:%.2i AM",ToComponent.minute];
                    
                }else
                {
                    ToTime=[NSString stringWithFormat:@"%i:%.2i AM",ToComponent.hour,ToComponent.minute];
                }

            }else{
                
                if (ToComponent.hour%12 == 0) {
                    
                    ToTime=[NSString stringWithFormat:@"12:%.2i PM",ToComponent.minute];
                    
                }else{
                    
                    ToTime=[NSString stringWithFormat:@"%i:%.2i PM",ToComponent.hour%12,ToComponent.minute];
                }
            }
            
            self.lblInstruction.text=[NSString stringWithFormat:@"Your current voucher expires at %@! Press the button below to view the voucher. A new voucher will be available tomorrow.",ToTime];
            self.lblInstruction.shadowColor=[UIColor whiteColor];
            self.lblInstruction.shadowOffset=CGSizeMake(0, 1.0);
            
        }else{
            
            [appDelegate logWithString:@"New Voucher >> previous unused voucher is expired"];
            
            [btnGetdrink setTitle:@"drinking_button" forState:UIControlStateDisabled];
            [btnGetdrink setImage:[UIImage imageNamed:@"ge_drinksontheHouse.png"] forState:UIControlStateNormal];
            self.lblInstruction.text=@"Simply press the button below to discover a great bar or restaurant nearby and receive an exclusive deal On the House!";
            self.lblInstruction.shadowColor=[UIColor whiteColor];
            self.lblInstruction.shadowOffset=CGSizeMake(0, 1.0);
        }
    }
    else if ([strStatus isEqualToString:@"Redeemed"])
    {
       [appDelegate logWithString:@"Redeemed Voucher"];
        
        self.lblRedeemedDate.hidden=NO;
        
        if (IS_IPHONE_5) {
        
            self.lblRedeemedDate.frame=CGRectMake(110, 495, 156,18);
        }else{
            
            self.lblRedeemedDate.frame=CGRectMake(110, 413, 156,18);
        }
        
        NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserRedeemedTime"];
        self.lblRedeemedDate.text=str;
                
        [btnGetdrink setTitle:@"voucherredeemed_button" forState:UIControlStateDisabled];
        [btnGetdrink setImage:[UIImage imageNamed:@"voucherredeemed_button_new.png"] forState:UIControlStateNormal];
        self.lblInstruction.text=@"You have already used today’s voucher. Come back tomorrow for a new voucher.";
        self.lblInstruction.shadowColor=[UIColor whiteColor];
        self.lblInstruction.shadowOffset=CGSizeMake(0, 1.0);
    }
    
       locationManager = [[CLLocationManager alloc] init];
       locationManager.delegate = self;
       locationManager.desiredAccuracy = kCLLocationAccuracyBest;
       locationManager.distanceFilter = kCLDistanceFilterNone;
       [locationManager startUpdatingLocation];
    
    [super viewWillAppear:animated];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
     //NSLog(@"Home user id==%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]);
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
   [appDelegate logWithString:@"HOME SCREEN"];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { 
        [imgBack setImage:[UIImage imageNamed:@"getdriking_screen_new_5.png"]];
        [lblInstruction setFrame:CGRectMake(lblInstruction.frame.origin.x, lblInstruction.frame.origin.y+10, lblInstruction.frame.size.width, lblInstruction.frame.size.height)];
        [btnGetdrink setFrame:CGRectMake(37, 458, 247, 58)];
        [btnTerms setImage:[UIImage imageNamed:@"termsuse_1-1.png"] forState:UIControlStateNormal];
    }
    else{
        [imgBack setImage:[UIImage imageNamed:@"getdriking_screen_new.png"]];
        [btnGetdrink setFrame:CGRectMake(37, 466, 247, 58)];
        [btnTerms setImage:[UIImage imageNamed:@"termsuse_1-1.png"] forState:UIControlStateNormal];
    }
       
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Button Action method

-(IBAction)termsOfUse:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.itisonthehouse.com/terms-of-service--privacy-policy.html"]];
    
}


-(IBAction)btnGetaFreedrink:(id)sender
{
    [locationManager startUpdatingLocation];

    NSString *strTitle=[btnGetdrink titleForState:UIControlStateDisabled];
    
    AppDelegate *appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if ([strTitle isEqualToString:@"voucherredeemed_button"])
    {
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if ( ![fileManager fileExistsAtPath:[self documentPath]] ) {
            
            //NSLog(@"plist not exist");
            
        } else
        {
            /* File exists at path. Resolve and save */
            
            [self.dictPlist removeAllObjects];
            
            ////NSLog(@"plist arr==%@",[NSMutableDictionary dictionaryWithContentsOfFile:[self documentPath]]);
            
            self.dictPlist= [NSMutableDictionary dictionaryWithContentsOfFile:[self documentPath]];
            
            ////NSLog(@"1. self.dictplist : %@",self.dictPlist);
        }
        
        
        appDel.dictBardetail=dictPlist;
        
        BarDetailViewController *obj_batDetailUpdate=[[BarDetailViewController alloc] initWithNibName:@"BarDetailViewController" bundle:nil];
        [self.navigationController pushViewController:obj_batDetailUpdate animated:YES];
        [obj_batDetailUpdate release];
        
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"You have already used today’s voucher. Come back tomorrow for a new voucher." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
//        [alert release];
        return;
    }
    
    // Configure the new event with information from the location
       
    responseData = [[NSMutableData alloc] init];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSDate *currentDateTime = [NSDate date];
    
    // Instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // Set the dateFormatter format
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    // Get the date time in NSString
    NSString *dateInString = [appDelegate dateFromLatLong]; // [dateFormatter stringFromDate:currentDateTime];
    
    // Release the dateFormatter
    [dateFormatter release];
 
     if ([strTitle isEqualToString:@"currentvoucher_btn"])
     {
         MethodUpdateCall=YES;
         
         NSFileManager *fileManager = [NSFileManager defaultManager];
         
         if ( ![fileManager fileExistsAtPath:[self documentPath]] ) {
             
             //NSLog(@"plist not exist");
             
             } else
             {
                /* File exists at path. Resolve and save */
                 
                  [self.dictPlist removeAllObjects];
                 
                  ////NSLog(@"plist arr==%@",[NSMutableDictionary dictionaryWithContentsOfFile:[self documentPath]]);
                 
                  self.dictPlist= [NSMutableDictionary dictionaryWithContentsOfFile:[self documentPath]];
                 
                  ////NSLog(@"1. self.dictplist : %@",self.dictPlist);
            }
         
        
        appDel.dictBardetail=dictPlist;
         
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         
         
        NSString *str=[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"];
         
        [dic setValue:str forKey:@"userId"];
        [dic setValue:[self.dictPlist objectForKey:@"bar_id"] forKey:@"bar_id"];
        [dic setValue:[self.dictPlist objectForKey:@"vochr_id"] forKey:@"vochr_id"];
        //  [dic setValue:@"2013/03/30 18:54:12" forKey:@"Date"];
        [dic setValue:dateInString forKey:@"Date"];
         
        if ([appDel isNetWorkAvailable])
        {
              [self execMethodUpdate:dic];
        }
        else
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"Please check your internet connection and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }

     }
    else if ([strTitle isEqualToString:@"drinking_button"])
    {
        
        AppDelegate *appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        if (!self.currentLatitude)
        {
            //NSLog(@"not found");
            return;
        }
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSString *str=[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"];
        
        [dic setValue:str forKey:@"userId"];
        [dic setValue:self.currentLatitude forKey:@"user_lat"];
        [dic setValue:self.currentLongitude forKey:@"user_long"];
        //  [dic setValue:@"2013/03/30 18:54:12" forKey:@"Date"];
        [dic setValue:dateInString forKey:@"Date"];
        
        
//        [dic setValue:@"34" forKey:@"userId"];
//        [dic setValue:@"47.616340" forKey:@"user_lat"];
//        [dic setValue:@"-122.349383" forKey:@"user_long"];
//        //  [dic setValue:@"2013/03/30 18:54:12" forKey:@"Date"];
//        [dic setValue:@"2013-08-13 10:02:24" forKey:@"Date"];
        
        if ([appDel isNetWorkAvailable])
        {
            [self execMethod:dic];
        }
        else
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"Please check your internet connection and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
}

#pragma mark -
#pragma mark Location Manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    self.currentLatitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    self.currentLongitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.currentLatitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setObject:self.currentLongitude forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //NSLog(@"User lat==%@",self.currentLatitude);
    //NSLog(@"User long==%@",self.currentLongitude);

    [locationManager stopUpdatingLocation];
  
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"On the House needs your location to find great bars and restaurants nearby. Please enable location services for On the House in your iPhone settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}
#pragma mark -
#pragma mark Process  data

-(void) execMethod:(NSMutableDictionary *)dic{
    
   [appDelegate logWithString:[NSString stringWithFormat:@"User Lat : %@ \n User Long : %@",self.currentLatitude,self.currentLongitude]];
    
    NSURL * url = [NSURL URLWithString:GETBARDETAIL];
    
    //Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    NSString *jsonString = [dic JSONRepresentation];
    
    [appDelegate logWithString:[NSString stringWithFormat:@"GETBARDETAIL (http://itisonth.w13.wh-2.com/WS/GetBarDetail) > request : %@",jsonString]];
    
    //NSLog(@"jsonString : %@",jsonString);
    
    NSData* requestData =[jsonString dataUsingEncoding:NSUTF8StringEncoding] ; // [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    //prepare http body
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d",[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:requestData];
    
    // NSURLConnection *urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    [NSURLConnection connectionWithRequest:request delegate:self];
    //  //NSLog(@"%@",urlConnection);
    [request release];
    
}
-(void) execMethodUpdate:(NSMutableDictionary *)dic{
    
    [appDelegate logWithString:[NSString stringWithFormat:@"User Lat : %@ \n User Long : %@",self.currentLatitude,self.currentLongitude]];
    
    NSURL * url = [NSURL URLWithString:UPDATE_DATESEEN_VOUCHER];
    
    //Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *jsonString = [dic JSONRepresentation];
    
    //NSLog(@"jsonString : %@",jsonString);
    [appDelegate logWithString:[NSString stringWithFormat:@"UPDATE_DATESEEN_VOUCHER (http://itisonth.w13.wh-2.com/WS/updateDateseen_voucher) > request : %@",jsonString]];
    
    NSData* requestData =[jsonString dataUsingEncoding:NSUTF8StringEncoding] ; // [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    //prepare http body
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d",[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:requestData];
    
    // NSURLConnection *urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    [NSURLConnection connectionWithRequest:request delegate:self];
    [request release];
    
}

#pragma mark - Connection method

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    //NSLog(@"error==%@",[error description]);
	//[connection release];
    
    [appDelegate logWithString:[NSString stringWithFormat:@"request didFailWithError : %@",[error description]]];
    
	responseData = nil;
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"The request timed out. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
    return;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //[connection release];
    AppDelegate *appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    appDel.isCurrentVoucherActive=1;
    
    if (MethodUpdateCall)
    {
        //NSLog(@"Update ssen voucher call");
        MethodUpdateCall=NO;
        
        [appDelegate logWithString:@"UPDATE_DATESEEN_VOUCHER > sucess"];
        
        BarDetailViewController *obj_batDetailUpdate=[[BarDetailViewController alloc] initWithNibName:@"BarDetailViewController" bundle:nil];
        [self.navigationController pushViewController:obj_batDetailUpdate animated:YES];
        [obj_batDetailUpdate release];
        //  NSString* userID = [[responseString JSONValue] objectForKey:@"UserId"];
        responseData = nil;
        return;
    }
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    [appDelegate logWithString:[NSString stringWithFormat:@"GETBARDETAIL response : %@",responseString]];
    NSMutableDictionary *tempDic =[responseString JSONValue];
    //NSLog(@"tempDic %@",tempDic);
    //[responseString release];
    
    if (tempDic) {
        
        NSString *strBarId=[NSString stringWithFormat:@"%@",[tempDic objectForKey:@"bar_id"]];
        if ([strBarId isEqualToString:@"0"])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"Unfortunately we do not have any bars in your area or none are currently offering deals at this time. Please try again at a later time or ask your favorite bar nearby to get On the House!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release];
            return;
        }
        
        appDel.dictBardetail=tempDic;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Current" forKey:@"Status"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //set value to plist
        [tempDic writeToFile:[self documentPath] atomically:YES];
        
        BarDetailViewController *obj_batDetail=[[BarDetailViewController alloc] initWithNibName:@"BarDetailViewController" bundle:nil];
        [self.navigationController pushViewController:obj_batDetail animated:YES];
        [obj_batDetail release];
        
        
        NSDate * now = [NSDate date];
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        //[outputFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *newDateString = [outputFormatter stringFromDate:now];
        //NSLog(@"curreny time==%@", newDateString);
        
        [[NSUserDefaults standardUserDefaults] setObject:newDateString forKey:@"redeemedTime"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"userGetredeemed"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        responseData = nil;
        
    }else{
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"Unfortunately we do not have any bars in your area or none are currently offering deals at this time. Please try again at a later time or ask your favorite bar nearby to get On the House!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    
}

-(NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *arrayPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"userBardetail.plist"];
    
    return arrayPath;
}

#pragma mark - Memory management

-(void)dealloc
{
    [responseData release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Mail Log File

-(void)email_Clicked:(id)sender
{
    NSLog(@"Email");
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"On The House application log file"];
        [mailViewController setMessageBody:@"" isHTML:NO];
        [mailViewController setToRecipients:[NSArray arrayWithObjects:@"",nil]];
        
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"log.txt"];
        NSData *textData = [NSData dataWithContentsOfFile:filePath];
        [mailViewController addAttachmentData:textData mimeType:@"text/plain" fileName:@"log.txt"];

        [self presentModalViewController:mailViewController animated:YES];
        [mailViewController release];
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"On The House" message:@"Device is unable to send email in its current state." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alert show];
        [alert release];
    }
}
#pragma mark - MFMailcontroller delegate

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
 
     [controller dismissModalViewControllerAnimated:YES];
}


@end
