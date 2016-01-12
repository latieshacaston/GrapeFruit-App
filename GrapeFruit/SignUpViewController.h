//
//  SignUpViewController.h
//  GrapeFruit
//
//  Created by Aileen Taboy on 1/7/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;


@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

@property (weak, nonatomic) IBOutlet UITextField *passWordConfirmTextField;


@property (weak, nonatomic) IBOutlet UITextField *birthDateTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;


@end
