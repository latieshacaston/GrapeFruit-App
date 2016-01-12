//
//  logInViewController.m
//  GrapeFruit
//
//  Created by Aileen Taboy on 1/8/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import "logInViewController.h"
#import <Parse/Parse.h>
#import "ProfileViewController.h"

@interface logInViewController ()

@end

@implementation logInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButton:(id)sender {
    
    
    NSString *email = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *passWord  = [self.passWordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([email length] ==0 || [passWord length] == 0) {
       
        
        [self alertMessage:@"Oh NO!" message:@"Make sure you enter a username and password!"];
        
    } else {
        
        
        [PFUser logInWithUsernameInBackground:email password:passWord block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            
            if (error) {
               
                
                [self alertMessage:@"Oh Boy!" message:[error.userInfo objectForKey:@"error"]];
                
            } else {
                
                
                
                // instantiate view controller
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle:nil];
               
                
                ProfileViewController *add = [storyboard instantiateInitialViewController];
                
                [self presentViewController:add
                                   animated:YES 
                                 completion:nil];
                
                
                
            }
            
        }];
        
        
    }
    

}

#pragma mark - delete account

- (IBAction)deleteAccount:(id)sender {
    
    [[PFUser currentUser] deleteInBackground];  
}


#pragma mark - alert message

-(void)alertMessage: (NSString *)title message:(NSString *)message   {
    
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alertView addAction:defaultAction];
    [self presentViewController:alertView animated:YES completion:nil];
    
    
}
@end
