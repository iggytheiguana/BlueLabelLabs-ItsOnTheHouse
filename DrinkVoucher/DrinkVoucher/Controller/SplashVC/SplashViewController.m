//
//  SplashViewController.m
//  DrinkVoucher
//
//  Created by Jitendra on 3/14/13.
//  Copyright (c) 2013 Jitendra. All rights reserved.
//

#import "SplashViewController.h"
#import "LoginViewController.h"
@interface SplashViewController ()

@end

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -View Life cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [imgBack setImage:[UIImage imageNamed:@"Default-568h@2x.png"]];
    }
    else{
        [imgBack setImage:[UIImage imageNamed:@"Default.png"]];
    }

    timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(jumpToNextView) userInfo:nil repeats:NO];
 }

-(void)jumpToNextView
{
    [timer invalidate];
	timer = nil;
    LoginViewController *obj_Login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [self.navigationController pushViewController:obj_Login animated:YES];
    [UIView commitAnimations];
}                                                                                                                                


#pragma mark - Memory management method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
