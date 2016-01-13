//
//  FriendsViewController.m
//  GrapeFruit
//
//  Created by Aileen Taboy on 1/13/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import "FriendsViewController.h"
#import <Parse/Parse.h>

@import Contacts;
@interface FriendsViewController ()

//Array for user contact phone numbers
@property (nonatomic, strong)NSMutableArray *phoneContacts;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



-(void)viewDidAppear:(BOOL)animated {
    
//    for (NSString *d in self.phoneContacts) {
//        NSLog(@" phone number %@", d);
//    }
    // query for parse phoneNumbers
    
    
    //Initiate request for phoneBook access
    [self contactScan];
    
}


 // ask for permission
- (void) contactScan
{
    if ([CNContactStore class]) {
        //ios9 or later
        CNEntityType entityType = CNEntityTypeContacts;
        if( [CNContactStore authorizationStatusForEntityType:entityType] == CNAuthorizationStatusNotDetermined)
        {
            CNContactStore * contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:entityType completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if(granted){
                    [self getAllContact];
                }
            }];
        }
        else if( [CNContactStore authorizationStatusForEntityType:entityType]== CNAuthorizationStatusAuthorized)
        {
            [self getAllContact];
        }
    }
}


//request contacts with proper keys
-(void)getAllContact
{
    if([CNContactStore class])
    {
        //iOS 9 or later
        NSError* contactError;
        CNContactStore* addressBook = [[CNContactStore alloc]init];
        [addressBook containersMatchingPredicate:[CNContainer predicateForContainersWithIdentifiers: @[addressBook.defaultContainerIdentifier]] error:&contactError];
        
//        NSArray * keysToFetch =@[CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPostalAddressesKey];
        
        //we only want phone numbers for now
        NSArray * keysToFetch =@[CNContactPhoneNumbersKey];
   
        CNContactFetchRequest * request = [[CNContactFetchRequest alloc]initWithKeysToFetch:keysToFetch];
        [addressBook enumerateContactsWithFetchRequest:request error:&contactError usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop){
            
            
                NSString * phone = [[contact.phoneNumbers valueForKey:@"value"] valueForKey:@"digits"];
            
            [self.phoneContacts addObject:phone];
            NSLog(@" adding phone %@", phone);
            
            
           
        }];
        
        
    }
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

@end
