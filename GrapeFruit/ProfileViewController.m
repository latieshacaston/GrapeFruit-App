//
//  ProfileViewController.m
//  GrapeFruit
//
//  Created by Aileen Taboy on 1/9/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()




@property (nonatomic, strong) PFObject *userData;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  
    
    
}



-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //Check for logged in user
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        [self loadUserData];
        NSLog(@"The Current User is %@",currentUser.username);
        
    }else {
        
        
        
        
        [self performSegueWithIdentifier:@"signUp" sender:self];
        
        
        
    }
    
    
}


#pragma mark - load user data

-(void)loadUserData {
    
    
    //Create PFObject for current user
    self.userData = [PFUser currentUser];
    
    
    
    //organize data into strings
    NSString *firstNameString = [self.userData objectForKey:@"FirstName"];
    NSString *lastNameString = [self.userData objectForKey:@"LastName"];
    self.userName.text = [self.userData objectForKey:@"username"];
    self.aboutMe.text = [self.userData objectForKey:@"AboutMe"];
    
    //set the labels
    self.fullName.text = [NSString stringWithFormat:@"%@ %@", firstNameString, lastNameString];


    
    
    //set profile image
    
    PFFile *imageFile = [self.userData objectForKey:@"ProfilePhoto"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            self.profileImage.image = [UIImage imageWithData:data];
        }
    }];
    
    
    
    
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


- (IBAction)deleteButton:(id)sender {
    
    [[PFUser currentUser] deleteInBackground];
    

    
}

- (IBAction)logOutButton:(id)sender {
    
    [PFUser logOutInBackground];
    
    [self performSegueWithIdentifier:@"signUp" sender:self];
    
    
}
@end
