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
@interface FriendsViewController () {
    
    //Array to store the parse querryin
    NSArray *arrayFromParseQuery;
    
}
  


@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}







-(void)viewDidAppear:(BOOL)animated {
    

    
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
        
        // array for phone storage
        NSMutableArray *forNumber = [[NSMutableArray alloc]init];
        
        //creat a boolean value to let us know when operation is complete
       BOOL phoneRequestComplete = [addressBook enumerateContactsWithFetchRequest:request error:&contactError usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop){
           
           
                NSString * phone = [[contact.phoneNumbers valueForKey:@"value"] valueForKey:@"digits"];
           
                [forNumber addObject:phone];

           
        }];
        
        //loop through complete array (parse query will go here)
        if (phoneRequestComplete) {
            
            //run parse query
            [self parseQuery];
            
            
            
        }
        
    }
}


#pragma mark - parse query  
-(void)parseQuery {
    
   
    
    //assign class to querry
//    PFQuery *parseUserPhone = [PFQuery queryWithClassName:@"User"];
    
    PFQuery *parseUserPhone = [PFUser query];
    
    
    //give object to compare to
    
    NSString *userPhoneNumber = [[PFUser currentUser] objectForKey:@"PhoneNumber"];
    NSLog(@"my phone is %@", userPhoneNumber);
    
    
    //set parameters
    
    [parseUserPhone whereKeyExists:@"PhoneNumber"];
    
    
    [parseUserPhone findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        
        
        
        if (!error) {
            arrayFromParseQuery = [[NSArray alloc]initWithArray:objects];
            NSLog(@" running query");
            
           
            
            for (PFUser *d in objects) {
                
                NSString *phone  = [d objectForKey:@"PhoneNumber"];
                
                NSLog(@" number %@", phone);
                
            }

        }
        
        
    }];
    
    
    //run query
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
