//
//  ViewController.h
//  AppConfig
//
//  Created by David Arnold on 09/12/2017.
//  Copyright © 2017 David Arnold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *serverURL;
@property (strong, nonatomic) IBOutlet UISwitch *enableHTTPS;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *userEmailAddress;
@property (strong, nonatomic) IBOutlet UITextField *otherVariable;

-(void) readUserDefaultsValues;

-(NSString*) parseStringValue: (NSString*) managedValue withDefault: (NSString*) defaultValue;

@end

