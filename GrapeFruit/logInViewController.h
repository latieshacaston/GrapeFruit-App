//
//  logInViewController.h
//  GrapeFruit
//
//  Created by Aileen Taboy on 1/8/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface logInViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;



- (IBAction)loginButton:(id)sender;


- (IBAction)deleteAccount:(id)sender;


@end
