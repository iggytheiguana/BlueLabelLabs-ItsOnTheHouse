//
//  LoginViewController.h
//  DrinkVoucher
//
//  Created by Jitendra on 3/14/13.
//  Copyright (c) 2013 Jitendra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

#import <Accounts/ACAccountStore.h>
#import <Accounts/ACAccount.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController<FBRequestDelegate,FBDialogDelegate,FBSessionDelegate,UIAlertViewDelegate>
{
    IBOutlet UIButton *btnAge;
    IBOutlet UIButton *btnFacebook;
    
    Facebook* facebook;
	NSArray* permissions;
    
    NSMutableData* responseData;
    
    IBOutlet UIImageView *imgBack;
    IBOutlet UILabel *lblAgeverify;
    IBOutlet UIButton *btnTerms;
    
    NSDictionary *list;
    
    AppDelegate *appDelegate;
    
}
@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccount *facebookAccount;
@property (nonatomic,retain) IBOutlet UIImageView *imgBack;
@property(nonatomic,retain) Facebook* facebook;
@property(nonatomic,retain) UIButton *btnFacebook;
@property(nonatomic,retain) UIButton *btnAge;
//@property (retain, nonatomic) NSMutableData* responseData;

-(IBAction)btnAgeVerification:(id)sender;
-(IBAction)btnFacebook:(id)sender;
-(IBAction)termsOfUse:(id)sender;


@end
