//
//  ProfilePhotoViewController.m
//  GrapeFruit
//
//  Created by Aileen Taboy on 1/10/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import "ProfilePhotoViewController.h"
#import "EditProfileViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>


@interface ProfilePhotoViewController ()


@end

@implementation ProfilePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    self.view.frame=CGRectMake(0, 0,375, 300);

    
    
    
    
    
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

#pragma mark - photo functions

- (IBAction)chooseFromLibrary:(id)sender {
    
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]==NO) {
        
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //Displays saved pictures from the Camera Roll album
    picker.mediaTypes = @[(NSString*)kUTTypeImage];
    
    //Hides the controls for moving & scaling pictures
    picker.allowsEditing = NO;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)takePhoto:(id)sender {
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //Change to allow no picture loaded
    
    EditProfileViewController *viewController = [[EditProfileViewController alloc]init];
    
    self.pictureForProfile = originalImage;
    
    viewController.profilePhoto.image = originalImage;
    [viewController viewDidAppear:YES];
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self performSegueWithIdentifier:@"photo" sender:self];
    
    
}











@end
