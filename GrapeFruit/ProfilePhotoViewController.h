//
//  ProfilePhotoViewController.h
//  GrapeFruit
//
//  Created by Aileen Taboy on 1/10/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilePhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>;


@property (nonatomic, strong)UIImage *pictureForProfile;

- (IBAction)chooseFromLibrary:(id)sender;

- (IBAction)takePhoto:(id)sender;
@end
