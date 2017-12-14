//
//  ViewController.m
//  AppConfig
//
//  Created by David Arnold on 09/12/2017.
//  Copyright © 2017 David Arnold. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize serverURL;
@synthesize enableHTTPS;
@synthesize username;
@synthesize userEmailAddress;
@synthesize otherVariable;

// The Managed app configuration dictionary pushed down from an MDM server are stored in this key.
static NSString * const kConfigurationKey = @"com.apple.configuration.managed";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Add Notification Center observer to be alerted of any change to NSUserDefaults.
    // Managed app configuration changes pushed down from an MDM server appear in NSUSerDefaults.
    [[NSNotificationCenter defaultCenter] addObserverForName:NSUserDefaultsDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [self readUserDefaultsValues];
                                                  }];
    [self readUserDefaultsValues];
}


-(void) readUserDefaultsValues {
    NSDictionary *managedAppConfig = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kConfigurationKey];
    
    NSString *serverURLString = (NSString*)[managedAppConfig valueForKey:@"serverURL"];
    BOOL enableHTTPSBoolean = CFBooleanGetValue((CFBooleanRef)[managedAppConfig valueForKey:@"enableHTTPS"]);
    NSString *usernameString = (NSString*) [managedAppConfig valueForKey:@"username"];
    NSString *userEmailAddressString = (NSString*) [managedAppConfig valueForKey:@"userEmailAddress"];
    NSString *otherVariableString = (NSString*) [managedAppConfig valueForKey:@"otherVariable"];
    
    
    // Data coming from MDM server should be validated before use.
    // If validation fails, be sure to set a sensible default value as a fallback, even if it is nil.
    self.serverURL.text = [self parseStringValue:serverURLString withDefault:@"no server url specified"];
    self.username.text = [self parseStringValue:usernameString withDefault:@"no username specified"];
    self.userEmailAddress.text = [self parseStringValue:userEmailAddressString withDefault:@"no userEmailAddress specified"];
    self.otherVariable.text = [self parseStringValue:otherVariableString withDefault:@"no otherVariable specified"];
    
    [self.enableHTTPS setOn:enableHTTPSBoolean];
    
}

-(NSString*) parseStringValue:(NSString *)managedValue withDefault:(NSString *)defaultValue {
    if (managedValue && [managedValue isKindOfClass:[NSString class]]) {
        return managedValue;
    } else {
        return defaultValue;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
