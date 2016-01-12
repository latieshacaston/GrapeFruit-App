//
//  ProfileViewController.h
//  GrapeFruit
//
//  Created by Aileen Taboy on 1/9/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController


- (IBAction)deleteButton:(id)sender;



- (IBAction)logOutButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;


@property (weak, nonatomic) IBOutlet UILabel *fullName;


@property (weak, nonatomic) IBOutlet UILabel *userName;


@property (weak, nonatomic) IBOutlet UITextView *aboutMe;


@end
