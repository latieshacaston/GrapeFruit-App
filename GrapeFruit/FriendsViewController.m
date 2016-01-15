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
    
    //Array to store the parse querry in
    NSArray *arrayFromParseQuery;
    
     //Array to store the phone querry in
    NSArray *arrayFromPhoneQuery;
    
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
           
           
       NSArray * phoneStringArray = [[contact.phoneNumbers valueForKey:@"value"] valueForKey:@"digits"];
           
//                CNPhoneNumber * phoneString = [[contact.phoneNumbers valueForKey:@"value"] valueForKey:@"digits"];

           for (NSString *phone in phoneStringArray) {
               
               
               [forNumber addObject:phone];
           }
           
           
//           NSLog(@"phonestring is %@", phoneString);
//
//           
//                [forNumber addObject:phoneString];

           
        }];
        
//        loop through complete array (parse query will go here)
        if (phoneRequestComplete) {
            
           //init array
            
            arrayFromPhoneQuery = [[NSArray alloc]initWithArray:forNumber];
            //run parse query
            [self parseQuery];
            
            
            
        }
        
    }
}


#pragma mark - parse query  
-(void)parseQuery {
  
    
    
    
    //assign class to querry
    
    PFQuery *parseUserPhone = [PFUser query];
    
    
    //set parameters
    
    [parseUserPhone whereKeyExists:@"PhoneNumber"];
    
    
    [parseUserPhone findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        
        
        
        if (!error) {
        
            arrayFromParseQuery = [[NSArray alloc]initWithArray:objects];
            [self arrayComparrison];
        }
        
        
    }];
    
    
    

    
    
    
}

#pragma mark - array comparrison method
-(void)arrayComparrison {
    
    //get phone from parse
    
    // compare to phone from local storage
  
    
    long objectCount = arrayFromParseQuery.count;
    long localPhoneCount = arrayFromPhoneQuery.count;
    
    while (objectCount > 0) {
        
        NSLog(@"objectCount is %ld  localPhoneCount is %ld", objectCount, localPhoneCount);
     
        PFObject *parseObject = arrayFromParseQuery[objectCount-1];
        
        NSString *ParsePhone = [parseObject objectForKey:@"PhoneNumber"];
        
        for (long localNum = localPhoneCount -1; localNum >= 0; localNum--) {
            
            //phone contact
            NSString *localPhone = arrayFromPhoneQuery[localNum];
            
            NSLog(@"%@",localPhone);
            
            
            if ([localPhone isEqualToString:ParsePhone]){
                
                NSLog(@"found one %@ and %@", localPhone, ParsePhone);
                
            }
        }
        objectCount -= 1;
        //localPhoneCount -=1;
        
        
    }


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
