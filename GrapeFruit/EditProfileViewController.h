//
//  EditProfileViewController.h
//  GrapeFruit
//
//  Created by Aileen Taboy on 1/10/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController


//Edit photo

- (IBAction)editPhotoButton:(id)sender;


//Save to parse
- (IBAction)saveButton:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;



@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;


@property (weak, nonatomic) IBOutlet UITextField *firstNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *lastNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *DobLabel;


@property (weak, nonatomic) IBOutlet UITextView *aboutMeLabel;


@property (weak, nonatomic) IBOutlet UIImageView *profilePhoto;

@end
