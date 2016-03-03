PlayFab SDK for Objective-C Beta


To get started, look at the "PlayFab ObjC Test" project, or copy the "PlayFab ObjC SDK" folder into an existing project.

Set your PlayFab TitleId in PlayFabSettings.m, on the line:
static NSString * TitleId = @"XXXX";


Example of syntax for making a request and receiving the response:

    //EXAMPLE: Login with custom id request:

    //Build the Request object:
    LoginWithCustomIDRequest* login_request = [LoginWithCustomIDRequest new];
    login_request.CustomId = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; //use the identifier for vendor as our custom ID.
    login_request.CreateAccount = true; //creates a new account if no existing one
    
    //Make each call to [PlayFabClientAPI GetInstance], the first time you do this, an instance will be created and then used.
    [[PlayFabClientAPI GetInstance] LoginWithCustomID:login_request
                                              success:^(LoginResult* result, NSObject* userData) {
                                                  //This block will run when we receive successful response, inspect the result class for pertinent info.
                                                  NSLog(@"error %@",result.PlayFabId);
                                              }
                                              failure:^(PlayFabError *error, NSObject *userData) {
                                                  //Request errored or failed to connect, inspect the PlayFabError class for pertinent info.
                                                  NSLog(@"error %@",error.description);
                                              } withUserData:nil];




IDFA/advertisingIdentifier logic is present but has not been properly tested.
Is off by default, only available if you explicitly add USE_IDFA=1 to Target > Build Settings > Preprocessor Macros.

testTitleData.json is present in project but must be changed to valid data for any Unit Tests to work.