//
//  BarDetailViewController.m
//  DrinkVoucher
//
//  Created by Jitendra on 3/19/13.
//  Copyright (c) 2013 Jitendra. All rights reserved.
//

#import "BarDetailViewController.h"
#import "MapViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "JSON.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"
#import "SDWebImageManagerDelegate.h"
@implementation AddressAnnotation

@synthesize coordinate;

- (NSString *)subtitle
{
	return @"Sub Title";
}

- (NSString *)title
{
	return @"Title";
}


- (id)initWithCoordinate:(CLLocationCoordinate2D) c
{
	coordinate = c;
	//NSLog(@"%f %f",c.latitude, c.longitude);
	return self;
}

@end


@interface BarDetailViewController ()

@end

@implementation BarDetailViewController

@synthesize locationManager,imgBar;
@synthesize currentLatitude,currentLongitude,BarLatitude,BarLongitude;
@synthesize lblRedeemedDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - Adjust Font SizeToFit
- (void)adjustFontSizeToFit:(UILabel *)lable
{
    UIFont *font = lable.font;
    CGSize size = lable.frame.size;
    
    for (CGFloat maxSize = lable.font.pointSize; maxSize >= lable.minimumFontSize; maxSize -= 1.f)
    {
        font = [font fontWithSize:maxSize];
        CGSize constraintSize = CGSizeMake(size.width, MAXFLOAT);
        CGSize labelSize = [lable.text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        if(labelSize.height <= size.height)
        {
            lable.font = font;
            [lable setNeedsLayout];
            break;
        }
    }
    // set the font to the minimum size anyway
    lable.font = font;
    [lable setNeedsLayout];
}


-(NSDateComponents *)componenetFromDate:(NSString *)strDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSDate *date=[formatter dateFromString:strDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit)
													 fromDate:date];
    
    return offsetComponents;
}

#pragma mark - view life cycle method

-(void)viewWillAppear:(BOOL)animated
{
    
    lblTimer.hidden=YES;
    imgChkbox.hidden=YES;
    
   
    
     NSString *strStatus=[[NSUserDefaults standardUserDefaults] valueForKey:@"Status"];
    
    if ([strStatus isEqualToString:@"New"])
    {
         self.lblRedeemedDate.hidden=YES;
        [btnDealAction setTitle:@"redeemyourvocher_button" forState:UIControlStateDisabled];
        [btnDealAction setImage:[UIImage imageNamed:@"redeemyourvocher_button.png"] forState:UIControlStateNormal];
    }
    else if ([strStatus isEqualToString:@"Current"])
    {
         self.lblRedeemedDate.hidden=YES;
        [btnDealAction setTitle:@"redeemyourvocher_button" forState:UIControlStateDisabled];
        [btnDealAction setImage:[UIImage imageNamed:@"redeemyourvocher_button.png"] forState:UIControlStateNormal];
    }
    else if ([strStatus isEqualToString:@"Redeemed"])
    {
        [btnDealAction setTitle:@"voucherredeemed_button" forState:UIControlStateDisabled];
        [btnDealAction setImage:[UIImage imageNamed:@"voucherredeemed_button_new.png"] forState:UIControlStateNormal];
        
        self.lblRedeemedDate.hidden=NO;
        
        if (IS_IPHONE_5) {
            
            self.lblRedeemedDate.frame=CGRectMake(113, 295, 156,18);
        }else{
            
            self.lblRedeemedDate.frame=CGRectMake(113, 240, 156,18);
        }
        
        self.lblRedeemedDate.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserRedeemedTime"];;
        
    }
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];

    
    NSURL *imageURL=[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@",[appDel.dictBardetail objectForKey:@"bar_image_url"]]];
    [self.imgBar setImageWithURL:imageURL  placeholderImage:nil options:SDWebImageProgressiveDownload];
    
    lblbarName.text=[NSString stringWithFormat:@"%@",[appDel.dictBardetail objectForKey:@"bar_name"]];
    lblbarAddress.text=[[appDel.dictBardetail objectForKey:@"bar_address"] objectForKey:@"street"];
   
    lblCityState.text=[NSString stringWithFormat:@"%@, %@ %@",[[appDel.dictBardetail objectForKey:@"bar_address"] objectForKey:@"city"],[[appDel.dictBardetail objectForKey:@"bar_address"] objectForKey:@"state"],[[appDel.dictBardetail objectForKey:@"bar_address"] objectForKey:@"zip_code"]];
  
    
    if (IS_IPHONE_5) {
    
        lblvoucherMsg.frame=CGRectMake(10, 135, 300, 114);
    }else{
        
        lblvoucherMsg.frame=CGRectMake(10, 133, 300, 70);
    }
    
    
    lblvoucherMsg.text=[appDel.dictBardetail objectForKey:@"vochr_msg"];
    lblvoucherMsg.shadowColor=[UIColor whiteColor];     
    lblvoucherMsg.shadowOffset=CGSizeMake(0, 1.0);
    lblvoucherMsg.minimumFontSize=10;
    lblvoucherMsg.font = [UIFont italicSystemFontOfSize:17.0f];
    [self adjustFontSizeToFit:lblvoucherMsg];
    
    NSString *strFromHours= [appDel.dictBardetail objectForKey:@"bar_FromHours"];
    NSDateComponents *FromComponent=[self componenetFromDate:strFromHours];
    NSString *strHour=[NSString stringWithFormat:@"%i",FromComponent.hour];
    
    
    NSString *strToHours= [appDel.dictBardetail objectForKey:@"bar_ToHours"];
    NSDateComponents *ToComponent=[self componenetFromDate:strToHours];
    NSString *strHour1=[NSString stringWithFormat:@"%i",ToComponent.hour];
    
    NSString *fromTime,*ToTime;
    
    if ([strHour intValue] >= 0 && [strHour intValue] < 12) {
        
        if ([strHour intValue] == 0) {
        
            fromTime=[NSString stringWithFormat:@"12:%.2i AM",FromComponent.minute];
            
        }else{
            
            fromTime=[NSString stringWithFormat:@"%i:%.2i AM",FromComponent.hour,FromComponent.minute];
        }
        
    }else{
        
        if (FromComponent.hour%12 == 0)
        {
            fromTime=[NSString stringWithFormat:@"12:%.2i PM",FromComponent.minute];
            
        }else{
            
            fromTime=[NSString stringWithFormat:@"%i:%.2i PM",FromComponent.hour%12,FromComponent.minute];
        }
    }
    
    if ([strHour1 intValue] >= 0 && [strHour1 intValue] < 12) {
        
        if ([strHour1 intValue] == 0)
        {
            ToTime=[NSString stringWithFormat:@"12:%.2i AM",ToComponent.minute];
            
        }else{
            
            ToTime=[NSString stringWithFormat:@"%i:%.2i AM",ToComponent.hour,ToComponent.minute];
        }
        
    }else{
        
        if (ToComponent.hour%12 == 0)
        {
            ToTime=[NSString stringWithFormat:@"12:%.2i PM",ToComponent.minute];
            
        }else
        {
            ToTime=[NSString stringWithFormat:@"%i:%.2i PM",ToComponent.hour%12,ToComponent.minute];
        }
    }
    
    
//    NSString *strFrom=[NSString stringWithFormat:@"Valid today %.2i/%.2i %@ to %@",FromComponent.month,FromComponent.day,fromTime,ToTime];
    lblOpendaily.text=[NSString stringWithFormat:@"Valid today %i/%i %@ to %@",FromComponent.month,FromComponent.day,fromTime,ToTime];
    
    if (![[appDel.dictBardetail objectForKey:@"bar_Desc"] isEqualToString:@""]) {
        
        
        imgBottomBar.hidden=YES;
        
        CGSize labelsize;
        UITextView *commentsTextLabel = [[UITextView alloc] init];;
        commentsTextLabel.tag =50;
        [commentsTextLabel setBackgroundColor:[UIColor clearColor]];
        
        NSString *text = [appDel.dictBardetail objectForKey:@"bar_Desc"];
        [commentsTextLabel setFont:[UIFont fontWithName:@"Helvetica"size:14]];
        labelsize=[text sizeWithFont:commentsTextLabel.font constrainedToSize:CGSizeMake(270,900) lineBreakMode:UILineBreakModeCharacterWrap];
        
        
        CGFloat height=labelsize.height;
        //NSLog(@"height : %f",height);
        
        scrlView.contentSize=CGSizeMake(320,barView.frame.size.height+height + 20);
        lblDetail.text=text;
        lblDetail.numberOfLines=height/14;
        
        detailView.frame=CGRectMake(0, barView.frame.size.height, 320, 20 + height );
        
        lblDetail.frame=CGRectMake(10, barView.frame.size.height, 300, 20 + height );
    }
   else
   {
       lblDetail.text=@"";
       lblDetail.hidden=YES;
       detailView.hidden=YES;
       imgBottomBar.hidden=NO;
       scrlView.scrollEnabled=NO;
       imgBottomBar.frame=CGRectMake(0, barView.frame.size.height, imgBottomBar.frame.size.width, 25);
       
       scrlView.contentSize=CGSizeMake(320,barView.frame.size.height + 20);
       
   }
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude= [[appDel.dictBardetail objectForKey:@"bar_lat"] floatValue];
    coordinate.longitude=[[appDel.dictBardetail objectForKey:@"bar_long"] floatValue];
    
    self.BarLatitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    self.BarLongitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    //NSLog(@"bar==%@",self.BarLatitude);
    //NSLog(@"bar==%@",self.BarLongitude);
    
    
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
    
    mapView.userInteractionEnabled=NO;
	if(addAnnotation != nil)
	{
		[mapView removeAnnotation:addAnnotation];
        addAnnotation = nil;
	}
	addAnnotation = [[AddressAnnotation alloc]initWithCoordinate:coordinate];
	[mapView addAnnotation:addAnnotation];
	//[mapView setRegion:region animated:TRUE];
	//[mapView regionThatFits:region];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[appDel.dictBardetail objectForKey:@"bar_ToHours"] forKey:@"barEndtime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
	
    [super viewWillAppear:animated];

}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
        
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [imgBack setImage:[UIImage imageNamed:@"background_5@2x"]];
        [imgBottomBar setFrame:CGRectMake(0, 522, 320, 45)];
        [lblvoucherMsg setFrame:CGRectMake(10,135 ,300 ,115 )];
        
    }
    else{
        [imgBottomBar setFrame:CGRectMake(0, 525, 320, 45)];
        [imgBack setImage:[UIImage imageNamed:@"background_4"]];
        [lblvoucherMsg setFrame:CGRectMake(10,130 ,300 ,100 )];
      
    }
    
    appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    ////NSLog(@"Bar detail==%@",appDel.dictBardetail);
    
   // [appDel logWithString:@"BAR DETAIL SCREEN"];
    
    // Configure the new event with information from the location
   
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
#pragma mark Action  method

-(IBAction)btnBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)btnMapAction:(id)sender
{
    appDel.strBar=[appDel.dictBardetail objectForKey:@"bar_name"];;
    
    MapViewController *obj_mapView=[[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    obj_mapView.strMaplatitude=self.BarLatitude;
    obj_mapView.strMapLongitude=self.BarLongitude;
    obj_mapView.strCurrentlatitude=self.currentLatitude;
    obj_mapView.strCurrentLongitude=self.currentLongitude;
    obj_mapView.strBarName=[appDel.dictBardetail objectForKey:@"bar_name"];
    [self presentViewController:obj_mapView animated:YES completion:nil];

}
-(IBAction)btnDealAction:(id)sender
{
    [locationManager startUpdatingLocation];
    
    NSString *strTitle=[btnDealAction titleForState:UIControlStateDisabled];
    
    if ([strTitle isEqualToString:@"voucherredeemed_button"])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"You have already used today’s voucher. Come back tomorrow for a new voucher." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[self.currentLatitude doubleValue] longitude:[self.currentLongitude doubleValue]];
    
    CLLocation *barLocation = [[CLLocation alloc] initWithLatitude:[self.BarLatitude doubleValue] longitude:[self.BarLongitude doubleValue]];
    // calculate distance between them
    CLLocationDistance distance = [currentLocation distanceFromLocation:barLocation];
    //NSLog(@"Distance==%f",distance);
    
    if (distance<0)
    {
        distance=-1*distance;
    }
    
    if (distance <= [[appDel.dictBardetail objectForKey:@"vochr_redemption_radius"] floatValue])
    //  if (distance <= 100)
    {
                
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"Ready to use your voucher? Press redeem only when your bartender or server is watching. They will not be able to validate it otherwise." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Redeem",nil];
        alert.tag=10;
        alert.delegate=self;
        [alert show];
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"You don’t appear to be at the bar or restaurant. Please try again once you have arrived." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

}
-(IBAction)btnWebsiteAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[appDel.dictBardetail objectForKey:@"bar_website_url"]]];
}
-(IBAction)btnPhoneAction:(id)sender
{
    NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel://%@",[appDel.dictBardetail objectForKey:@"bar_phone"]];
   
    
    phoneStr=[phoneStr stringByReplacingOccurrencesOfString:@"+" withString:@""];
    phoneStr=[phoneStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneStr=[phoneStr stringByReplacingOccurrencesOfString:@")" withString:@""];
    phoneStr=[phoneStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneStr=[phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    webview.delegate=self;
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneStr]]];

}
#pragma mark -
#pragma mark Location Manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    self.currentLatitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    self.currentLongitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    
    //NSLog(@"User lat==%@",self.currentLatitude);
    //NSLog(@"User long==%@",self.currentLongitude);
    
    [locationManager stopUpdatingLocation];
    
}
#pragma mark -
#pragma mark Process  data

-(void) execMethod:(NSMutableDictionary *)dic{
    
    NSURL * url = [NSURL URLWithString:REDEEM_VOUCHER];
    
    //Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *jsonString = [dic JSONRepresentation];
    
    //NSLog(@"jsonString : %@",jsonString);
    
   // [appDel logWithString:[NSString stringWithFormat:@"REDEEM_VOUCHER (http://itisonth.w13.wh-2.com/WS/redeem_voucher) > request : %@",jsonString]];
    
    NSData* requestData =[jsonString dataUsingEncoding:NSUTF8StringEncoding] ; // [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    //prepare http body
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d",[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:requestData];
    
    NSURLConnection *urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
   // //NSLog(@"%@",urlConnection);
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //NSLog(@"error==%@",[error description]);
	responseData = nil;
    
    //[appDel logWithString:[NSString stringWithFormat:@"REDEEM_VOUCHER > request didFailWithError : %@",[error description]]];
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"The request timed out. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
       
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *tempDic =[responseString JSONValue];
    //NSLog(@"tempdict==%@",tempDic);
    
    if (tempDic) {
        
       // [appDel logWithString:[NSString stringWithFormat:@"REDEEM_VOUCHER > response : %@",responseString]];
        
        if ([[tempDic objectForKey:@"status"] isEqualToString:@"Success"])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"Successfully redeemed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            NSDate * now = [NSDate date];
            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
            [outputFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
            NSString *newDateString = [outputFormatter stringFromDate:now];
            //NSLog(@"curreny time==%@", newDateString);
            
            
            self.lblRedeemedDate.hidden=NO;
            
            if (IS_IPHONE_5) {
                
                self.lblRedeemedDate.frame=CGRectMake(113, 295, 156,18);
            }else{
                
                self.lblRedeemedDate.frame=CGRectMake(113, 240, 156,18);
            }
            
            self.lblRedeemedDate.text=newDateString;
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Redeemed" forKey:@"Status"];
            [[NSUserDefaults standardUserDefaults] setObject:newDateString forKey:@"UserRedeemedTime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //   [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"userGetredeemed"];
        }
    }

	responseData = nil;
}

-(void)timePlus{
    
    ////NSLog(@"timePlus");
    time--;
    lblTimer.text=[NSString stringWithFormat:@"%d",time];
    if (time==0)
    {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        responseData = [[NSMutableData alloc] init];
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        
        NSDate *currentDateTime = [NSDate date];
        
        // Instantiate a NSDateFormatter
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        // Set the dateFormatter format
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        
        // Get the date time in NSString
        NSString *dateInString = [appDel dateFromLatLong]; //[dateFormatter stringFromDate:currentDateTime];
        
        
        [dic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"] forKey:@"userId"];
        [dic setValue:[appDel.dictBardetail objectForKey:@"bar_id"] forKey:@"bar_id"];
        [dic setValue:[appDel.dictBardetail objectForKey:@"vochr_id"] forKey:@"vochr_id"];
        [dic setValue:dateInString forKey:@"Date"];
        
        if ([appDel isNetWorkAvailable])
        {
            [self execMethod:dic];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"On the House" message:@"Please check your internet connection and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            //  [alert release];
        }
        
        btnDealAction.userInteractionEnabled=YES;
        btnBack.userInteractionEnabled=YES;
        btnCall.userInteractionEnabled=YES;
        btnWebSite.userInteractionEnabled=YES;
        btnMap.userInteractionEnabled=YES;
        scrlView.userInteractionEnabled=YES;
        lblTimer.hidden=YES;
        imgChkbox.hidden=NO;
        [timer invalidate];
        timer=nil;
    }
}
#pragma mark -
#pragma mark alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10 && buttonIndex==1)
    {
        
        [btnDealAction setImage:[UIImage imageNamed:@"voucherredeemed_button_blank_new.png"] forState:UIControlStateNormal];
        [btnDealAction setTitle:@"voucherredeemed_button" forState:UIControlStateDisabled];
        
        lblTimer.hidden=NO;
        time=20;
        btnDealAction.userInteractionEnabled=NO;
        btnBack.userInteractionEnabled=NO;
        btnCall.userInteractionEnabled=NO;
        btnWebSite.userInteractionEnabled=NO;
        btnMap.userInteractionEnabled=NO;
        scrlView.userInteractionEnabled=NO;
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timePlus) userInfo:nil repeats:YES];
       
    }
}
#pragma mark -
#pragma mark Memory Management
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
