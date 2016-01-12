//
//  ViewController.m
//  GrapeFruit
//
//

#import "ViewController.h"
#import <Parse/Parse.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"current user is %@", [PFUser currentUser]);
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//     NSDictionary *params = [NSDictionary dictionaryWithObject:@"+13477460523" forKey:@"phoneNumber"];
//    
//    [PFCloud callFunctionInBackground:@"sendVerification" withParameters:params block:^(id  _Nullable object, NSError * _Nullable error) {
//        NSString *message = @"";
//        if (!error) {
//            message = @"Your SMS invitation has been sent!";
//        } else {
//            message = @"Uh oh, something went wrong :(";
//        }
//        
//        [[[UIAlertView alloc] initWithTitle:@"Invite Sent!"
//                                    message:message
//                                   delegate:nil
//                          cancelButtonTitle:@"Ok"
//                          otherButtonTitles:nil, nil] show];
//        
//    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
