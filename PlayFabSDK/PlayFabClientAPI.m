#import "PlayFabClientAPI.h"
#import "PlayFabConnection.h"
//#import "PlayFabSettings.h"
//#import "PlayFabVersion.h"

#import <UIKit/UIKit.h>
#include <sys/sysctl.h>

#import "JAGPropertyConverter.h"


@implementation PlayFabClientAPI

+(NSString*)GetURL {
return [NSString stringWithFormat:@"https://%@%@", PlayFabSettings.TitleId, PlayFabSettings.ProductionEnvironmentURL];
}

static PlayFabClientAPI* PlayFabInstance;

+ (PlayFabClientAPI*) GetInstance {
if(PlayFabInstance == NULL) {
PlayFabInstance = [PlayFabClientAPI new];
}
return PlayFabInstance;
}

+ (NSString *)getModel {
size_t size;
sysctlbyname("hw.machine", NULL, &size, NULL, 0);
char *model = malloc(size);
sysctlbyname("hw.machine", model, &size, NULL, 0);
NSString *deviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
free(model);
return deviceModel;
}


+(bool)IsClientLoggedIn {
    return !([[PlayFabClientAPI GetInstance].mUserSessionTicket length]==0);}

#ifdef USE_IDFA
-(void) MultiStepClientLogin:(bool) needsAttribution {
    if (needsAttribution && [PlayFabSettings.AdvertisingIdValue length] != 0) {
        [PlayFabSettings setAdvertisingIdValue:[PlayFabSettings identifierForAdvertising]];
    }
    //GetAdvertisingId(out PlayFab.PlayFabSettings.AdvertisingIdType, out PlayFab.PlayFabSettings.AdvertisingIdValue, ref PlayFab.PlayFabSettings.DisableAdvertising);

    // Send the ID when appropriate
    if (needsAttribution && [PlayFabSettings.AdvertisingIdValue length] != 0) {
        AttributeInstallRequest* install_request = [AttributeInstallRequest new];
        install_request.Idfa = PlayFabSettings.AdvertisingIdValue;

        [[PlayFabClientAPI GetInstance] AttributeInstall:install_request
        success:^(AttributeInstallResult* result, NSObject* userData) {
            // Modify AdvertisingIdType:  Prevents us from sending the id multiple times, and allows automated tests to determine id was sent successfully
            [PlayFabSettings setAdvertisingIdType:[NSString stringWithFormat:@"%@%@",PlayFabSettings.AdvertisingIdType,@"_Successful"]];
            NSLog(@"playfab adid %@", PlayFabSettings.AdvertisingIdType);
        }
        failure:^(PlayFabError *error, NSObject *userData) {
            NSLog(@"attribute install fail");
            //Request errored or failed to connect.
        } withUserData:nil];
    }
}
#endif
-(void) AcceptTrade:(AcceptTradeRequest*)request success:(AcceptTradeCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[AcceptTradeRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                AcceptTradeResponse *model = [[AcceptTradeResponse new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/AcceptTrade"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) AddFriend:(AddFriendRequest*)request success:(AddFriendCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[AddFriendRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                AddFriendResult *model = [[AddFriendResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/AddFriend"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) AddGenericID:(AddGenericIDRequest*)request success:(AddGenericIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[AddGenericIDRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                AddGenericIDResult *model = [[AddGenericIDResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/AddGenericID"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) AddOrUpdateContactEmail:(AddOrUpdateContactEmailRequest*)request success:(AddOrUpdateContactEmailCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[AddOrUpdateContactEmailRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                AddOrUpdateContactEmailResult *model = [[AddOrUpdateContactEmailResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/AddOrUpdateContactEmail"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) AddSharedGroupMembers:(AddSharedGroupMembersRequest*)request success:(AddSharedGroupMembersCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[AddSharedGroupMembersRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                AddSharedGroupMembersResult *model = [[AddSharedGroupMembersResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/AddSharedGroupMembers"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) AddUsernamePassword:(AddUsernamePasswordRequest*)request success:(AddUsernamePasswordCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[AddUsernamePasswordRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                AddUsernamePasswordResult *model = [[AddUsernamePasswordResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/AddUsernamePassword"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) AddUserVirtualCurrency:(AddUserVirtualCurrencyRequest*)request success:(AddUserVirtualCurrencyCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[AddUserVirtualCurrencyRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                ModifyUserVirtualCurrencyResult *model = [[ModifyUserVirtualCurrencyResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/AddUserVirtualCurrency"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) AndroidDevicePushNotificationRegistration:(AndroidDevicePushNotificationRegistrationRequest*)request success:(AndroidDevicePushNotificationRegistrationCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[AndroidDevicePushNotificationRegistrationRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                AndroidDevicePushNotificationRegistrationResult *model = [[AndroidDevicePushNotificationRegistrationResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/AndroidDevicePushNotificationRegistration"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) AttributeInstall:(AttributeInstallRequest*)request success:(AttributeInstallCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[AttributeInstallRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                AttributeInstallResult *model = [[AttributeInstallResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/AttributeInstall"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) CancelTrade:(CancelTradeRequest*)request success:(CancelTradeCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[CancelTradeRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                CancelTradeResponse *model = [[CancelTradeResponse new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/CancelTrade"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) ConfirmPurchase:(ConfirmPurchaseRequest*)request success:(ConfirmPurchaseCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[ConfirmPurchaseRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                ConfirmPurchaseResult *model = [[ConfirmPurchaseResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/ConfirmPurchase"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) ConsumeItem:(ConsumeItemRequest*)request success:(ConsumeItemCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[ConsumeItemRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                ConsumeItemResult *model = [[ConsumeItemResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/ConsumeItem"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) CreateSharedGroup:(CreateSharedGroupRequest*)request success:(CreateSharedGroupCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[CreateSharedGroupRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                CreateSharedGroupResult *model = [[CreateSharedGroupResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/CreateSharedGroup"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) ExecuteCloudScript:(ExecuteCloudScriptRequest*)request success:(ExecuteCloudScriptCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[ExecuteCloudScriptRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                ExecuteCloudScriptResult *model = [[ExecuteCloudScriptResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/ExecuteCloudScript"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetAccountInfo:(GetAccountInfoRequest*)request success:(GetAccountInfoCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetAccountInfoRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetAccountInfoResult *model = [[GetAccountInfoResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetAccountInfo"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetAllUsersCharacters:(ListUsersCharactersRequest*)request success:(GetAllUsersCharactersCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[ListUsersCharactersRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                ListUsersCharactersResult *model = [[ListUsersCharactersResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetAllUsersCharacters"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetCatalogItems:(GetCatalogItemsRequest*)request success:(GetCatalogItemsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetCatalogItemsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetCatalogItemsResult *model = [[GetCatalogItemsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetCatalogItems"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetCharacterData:(GetCharacterDataRequest*)request success:(GetCharacterDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetCharacterDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetCharacterDataResult *model = [[GetCharacterDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetCharacterData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetCharacterInventory:(GetCharacterInventoryRequest*)request success:(GetCharacterInventoryCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetCharacterInventoryRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetCharacterInventoryResult *model = [[GetCharacterInventoryResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetCharacterInventory"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetCharacterLeaderboard:(GetCharacterLeaderboardRequest*)request success:(GetCharacterLeaderboardCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetCharacterLeaderboardRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetCharacterLeaderboardResult *model = [[GetCharacterLeaderboardResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetCharacterLeaderboard"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetCharacterReadOnlyData:(GetCharacterDataRequest*)request success:(GetCharacterReadOnlyDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetCharacterDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetCharacterDataResult *model = [[GetCharacterDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetCharacterReadOnlyData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetCharacterStatistics:(GetCharacterStatisticsRequest*)request success:(GetCharacterStatisticsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetCharacterStatisticsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetCharacterStatisticsResult *model = [[GetCharacterStatisticsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetCharacterStatistics"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetContentDownloadUrl:(GetContentDownloadUrlRequest*)request success:(GetContentDownloadUrlCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetContentDownloadUrlRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetContentDownloadUrlResult *model = [[GetContentDownloadUrlResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetContentDownloadUrl"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetCurrentGames:(CurrentGamesRequest*)request success:(GetCurrentGamesCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[CurrentGamesRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                CurrentGamesResult *model = [[CurrentGamesResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetCurrentGames"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetFriendLeaderboard:(GetFriendLeaderboardRequest*)request success:(GetFriendLeaderboardCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetFriendLeaderboardRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetLeaderboardResult *model = [[GetLeaderboardResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetFriendLeaderboard"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetFriendLeaderboardAroundPlayer:(GetFriendLeaderboardAroundPlayerRequest*)request success:(GetFriendLeaderboardAroundPlayerCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetFriendLeaderboardAroundPlayerRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetFriendLeaderboardAroundPlayerResult *model = [[GetFriendLeaderboardAroundPlayerResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetFriendLeaderboardAroundPlayer"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetFriendsList:(GetFriendsListRequest*)request success:(GetFriendsListCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetFriendsListRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetFriendsListResult *model = [[GetFriendsListResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetFriendsList"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetGameServerRegions:(GameServerRegionsRequest*)request success:(GetGameServerRegionsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GameServerRegionsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GameServerRegionsResult *model = [[GameServerRegionsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetGameServerRegions"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetLeaderboard:(GetLeaderboardRequest*)request success:(GetLeaderboardCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetLeaderboardRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetLeaderboardResult *model = [[GetLeaderboardResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetLeaderboard"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetLeaderboardAroundCharacter:(GetLeaderboardAroundCharacterRequest*)request success:(GetLeaderboardAroundCharacterCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetLeaderboardAroundCharacterRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetLeaderboardAroundCharacterResult *model = [[GetLeaderboardAroundCharacterResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetLeaderboardAroundCharacter"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetLeaderboardAroundPlayer:(GetLeaderboardAroundPlayerRequest*)request success:(GetLeaderboardAroundPlayerCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetLeaderboardAroundPlayerRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetLeaderboardAroundPlayerResult *model = [[GetLeaderboardAroundPlayerResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetLeaderboardAroundPlayer"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetLeaderboardForUserCharacters:(GetLeaderboardForUsersCharactersRequest*)request success:(GetLeaderboardForUserCharactersCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetLeaderboardForUsersCharactersRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetLeaderboardForUsersCharactersResult *model = [[GetLeaderboardForUsersCharactersResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetLeaderboardForUserCharacters"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPaymentToken:(GetPaymentTokenRequest*)request success:(GetPaymentTokenCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPaymentTokenRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPaymentTokenResult *model = [[GetPaymentTokenResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPaymentToken"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPhotonAuthenticationToken:(GetPhotonAuthenticationTokenRequest*)request success:(GetPhotonAuthenticationTokenCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPhotonAuthenticationTokenRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPhotonAuthenticationTokenResult *model = [[GetPhotonAuthenticationTokenResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPhotonAuthenticationToken"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayerCombinedInfo:(GetPlayerCombinedInfoRequest*)request success:(GetPlayerCombinedInfoCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayerCombinedInfoRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayerCombinedInfoResult *model = [[GetPlayerCombinedInfoResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayerCombinedInfo"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayerProfile:(GetPlayerProfileRequest*)request success:(GetPlayerProfileCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayerProfileRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayerProfileResult *model = [[GetPlayerProfileResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayerProfile"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayerSegments:(GetPlayerSegmentsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData
{
    
    
    NSString *jsonString = @"{}";
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayerSegmentsResult *model = [[GetPlayerSegmentsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayerSegments"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayerStatistics:(GetPlayerStatisticsRequest*)request success:(GetPlayerStatisticsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayerStatisticsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayerStatisticsResult *model = [[GetPlayerStatisticsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayerStatistics"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayerStatisticVersions:(GetPlayerStatisticVersionsRequest*)request success:(GetPlayerStatisticVersionsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayerStatisticVersionsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayerStatisticVersionsResult *model = [[GetPlayerStatisticVersionsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayerStatisticVersions"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayerTags:(GetPlayerTagsRequest*)request success:(GetPlayerTagsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayerTagsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayerTagsResult *model = [[GetPlayerTagsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayerTags"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayerTrades:(GetPlayerTradesRequest*)request success:(GetPlayerTradesCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayerTradesRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayerTradesResponse *model = [[GetPlayerTradesResponse new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayerTrades"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayFabIDsFromFacebookIDs:(GetPlayFabIDsFromFacebookIDsRequest*)request success:(GetPlayFabIDsFromFacebookIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayFabIDsFromFacebookIDsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayFabIDsFromFacebookIDsResult *model = [[GetPlayFabIDsFromFacebookIDsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayFabIDsFromFacebookIDs"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayFabIDsFromGameCenterIDs:(GetPlayFabIDsFromGameCenterIDsRequest*)request success:(GetPlayFabIDsFromGameCenterIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayFabIDsFromGameCenterIDsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayFabIDsFromGameCenterIDsResult *model = [[GetPlayFabIDsFromGameCenterIDsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayFabIDsFromGameCenterIDs"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayFabIDsFromGenericIDs:(GetPlayFabIDsFromGenericIDsRequest*)request success:(GetPlayFabIDsFromGenericIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayFabIDsFromGenericIDsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayFabIDsFromGenericIDsResult *model = [[GetPlayFabIDsFromGenericIDsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayFabIDsFromGenericIDs"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayFabIDsFromGoogleIDs:(GetPlayFabIDsFromGoogleIDsRequest*)request success:(GetPlayFabIDsFromGoogleIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayFabIDsFromGoogleIDsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayFabIDsFromGoogleIDsResult *model = [[GetPlayFabIDsFromGoogleIDsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayFabIDsFromGoogleIDs"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayFabIDsFromKongregateIDs:(GetPlayFabIDsFromKongregateIDsRequest*)request success:(GetPlayFabIDsFromKongregateIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayFabIDsFromKongregateIDsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayFabIDsFromKongregateIDsResult *model = [[GetPlayFabIDsFromKongregateIDsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayFabIDsFromKongregateIDs"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayFabIDsFromSteamIDs:(GetPlayFabIDsFromSteamIDsRequest*)request success:(GetPlayFabIDsFromSteamIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayFabIDsFromSteamIDsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayFabIDsFromSteamIDsResult *model = [[GetPlayFabIDsFromSteamIDsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayFabIDsFromSteamIDs"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPlayFabIDsFromTwitchIDs:(GetPlayFabIDsFromTwitchIDsRequest*)request success:(GetPlayFabIDsFromTwitchIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPlayFabIDsFromTwitchIDsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPlayFabIDsFromTwitchIDsResult *model = [[GetPlayFabIDsFromTwitchIDsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPlayFabIDsFromTwitchIDs"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPublisherData:(GetPublisherDataRequest*)request success:(GetPublisherDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPublisherDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPublisherDataResult *model = [[GetPublisherDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPublisherData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetPurchase:(GetPurchaseRequest*)request success:(GetPurchaseCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetPurchaseRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetPurchaseResult *model = [[GetPurchaseResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetPurchase"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetSharedGroupData:(GetSharedGroupDataRequest*)request success:(GetSharedGroupDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetSharedGroupDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetSharedGroupDataResult *model = [[GetSharedGroupDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetSharedGroupData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetStoreItems:(GetStoreItemsRequest*)request success:(GetStoreItemsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetStoreItemsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetStoreItemsResult *model = [[GetStoreItemsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetStoreItems"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetTime:(GetTimeCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData
{
    
    
    NSString *jsonString = @"{}";
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetTimeResult *model = [[GetTimeResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetTime"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetTitleData:(GetTitleDataRequest*)request success:(GetTitleDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetTitleDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetTitleDataResult *model = [[GetTitleDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetTitleData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetTitleNews:(GetTitleNewsRequest*)request success:(GetTitleNewsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetTitleNewsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetTitleNewsResult *model = [[GetTitleNewsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetTitleNews"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetTitlePublicKey:(GetTitlePublicKeyRequest*)request success:(GetTitlePublicKeyCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetTitlePublicKeyRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetTitlePublicKeyResult *model = [[GetTitlePublicKeyResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetTitlePublicKey"] body:jsonString authType:nil authKey:nil];
}
-(void) GetTradeStatus:(GetTradeStatusRequest*)request success:(GetTradeStatusCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetTradeStatusRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetTradeStatusResponse *model = [[GetTradeStatusResponse new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetTradeStatus"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetUserData:(GetUserDataRequest*)request success:(GetUserDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetUserDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetUserDataResult *model = [[GetUserDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetUserData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetUserInventory:(GetUserInventoryCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData
{
    
    
    NSString *jsonString = @"{}";
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetUserInventoryResult *model = [[GetUserInventoryResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetUserInventory"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetUserPublisherData:(GetUserDataRequest*)request success:(GetUserPublisherDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetUserDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetUserDataResult *model = [[GetUserDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetUserPublisherData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetUserPublisherReadOnlyData:(GetUserDataRequest*)request success:(GetUserPublisherReadOnlyDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetUserDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetUserDataResult *model = [[GetUserDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetUserPublisherReadOnlyData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetUserReadOnlyData:(GetUserDataRequest*)request success:(GetUserReadOnlyDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetUserDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetUserDataResult *model = [[GetUserDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetUserReadOnlyData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) GetWindowsHelloChallenge:(GetWindowsHelloChallengeRequest*)request success:(GetWindowsHelloChallengeCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GetWindowsHelloChallengeRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GetWindowsHelloChallengeResponse *model = [[GetWindowsHelloChallengeResponse new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GetWindowsHelloChallenge"] body:jsonString authType:nil authKey:nil];
}
-(void) GrantCharacterToUser:(GrantCharacterToUserRequest*)request success:(GrantCharacterToUserCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[GrantCharacterToUserRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                GrantCharacterToUserResult *model = [[GrantCharacterToUserResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/GrantCharacterToUser"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) LinkAndroidDeviceID:(LinkAndroidDeviceIDRequest*)request success:(LinkAndroidDeviceIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[LinkAndroidDeviceIDRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LinkAndroidDeviceIDResult *model = [[LinkAndroidDeviceIDResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LinkAndroidDeviceID"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) LinkCustomID:(LinkCustomIDRequest*)request success:(LinkCustomIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[LinkCustomIDRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LinkCustomIDResult *model = [[LinkCustomIDResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LinkCustomID"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) LinkFacebookAccount:(LinkFacebookAccountRequest*)request success:(LinkFacebookAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[LinkFacebookAccountRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LinkFacebookAccountResult *model = [[LinkFacebookAccountResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LinkFacebookAccount"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) LinkGameCenterAccount:(LinkGameCenterAccountRequest*)request success:(LinkGameCenterAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[LinkGameCenterAccountRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LinkGameCenterAccountResult *model = [[LinkGameCenterAccountResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LinkGameCenterAccount"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) LinkGoogleAccount:(LinkGoogleAccountRequest*)request success:(LinkGoogleAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[LinkGoogleAccountRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LinkGoogleAccountResult *model = [[LinkGoogleAccountResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LinkGoogleAccount"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) LinkIOSDeviceID:(LinkIOSDeviceIDRequest*)request success:(LinkIOSDeviceIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[LinkIOSDeviceIDRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LinkIOSDeviceIDResult *model = [[LinkIOSDeviceIDResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LinkIOSDeviceID"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) LinkKongregate:(LinkKongregateAccountRequest*)request success:(LinkKongregateCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[LinkKongregateAccountRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LinkKongregateAccountResult *model = [[LinkKongregateAccountResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LinkKongregate"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) LinkSteamAccount:(LinkSteamAccountRequest*)request success:(LinkSteamAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[LinkSteamAccountRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LinkSteamAccountResult *model = [[LinkSteamAccountResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LinkSteamAccount"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) LinkTwitch:(LinkTwitchAccountRequest*)request success:(LinkTwitchCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[LinkTwitchAccountRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LinkTwitchAccountResult *model = [[LinkTwitchAccountResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LinkTwitch"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) LinkWindowsHello:(LinkWindowsHelloAccountRequest*)request success:(LinkWindowsHelloCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[LinkWindowsHelloAccountRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LinkWindowsHelloAccountResponse *model = [[LinkWindowsHelloAccountResponse new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LinkWindowsHello"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) LoginWithAndroidDeviceID:(LoginWithAndroidDeviceIDRequest*)request success:(LoginWithAndroidDeviceIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[LoginWithAndroidDeviceIDRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LoginWithAndroidDeviceID"] body:jsonString authType:nil authKey:nil];
}
-(void) LoginWithCustomID:(LoginWithCustomIDRequest*)request success:(LoginWithCustomIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[LoginWithCustomIDRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LoginWithCustomID"] body:jsonString authType:nil authKey:nil];
}
-(void) LoginWithEmailAddress:(LoginWithEmailAddressRequest*)request success:(LoginWithEmailAddressCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[LoginWithEmailAddressRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LoginWithEmailAddress"] body:jsonString authType:nil authKey:nil];
}
-(void) LoginWithFacebook:(LoginWithFacebookRequest*)request success:(LoginWithFacebookCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[LoginWithFacebookRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LoginWithFacebook"] body:jsonString authType:nil authKey:nil];
}
-(void) LoginWithGameCenter:(LoginWithGameCenterRequest*)request success:(LoginWithGameCenterCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[LoginWithGameCenterRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LoginWithGameCenter"] body:jsonString authType:nil authKey:nil];
}
-(void) LoginWithGoogleAccount:(LoginWithGoogleAccountRequest*)request success:(LoginWithGoogleAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[LoginWithGoogleAccountRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LoginWithGoogleAccount"] body:jsonString authType:nil authKey:nil];
}
-(void) LoginWithIOSDeviceID:(LoginWithIOSDeviceIDRequest*)request success:(LoginWithIOSDeviceIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;
//Get iOS device and os information:
NSOperatingSystemVersion version = [[NSProcessInfo processInfo] operatingSystemVersion];
request.OS = [NSString stringWithFormat:@"%d.%d.%d", version.majorVersion, version.minorVersion, version.patchVersion];
request.DeviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
request.DeviceModel = [PlayFabClientAPI getModel];

    
    NSString *jsonString = [request JSONStringWithClass:[LoginWithIOSDeviceIDRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LoginWithIOSDeviceID"] body:jsonString authType:nil authKey:nil];
}
-(void) LoginWithKongregate:(LoginWithKongregateRequest*)request success:(LoginWithKongregateCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[LoginWithKongregateRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LoginWithKongregate"] body:jsonString authType:nil authKey:nil];
}
-(void) LoginWithPlayFab:(LoginWithPlayFabRequest*)request success:(LoginWithPlayFabCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[LoginWithPlayFabRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LoginWithPlayFab"] body:jsonString authType:nil authKey:nil];
}
-(void) LoginWithSteam:(LoginWithSteamRequest*)request success:(LoginWithSteamCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[LoginWithSteamRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LoginWithSteam"] body:jsonString authType:nil authKey:nil];
}
-(void) LoginWithTwitch:(LoginWithTwitchRequest*)request success:(LoginWithTwitchCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[LoginWithTwitchRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LoginWithTwitch"] body:jsonString authType:nil authKey:nil];
}
-(void) LoginWithWindowsHello:(LoginWithWindowsHelloRequest*)request success:(LoginWithWindowsHelloCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[LoginWithWindowsHelloRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/LoginWithWindowsHello"] body:jsonString authType:nil authKey:nil];
}
-(void) Matchmake:(MatchmakeRequest*)request success:(MatchmakeCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[MatchmakeRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                MatchmakeResult *model = [[MatchmakeResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/Matchmake"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) OpenTrade:(OpenTradeRequest*)request success:(OpenTradeCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[OpenTradeRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                OpenTradeResponse *model = [[OpenTradeResponse new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/OpenTrade"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) PayForPurchase:(PayForPurchaseRequest*)request success:(PayForPurchaseCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[PayForPurchaseRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                PayForPurchaseResult *model = [[PayForPurchaseResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/PayForPurchase"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) PurchaseItem:(PurchaseItemRequest*)request success:(PurchaseItemCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[PurchaseItemRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                PurchaseItemResult *model = [[PurchaseItemResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/PurchaseItem"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) RedeemCoupon:(RedeemCouponRequest*)request success:(RedeemCouponCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[RedeemCouponRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                RedeemCouponResult *model = [[RedeemCouponResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/RedeemCoupon"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) RegisterForIOSPushNotification:(RegisterForIOSPushNotificationRequest*)request success:(RegisterForIOSPushNotificationCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[RegisterForIOSPushNotificationRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                RegisterForIOSPushNotificationResult *model = [[RegisterForIOSPushNotificationResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/RegisterForIOSPushNotification"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) RegisterPlayFabUser:(RegisterPlayFabUserRequest*)request success:(RegisterPlayFabUserCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[RegisterPlayFabUserRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                RegisterPlayFabUserResult *model = [[RegisterPlayFabUserResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/RegisterPlayFabUser"] body:jsonString authType:nil authKey:nil];
}
-(void) RegisterWithWindowsHello:(RegisterWithWindowsHelloRequest*)request success:(RegisterWithWindowsHelloCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    if ([PlayFabSettings.TitleId length] > 0)
        request.TitleId = PlayFabSettings.TitleId;

    
    NSString *jsonString = [request JSONStringWithClass:[RegisterWithWindowsHelloRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                LoginResult *model = [[LoginResult new] initWithDictionary:class_data];
                if ([class_data valueForKey:@"SessionTicket"])
            self.mUserSessionTicket = [class_data valueForKey:@"SessionTicket"];
#ifdef USE_IDFA
if(model.SettingsForUser.NeedsAttribution)
    [[PlayFabClientAPI GetInstance] MultiStepClientLogin:model.SettingsForUser.NeedsAttribution];
#endif

                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/RegisterWithWindowsHello"] body:jsonString authType:nil authKey:nil];
}
-(void) RemoveContactEmail:(RemoveContactEmailCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData
{
    
    
    NSString *jsonString = @"{}";
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                RemoveContactEmailResult *model = [[RemoveContactEmailResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/RemoveContactEmail"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) RemoveFriend:(RemoveFriendRequest*)request success:(RemoveFriendCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[RemoveFriendRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                RemoveFriendResult *model = [[RemoveFriendResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/RemoveFriend"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) RemoveGenericID:(RemoveGenericIDRequest*)request success:(RemoveGenericIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[RemoveGenericIDRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                RemoveGenericIDResult *model = [[RemoveGenericIDResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/RemoveGenericID"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) RemoveSharedGroupMembers:(RemoveSharedGroupMembersRequest*)request success:(RemoveSharedGroupMembersCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[RemoveSharedGroupMembersRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                RemoveSharedGroupMembersResult *model = [[RemoveSharedGroupMembersResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/RemoveSharedGroupMembers"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) ReportDeviceInfo:(DeviceInfoRequest*)request success:(ReportDeviceInfoCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[DeviceInfoRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                EmptyResult *model = [[EmptyResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/ReportDeviceInfo"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) ReportPlayer:(ReportPlayerClientRequest*)request success:(ReportPlayerCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[ReportPlayerClientRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                ReportPlayerClientResult *model = [[ReportPlayerClientResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/ReportPlayer"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) RestoreIOSPurchases:(RestoreIOSPurchasesRequest*)request success:(RestoreIOSPurchasesCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[RestoreIOSPurchasesRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                RestoreIOSPurchasesResult *model = [[RestoreIOSPurchasesResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/RestoreIOSPurchases"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) SendAccountRecoveryEmail:(SendAccountRecoveryEmailRequest*)request success:(SendAccountRecoveryEmailCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[SendAccountRecoveryEmailRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                SendAccountRecoveryEmailResult *model = [[SendAccountRecoveryEmailResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/SendAccountRecoveryEmail"] body:jsonString authType:nil authKey:nil];
}
-(void) SetFriendTags:(SetFriendTagsRequest*)request success:(SetFriendTagsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[SetFriendTagsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                SetFriendTagsResult *model = [[SetFriendTagsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/SetFriendTags"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) SetPlayerSecret:(SetPlayerSecretRequest*)request success:(SetPlayerSecretCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[SetPlayerSecretRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                SetPlayerSecretResult *model = [[SetPlayerSecretResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/SetPlayerSecret"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) StartGame:(StartGameRequest*)request success:(StartGameCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[StartGameRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                StartGameResult *model = [[StartGameResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/StartGame"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) StartPurchase:(StartPurchaseRequest*)request success:(StartPurchaseCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[StartPurchaseRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                StartPurchaseResult *model = [[StartPurchaseResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/StartPurchase"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) SubtractUserVirtualCurrency:(SubtractUserVirtualCurrencyRequest*)request success:(SubtractUserVirtualCurrencyCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[SubtractUserVirtualCurrencyRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                ModifyUserVirtualCurrencyResult *model = [[ModifyUserVirtualCurrencyResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/SubtractUserVirtualCurrency"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UnlinkAndroidDeviceID:(UnlinkAndroidDeviceIDRequest*)request success:(UnlinkAndroidDeviceIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UnlinkAndroidDeviceIDRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UnlinkAndroidDeviceIDResult *model = [[UnlinkAndroidDeviceIDResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UnlinkAndroidDeviceID"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UnlinkCustomID:(UnlinkCustomIDRequest*)request success:(UnlinkCustomIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UnlinkCustomIDRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UnlinkCustomIDResult *model = [[UnlinkCustomIDResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UnlinkCustomID"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UnlinkFacebookAccount:(UnlinkFacebookAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData
{
    
    
    NSString *jsonString = @"{}";
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UnlinkFacebookAccountResult *model = [[UnlinkFacebookAccountResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UnlinkFacebookAccount"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UnlinkGameCenterAccount:(UnlinkGameCenterAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData
{
    
    
    NSString *jsonString = @"{}";
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UnlinkGameCenterAccountResult *model = [[UnlinkGameCenterAccountResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UnlinkGameCenterAccount"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UnlinkGoogleAccount:(UnlinkGoogleAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData
{
    
    
    NSString *jsonString = @"{}";
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UnlinkGoogleAccountResult *model = [[UnlinkGoogleAccountResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UnlinkGoogleAccount"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UnlinkIOSDeviceID:(UnlinkIOSDeviceIDRequest*)request success:(UnlinkIOSDeviceIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UnlinkIOSDeviceIDRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UnlinkIOSDeviceIDResult *model = [[UnlinkIOSDeviceIDResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UnlinkIOSDeviceID"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UnlinkKongregate:(UnlinkKongregateCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData
{
    
    
    NSString *jsonString = @"{}";
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UnlinkKongregateAccountResult *model = [[UnlinkKongregateAccountResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UnlinkKongregate"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UnlinkSteamAccount:(UnlinkSteamAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData
{
    
    
    NSString *jsonString = @"{}";
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UnlinkSteamAccountResult *model = [[UnlinkSteamAccountResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UnlinkSteamAccount"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UnlinkTwitch:(UnlinkTwitchCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData
{
    
    
    NSString *jsonString = @"{}";
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UnlinkTwitchAccountResult *model = [[UnlinkTwitchAccountResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UnlinkTwitch"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UnlinkWindowsHello:(UnlinkWindowsHelloAccountRequest*)request success:(UnlinkWindowsHelloCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UnlinkWindowsHelloAccountRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UnlinkWindowsHelloAccountResponse *model = [[UnlinkWindowsHelloAccountResponse new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UnlinkWindowsHello"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UnlockContainerInstance:(UnlockContainerInstanceRequest*)request success:(UnlockContainerInstanceCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UnlockContainerInstanceRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UnlockContainerItemResult *model = [[UnlockContainerItemResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UnlockContainerInstance"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UnlockContainerItem:(UnlockContainerItemRequest*)request success:(UnlockContainerItemCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UnlockContainerItemRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UnlockContainerItemResult *model = [[UnlockContainerItemResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UnlockContainerItem"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UpdateAvatarUrl:(UpdateAvatarUrlRequest*)request success:(UpdateAvatarUrlCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UpdateAvatarUrlRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                EmptyResult *model = [[EmptyResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UpdateAvatarUrl"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UpdateCharacterData:(UpdateCharacterDataRequest*)request success:(UpdateCharacterDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UpdateCharacterDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UpdateCharacterDataResult *model = [[UpdateCharacterDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UpdateCharacterData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UpdateCharacterStatistics:(UpdateCharacterStatisticsRequest*)request success:(UpdateCharacterStatisticsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UpdateCharacterStatisticsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UpdateCharacterStatisticsResult *model = [[UpdateCharacterStatisticsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UpdateCharacterStatistics"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UpdatePlayerStatistics:(UpdatePlayerStatisticsRequest*)request success:(UpdatePlayerStatisticsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UpdatePlayerStatisticsRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UpdatePlayerStatisticsResult *model = [[UpdatePlayerStatisticsResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UpdatePlayerStatistics"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UpdateSharedGroupData:(UpdateSharedGroupDataRequest*)request success:(UpdateSharedGroupDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UpdateSharedGroupDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UpdateSharedGroupDataResult *model = [[UpdateSharedGroupDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UpdateSharedGroupData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UpdateUserData:(UpdateUserDataRequest*)request success:(UpdateUserDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UpdateUserDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UpdateUserDataResult *model = [[UpdateUserDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UpdateUserData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UpdateUserPublisherData:(UpdateUserDataRequest*)request success:(UpdateUserPublisherDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UpdateUserDataRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UpdateUserDataResult *model = [[UpdateUserDataResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UpdateUserPublisherData"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) UpdateUserTitleDisplayName:(UpdateUserTitleDisplayNameRequest*)request success:(UpdateUserTitleDisplayNameCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[UpdateUserTitleDisplayNameRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                UpdateUserTitleDisplayNameResult *model = [[UpdateUserTitleDisplayNameResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/UpdateUserTitleDisplayName"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) ValidateAmazonIAPReceipt:(ValidateAmazonReceiptRequest*)request success:(ValidateAmazonIAPReceiptCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[ValidateAmazonReceiptRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                ValidateAmazonReceiptResult *model = [[ValidateAmazonReceiptResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/ValidateAmazonIAPReceipt"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) ValidateGooglePlayPurchase:(ValidateGooglePlayPurchaseRequest*)request success:(ValidateGooglePlayPurchaseCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[ValidateGooglePlayPurchaseRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                ValidateGooglePlayPurchaseResult *model = [[ValidateGooglePlayPurchaseResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/ValidateGooglePlayPurchase"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) ValidateIOSReceipt:(ValidateIOSReceiptRequest*)request success:(ValidateIOSReceiptCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[ValidateIOSReceiptRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                ValidateIOSReceiptResult *model = [[ValidateIOSReceiptResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/ValidateIOSReceipt"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) ValidateWindowsStoreReceipt:(ValidateWindowsReceiptRequest*)request success:(ValidateWindowsStoreReceiptCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[ValidateWindowsReceiptRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                ValidateWindowsReceiptResult *model = [[ValidateWindowsReceiptResult new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/ValidateWindowsStoreReceipt"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) WriteCharacterEvent:(WriteClientCharacterEventRequest*)request success:(WriteCharacterEventCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[WriteClientCharacterEventRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                WriteEventResponse *model = [[WriteEventResponse new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/WriteCharacterEvent"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) WritePlayerEvent:(WriteClientPlayerEventRequest*)request success:(WritePlayerEventCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[WriteClientPlayerEventRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                WriteEventResponse *model = [[WriteEventResponse new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/WritePlayerEvent"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}
-(void) WriteTitleEvent:(WriteTitleEventRequest*)request success:(WriteTitleEventCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData
{
    
    
    NSString *jsonString = [request JSONStringWithClass:[WriteTitleEventRequest class]];
    
    PlayFabConnection * connection = [PlayFabConnection new];//[[MyConnection alloc]initWithRequest:req];
    [connection setCompletionBlock:^(id obj, NSError *err) {
        NSData * data = obj;
        if (!err) {
            //NSLog(@"connection success response: %@",(NSString*)data);
            NSError *e = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error: &e];

            NSString* playfab_error = [JSON valueForKey:@"error"];
            if (playfab_error != nil) {
                //if there was an "error" object in the JSON:
                PlayFabError *playfab_error_object = [[PlayFabError new] initWithDictionary:JSON];
                errorCallback (playfab_error_object, userData);
            } else {
                NSDictionary *class_data = [JSON valueForKey:@"data"];
                WriteEventResponse *model = [[WriteEventResponse new] initWithDictionary:class_data];
                
                callback (model, userData);
            }
        } else { //Connection Error:
            NSError *e = nil;
            NSLog(@"connection error response: %@",data);
            PlayFabError *model;
            if (data != nil) {
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
                JAGPropertyConverter *converter = [JAGPropertyConverter new];
                model = [converter composeModelFromObject:JSON];
            } else {
                model = [PlayFabError new];
                model.error = @"unknown, data empty.";
            }
        errorCallback (model, userData);
        }
    }];

    [connection postURL:[NSString stringWithFormat:@"%@%@",[PlayFabClientAPI GetURL],@"/Client/WriteTitleEvent"] body:jsonString authType:@"X-Authorization" authKey:self.mUserSessionTicket];
}

@end
