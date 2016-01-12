//
//  VerifyViewController.m
//  GrapeFruit
//
//  Created by Michael Metzger  on 1/9/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import "VerifyViewController.h"
#import <Parse/Parse.h>
#import "ProfileViewController.h"


@interface VerifyViewController ()

@end

@implementation VerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)verifyButton:(id)sender {
    
    
    NSString *verifyInput = [self.verificationTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    NSDictionary *params = [NSDictionary dictionaryWithObject:verifyInput forKey:@"phoneVerificationCode"];
    //call parse cloud for function
    [PFCloud callFunctionInBackground:@"verifyPhoneNumber" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
        NSString *message = @"";
        if (!error) {
    
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle:nil];
            ProfileViewController *add = [storyboard instantiateInitialViewController];
            
            [self presentViewController:add
                               animated:YES
                             completion:nil];
            
        } else {
            message = @"Uh oh, something went wrong :(.  Please double check your verification text.";
            [self alertMessage:@"Error !" message:message];
        }
        
        
        
    }];
 
    
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
