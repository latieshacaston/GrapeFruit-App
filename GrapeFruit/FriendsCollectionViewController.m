//
//  FriendsViewController.m
//  GrapeFruit
//
//  Created by Aileen Taboy on 1/13/16.
//  Copyright © 2016 Mike. All rights reserved.
//

#import "FriendsCollectionViewController.h"
#import <Parse/Parse.h>
#import "CustomCell.h"

@import Contacts;
@interface FriendsCollectionViewController () {
    
    //Array to store the parse querry in
    NSArray *arrayFromParseQuery;
    
    //Array to store the phone querry in
    NSArray *arrayFromPhoneQuery;
    
    //Relation Query Array
    NSArray *friendsFromRelationQuery;
    
    
    
}



@end

@implementation FriendsCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //Initiate request for phoneBook access
    [self contactScan];
    
}





-(void)viewWillAppear:(BOOL)animated {
    
    
    PFRelation *relation = [[PFUser currentUser] relationForKey:@"Friends"];
    PFQuery *friendsQuery = [relation query];
    
    
    // pfrelationquery
    
    [friendsQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        if(!error) {
        
            //initialize Array
            friendsFromRelationQuery = [[NSArray alloc]initWithArray:objects];
            
            //reload collection view
            
            [self.collectionView reloadData];
            
            
        }else {
            
            NSLog(@"there is an error");
        }
        
        
    }];
    
    
    
    
}


#pragma mark - ask for and scan contacts

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
        }else {
            NSLog(@"bummer, parseQuery can't run");
        }
        
        
    }];
    
    
    
    
    
    
    
}

#pragma mark - array comparrison method
-(void)arrayComparrison {
    
    
    //get phone from parse
    
    // compare to phone from local storage
 
    long objectCount = arrayFromParseQuery.count;
    long localPhoneCount = arrayFromPhoneQuery.count;
    
    
    //setup PFRelation
    
    PFRelation *friendRelation = [[PFUser currentUser] relationForKey:@"Friends"];
    
    while (objectCount > 0) {
        
        NSLog(@"objectCount is %ld  localPhoneCount is %ld", objectCount, localPhoneCount);
        
        PFObject *parseObject = arrayFromParseQuery[objectCount-1];
        
        NSString *ParsePhone = [parseObject objectForKey:@"PhoneNumber"];
       
        for (long localNum = localPhoneCount -1; localNum >= 0; localNum--) {
            
            //phone contact
            NSString *localPhone = arrayFromPhoneQuery[localNum];
            
            
            
            if ([localPhone isEqualToString:ParsePhone]){
                
                // add the contact as a relation to parse
                
                 [friendRelation addObject:parseObject];
              
                
            }
        }
        objectCount -= 1;
        
        
        
    }
    
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            [self  viewWillAppear:YES];
        }else {
            
            NSLog(@"sorry there was an error");
        }
    }];

    

}

#pragma mark - collection view

//CustomCell identifier
NSString *cellId = @"Cell";

- (NSInteger)collectionView: (UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return [friendsFromRelationQuery count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath;
{
    CustomCell *cell = (CustomCell *)[cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    PFObject *friendObject = friendsFromRelationQuery[0];
    
    
    
    
    PFObject *friendObject = [friendsFromRelationQuery objectAtIndex:indexPath.row];
    
    PFFile *userImage = [friendObject objectForKey:@"ProfilePhoto"];
    
    
    [userImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        
        if (!error) {
            // load the image for this cell
//            NSString *imageToLoad = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
            cell.imageView.image = [UIImage imageWithData:data];
            cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width / 2;
            cell.imageView.layer.borderWidth = 3.0f;
            cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
            cell.imageView.clipsToBounds = YES;
        }
        
        
    }];
    
    
    cell.label.text = [NSString stringWithFormat:@"%@", [friendObject objectForKey:@"FirstName"]];
    
    
    
    
    
   
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
