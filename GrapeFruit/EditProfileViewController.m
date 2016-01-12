//
//  EditProfileViewController.m
//  GrapeFruit
//
//  Created by Aileen Taboy on 1/10/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import "EditProfileViewController.h"
#import "ProfilePhotoViewController.h"
#import <Parse/Parse.h>


@interface EditProfileViewController ()<UIPopoverPresentationControllerDelegate>{
    //String for preventing upload of default about me text
    
    NSString *profileHolder;
    
    
}



@property (nonatomic, weak)NSString *fullName;
@property (nonatomic, weak)NSString *firstName;
@property (nonatomic, weak)NSString *LastName;
@property (nonatomic, weak)NSString *userName;
@property (nonatomic, weak)NSString *birthDate;
@property (nonatomic, weak)NSString *aboutMe;

@property (nonatomic, strong) PFObject *userData;

@property(nonatomic,strong)ProfilePhotoViewController *popOVer;


@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadUserData];

    
    
    
}


-(void)viewDidAppear:(BOOL)animated {
    
    
    
    
}


#pragma Mark - present photo popover

- (IBAction)photoButton:(id)sender {
    

    [self performSegueWithIdentifier:@"popOver" sender:self];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"popOver"]) {
        ProfilePhotoViewController *vc = segue.destinationViewController;
        vc.popoverPresentationController.sourceView = sender;
        
        //set the size
        
        vc.preferredContentSize = CGSizeMake(200, 121);
        
        vc.popoverPresentationController.delegate = self;
        
        
    }
    
}


-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}


#pragma mark - load user data 

-(void)loadUserData {
    
    
    //Create PFObject for current user
    self.userData = [PFUser currentUser];
    
    //organize data into strings
    self.firstName = [self.userData objectForKey:@"FirstName"];
    self.LastName = [self.userData objectForKey:@"LastName"];
    self.userName = [self.userData objectForKey:@"username"];
    self.birthDate = [self.userData objectForKey:@"Birthday"];
    self.aboutMe = [self.userData objectForKey:@"AboutMe"];
    
    //place holder text for aboutMe being null
    
    if (self.aboutMe.length == 0) {
        
        profileHolder = @"Tap here to write  summery about yourself";
        self.aboutMe = profileHolder;
    }
    
    
    //set the labels
    self.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.firstName, self.LastName];
    self.firstNameLabel.text = self.firstName;
    self.lastNameLabel.text = self.LastName;
    self.DobLabel.text = self.birthDate;
    self.userNameLabel.text = self.userName;
    
    
    //set the profile photo
    
    
    PFFile *imageFile = [self.userData objectForKey:@"ProfilePhoto"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
             self.profilePhoto.image = [UIImage imageWithData:data];
        }
    }];
    
   
    
    
    //set about me label
    
    self.aboutMeLabel.text = self.aboutMe;
    
    
    
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


- (IBAction)saveButton:(id)sender {
    
    
    
    
    //Set object for key
    
    [self.userData setObject:self.firstNameLabel.text forKey:@"FirstName"];
    
    [self.userData setObject:self.lastNameLabel.text forKey:@"LastName"];
    
    [self.userData setObject:self.DobLabel.text forKey:@"Birthday"];
    [self.userData setObject:self.userNameLabel.text forKey:@"username"];
    
    
    //prevent place holder text from being saved
    
    if (profileHolder.length > 0) {
        // do nothing
        
        [self.userData setObject:@" " forKey:@"AboutMe"];
    }else {
        [self.userData setObject:self.aboutMeLabel.text forKey:@"AboutMe"];
    }
    
   
    
    
    //set profile photo for upload
    
    //Pack item Image
    NSData *imageData = UIImageJPEGRepresentation(self.profilePhoto.image, 0.8);
    NSString *filename = [NSString stringWithFormat:@"%@.png", self.userNameLabel.text];
    PFFile *imageFile = [PFFile fileWithName:filename data:imageData];
    [self.userData setObject:imageFile forKey:@"ProfilePhoto"];
    
    
    
    [self.userData saveInBackground];
    
    
    [self.navigationController popViewControllerAnimated:YES];  
    
    
    
}


#pragma mark - retrive photo from Popover Segue 


- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue{
    
    if ([segue.sourceViewController isKindOfClass:[ProfilePhotoViewController class]]) {
        ProfilePhotoViewController *createAptView = segue.sourceViewController;
        if (self.profilePhoto) {
            
            self.profilePhoto.image = createAptView.pictureForProfile;
            
        }
        
        
    }
    
}
@end
