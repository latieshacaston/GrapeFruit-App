//
//  FriendsViewController.m
//  GrapeFruit
//
//  Created by Aileen Taboy on 1/13/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import "FriendsViewController.h"
@import Contacts;
@interface FriendsViewController ()

@property (nonatomic, strong)CNContactStore *contactStore;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}



-(void)viewDidAppear:(BOOL)animated {
    
    [self contactScan];
    
}



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

-(void)getAllContact
{
    if([CNContactStore class])
    {
        //iOS 9 or later
        NSError* contactError;
        CNContactStore* addressBook = [[CNContactStore alloc]init];
        [addressBook containersMatchingPredicate:[CNContainer predicateForContainersWithIdentifiers: @[addressBook.defaultContainerIdentifier]] error:&contactError];
        
        NSArray * keysToFetch =@[CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPostalAddressesKey];
        CNContactFetchRequest * request = [[CNContactFetchRequest alloc]initWithKeysToFetch:keysToFetch];
//        BOOL success =
        [addressBook enumerateContactsWithFetchRequest:request error:&contactError usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop){
            
                //            [self parseContactWithContact:contact];
                
                
                NSString * firstName =  contact.givenName;
                NSString * lastName =  contact.familyName;
                NSString * phone = [[contact.phoneNumbers valueForKey:@"value"] valueForKey:@"digits"];
                NSString * email = [contact.emailAddresses valueForKey:@"value"];
//                    NSArray * addrArr = [self parseAddressWithContac:contact];
                NSLog(@"phone numbers are %@", phone);
                
                
                
         
           
        }];
        
        NSLog( @"fetch %@", keysToFetch);
    }
}



- (void)parseContactWithContact :(CNContact* )contact
{
    NSString * firstName =  contact.givenName;
    NSString * lastName =  contact.familyName;
    NSString * phone = [[contact.phoneNumbers valueForKey:@"value"] valueForKey:@"digits"];
    NSString * email = [contact.emailAddresses valueForKey:@"value"];
//    NSArray * addrArr = [self parseAddressWithContac:contact];
}
//
//- (NSMutableArray *)parseAddressWithContac: (CNContact *)contact
//{
//    NSMutableArray * addrArr = [[NSMutableArray alloc]init];
//    CNPostalAddressFormatter * formatter = [[CNPostalAddressFormatter alloc]init];
//    NSArray * addresses = (NSArray*)[contact.postalAddresses valueForKey:@"value"];
//    if (addresses.count > 0) {
//        for (CNPostalAddress* address in addresses) {
//            [addrArr addObject:[formatter stringFromPostalAddress:address]];
//        }
//    }
//    return addrArr;
//}



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
