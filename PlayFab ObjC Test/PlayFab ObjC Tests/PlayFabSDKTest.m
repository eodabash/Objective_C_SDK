//
//  PlayFabSDKTest.m
//  PlayFab ObjC Test
//
//  Created by William Burgers on 2/26/16.
//  Copyright © 2016 PlayFab, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PlayFabSDK.h"

@interface PlayFabSDKTest : XCTestCase

@property bool TITLE_INFO_SET;
@property bool TITLE_CAN_UPDATE_SETTINGS;

@property NSString* USER_NAME;
@property NSString* USER_EMAIL;
@property NSString* USER_PASSWORD;
@property NSString* CHAR_NAME;

// Class variables used for maintaining test data from blocks.
@property PlayFabError *stored_error;
@property bool login_success;
@property RegisterPlayFabUserResult *register_result;

@end

@implementation PlayFabSDKTest

@synthesize TITLE_INFO_SET;
@synthesize TITLE_CAN_UPDATE_SETTINGS;

@synthesize USER_NAME;
@synthesize USER_EMAIL;
@synthesize USER_PASSWORD;
@synthesize CHAR_NAME;


- (void)setUp {
    [super setUp];
    //NOTE: Remove extra new lines and comments from JSON, to not confuse the parser.
    
    //Grab the testTitleData.json file from inside our project.
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"testTitleData" ofType:@"json"];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    if (myData) {
        NSString *testString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        //NSLog(@"%@",testString);
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[testString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        
        [self SetTitleInfo:dictionary];
    }
    else{
        XCTFail(@"testTitleData.json null or not found.");
    }
    
    //if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    //{
    /*}
    else{
    }*/
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void) SetTitleInfo:(NSDictionary*)testInputs
{
    
    //PlayFabHTTP.instance.Awake();
    //PlayFabSettings.RequestType = WebRequestType.HttpWebRequest;
    
    TITLE_INFO_SET = true;
    
    // Parse all the inputs
    //TITLE_INFO_SET &= testInputs.TryGetValue("titleId", out eachValue);
    [PlayFabSettings setTitleId:[testInputs valueForKey:@"titleId"]];
    //TITLE_INFO_SET &= testInputs.TryGetValue("developerSecretKey", out eachValue);
    [PlayFabSettings setDeveloperSecretKey:[testInputs valueForKey:@"developerSecretKey"]];
    
    USER_NAME = [testInputs valueForKey:@"userName"];
    USER_EMAIL = [testInputs valueForKey:@"userEmail"];
    USER_PASSWORD = [testInputs valueForKey:@"userPassword"];
    CHAR_NAME = [testInputs valueForKey:@"characterName"];
    
    TITLE_INFO_SET &=
    (PlayFabSettings.TitleId != nil && ![PlayFabSettings.TitleId isEqualToString:@""])
    && (PlayFabSettings.DeveloperSecretKey != nil && ![PlayFabSettings.DeveloperSecretKey isEqualToString:@""])
    && (PlayFabSettings.DeveloperSecretKey != nil && ![PlayFabSettings.DeveloperSecretKey isEqualToString:@""])
    && (USER_NAME != nil && ![USER_NAME isEqualToString:@""])
    && (USER_EMAIL != nil && ![USER_EMAIL isEqualToString:@""])
    && (USER_PASSWORD != nil && ![USER_PASSWORD isEqualToString:@""])
    && (CHAR_NAME != nil && ![CHAR_NAME isEqualToString:@""]);
    
    if(!TITLE_INFO_SET){
        XCTFail(@"Title Info has invalid data!");
    }
    
}

- (void)testLoginWithExistingAccountIncorrectPassword {
    
    XCTestExpectation *exp = [self expectationWithDescription:@"Login"];
    
    LoginWithEmailAddressRequest* request = [LoginWithEmailAddressRequest new];
    request.TitleId = PlayFabSettings.TitleId;
    
    request.Email = USER_EMAIL;
    request.Password = [NSString stringWithFormat:@"%@%@",USER_PASSWORD, @"INVALID"];
    
    
    [[PlayFabClientAPI GetInstance] LoginWithEmailAddress:request
                                         success:^(LoginResult* result, NSObject* userData) {
                                             XCTFail(@"Login succeeded with incorrect password!");
                                         }
                                         failure:^(PlayFabError *error, NSObject *userData) {
                                             //Request errored or failed to connect.
                                             self.stored_error = error;
                                             [exp fulfill];
                                         } withUserData:nil];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError *error) {
        
        if ([self.stored_error.errorMessage rangeOfString:@"password"].location == NSNotFound) {
            XCTFail(@"errorMessage '%@' does not contain 'password'.", self.stored_error.errorMessage);
        } else {
            //Worked as intended! The errorMessage contained the word password.
        }
        
    }];
    
}

- (void) testLoginOrRegister
{
    
    XCTestExpectation *exp = [self expectationWithDescription:@"Login"];
    
    if (![PlayFabClientAPI IsClientLoggedIn]) // If we haven't already logged in...
    {
        LoginWithEmailAddressRequest* request = [LoginWithEmailAddressRequest new];
        
        request.Email = USER_EMAIL;
        request.Password = USER_PASSWORD;
        request.TitleId = PlayFabSettings.TitleId;
        
        self.login_success = false;
        [[PlayFabClientAPI GetInstance] LoginWithEmailAddress:request
                                                      success:^(LoginResult* result, NSObject* userData) {
                                                          [exp fulfill];
                                                      }
                                                      failure:^(PlayFabError *error, NSObject *userData) {
                                                          [exp fulfill];
                                                      } withUserData:nil];
        
        // We don't do any test here, because the user may not exist, and thus login might fail, but the test should not
    }
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError *error) {
        
        if ([PlayFabClientAPI IsClientLoggedIn])
            return; // Success, already logged in
        
        
        //exp = [self expectationWithDescription:@"CreateUser"];
        
        RegisterPlayFabUserRequest* register_request = [RegisterPlayFabUserRequest new];
        
        register_request.TitleId = PlayFabSettings.TitleId;
        register_request.Username = USER_NAME;
        register_request.Email = USER_EMAIL;
        register_request.Password = USER_PASSWORD;
        
        [[PlayFabClientAPI GetInstance] RegisterPlayFabUser:register_request
                                                    success:^(RegisterPlayFabUserResult* result, NSObject* userData) {
                                                        self.register_result = result;
                                                        //[exp fulfill];
                                                    }
                                                    failure:^(PlayFabError *error, NSObject *userData) {
                                                        self.stored_error = error;
                                                        XCTFail(@"Registration Failed!");
                                                        //[exp fulfill];
                                                    } withUserData:nil];
        
        
        /*[self waitForExpectationsWithTimeout:30 handler:^(NSError *error) {
            
            if([self.register_result class] != [NSNull class]){
                // Received a successful register result class.
            }
            
        }];*/

        
        
    }];
    
    
}

/// <summary>
/// CLIENT API
/// Test that the login call sequence sends the AdvertisingId when set
/// </summary>
- (void) testLoginWithAdvertisingId
{
    [PlayFabSettings setAdvertisingIdType:AD_TYPE_ANDROID_ID];
    [PlayFabSettings setAdvertisingIdValue: @"PlayFabTestId" ];
    
    
    XCTestExpectation *exp = [self expectationWithDescription:@"Login"];
    
    LoginWithEmailAddressRequest* request = [LoginWithEmailAddressRequest new];
    request.TitleId = PlayFabSettings.TitleId;
    
    request.Email = USER_EMAIL;
    request.Password = USER_PASSWORD;
    
    
    [[PlayFabClientAPI GetInstance] LoginWithEmailAddress:request
                                                  success:^(LoginResult* result, NSObject* userData) {
                                                      [exp fulfill];
                                                  }
                                                  failure:^(PlayFabError *error, NSObject *userData) {
                                                      //Request errored or failed to connect.
                                                      self.stored_error = error;
                                                      [exp fulfill];
                                                  } withUserData:nil];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError *error) {
        NSString* string_1 = [NSString stringWithFormat:@"%@%@",AD_TYPE_ANDROID_ID, @"_Successful"];
        XCTAssertEqual(string_1, PlayFabSettings.AdvertisingIdType);
    }];
}


@end
