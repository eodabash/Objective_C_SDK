

#import <Foundation/Foundation.h>

#import "PlayFabClientDataModels.h"
#import "PlayFabError.h"
#import "PlayFabSettings.h"

@interface PlayFabClientAPI : NSObject

@property (nonatomic) NSString* mUserSessionTicket;

		
typedef void(^AcceptTradeCallback)(AcceptTradeResponse* result, NSObject* userData);
		
typedef void(^AddFriendCallback)(AddFriendResult* result, NSObject* userData);
		
typedef void(^AddGenericIDCallback)(AddGenericIDResult* result, NSObject* userData);
		
typedef void(^AddOrUpdateContactEmailCallback)(AddOrUpdateContactEmailResult* result, NSObject* userData);
		
typedef void(^AddSharedGroupMembersCallback)(AddSharedGroupMembersResult* result, NSObject* userData);
		
typedef void(^AddUsernamePasswordCallback)(AddUsernamePasswordResult* result, NSObject* userData);
		
typedef void(^AddUserVirtualCurrencyCallback)(ModifyUserVirtualCurrencyResult* result, NSObject* userData);
		
typedef void(^AndroidDevicePushNotificationRegistrationCallback)(AndroidDevicePushNotificationRegistrationResult* result, NSObject* userData);
		
typedef void(^AttributeInstallCallback)(AttributeInstallResult* result, NSObject* userData);
		
typedef void(^CancelTradeCallback)(CancelTradeResponse* result, NSObject* userData);
		
typedef void(^ConfirmPurchaseCallback)(ConfirmPurchaseResult* result, NSObject* userData);
		
typedef void(^ConsumeItemCallback)(ConsumeItemResult* result, NSObject* userData);
		
typedef void(^CreateSharedGroupCallback)(CreateSharedGroupResult* result, NSObject* userData);
		
typedef void(^ExecuteCloudScriptCallback)(ExecuteCloudScriptResult* result, NSObject* userData);
		
typedef void(^GetAccountInfoCallback)(GetAccountInfoResult* result, NSObject* userData);
		
typedef void(^GetAllUsersCharactersCallback)(ListUsersCharactersResult* result, NSObject* userData);
		
typedef void(^GetCatalogItemsCallback)(GetCatalogItemsResult* result, NSObject* userData);
		
typedef void(^GetCharacterDataCallback)(GetCharacterDataResult* result, NSObject* userData);
		
typedef void(^GetCharacterInventoryCallback)(GetCharacterInventoryResult* result, NSObject* userData);
		
typedef void(^GetCharacterLeaderboardCallback)(GetCharacterLeaderboardResult* result, NSObject* userData);
		
typedef void(^GetCharacterReadOnlyDataCallback)(GetCharacterDataResult* result, NSObject* userData);
		
typedef void(^GetCharacterStatisticsCallback)(GetCharacterStatisticsResult* result, NSObject* userData);
		
typedef void(^GetContentDownloadUrlCallback)(GetContentDownloadUrlResult* result, NSObject* userData);
		
typedef void(^GetCurrentGamesCallback)(CurrentGamesResult* result, NSObject* userData);
		
typedef void(^GetFriendLeaderboardCallback)(GetLeaderboardResult* result, NSObject* userData);
		
typedef void(^GetFriendLeaderboardAroundPlayerCallback)(GetFriendLeaderboardAroundPlayerResult* result, NSObject* userData);
		
typedef void(^GetFriendsListCallback)(GetFriendsListResult* result, NSObject* userData);
		
typedef void(^GetGameServerRegionsCallback)(GameServerRegionsResult* result, NSObject* userData);
		
typedef void(^GetLeaderboardCallback)(GetLeaderboardResult* result, NSObject* userData);
		
typedef void(^GetLeaderboardAroundCharacterCallback)(GetLeaderboardAroundCharacterResult* result, NSObject* userData);
		
typedef void(^GetLeaderboardAroundPlayerCallback)(GetLeaderboardAroundPlayerResult* result, NSObject* userData);
		
typedef void(^GetLeaderboardForUserCharactersCallback)(GetLeaderboardForUsersCharactersResult* result, NSObject* userData);
		
typedef void(^GetPaymentTokenCallback)(GetPaymentTokenResult* result, NSObject* userData);
		
typedef void(^GetPhotonAuthenticationTokenCallback)(GetPhotonAuthenticationTokenResult* result, NSObject* userData);
		
typedef void(^GetPlayerCombinedInfoCallback)(GetPlayerCombinedInfoResult* result, NSObject* userData);
		
typedef void(^GetPlayerProfileCallback)(GetPlayerProfileResult* result, NSObject* userData);
		
typedef void(^GetPlayerSegmentsCallback)(GetPlayerSegmentsResult* result, NSObject* userData);
		
typedef void(^GetPlayerStatisticsCallback)(GetPlayerStatisticsResult* result, NSObject* userData);
		
typedef void(^GetPlayerStatisticVersionsCallback)(GetPlayerStatisticVersionsResult* result, NSObject* userData);
		
typedef void(^GetPlayerTagsCallback)(GetPlayerTagsResult* result, NSObject* userData);
		
typedef void(^GetPlayerTradesCallback)(GetPlayerTradesResponse* result, NSObject* userData);
		
typedef void(^GetPlayFabIDsFromFacebookIDsCallback)(GetPlayFabIDsFromFacebookIDsResult* result, NSObject* userData);
		
typedef void(^GetPlayFabIDsFromGameCenterIDsCallback)(GetPlayFabIDsFromGameCenterIDsResult* result, NSObject* userData);
		
typedef void(^GetPlayFabIDsFromGenericIDsCallback)(GetPlayFabIDsFromGenericIDsResult* result, NSObject* userData);
		
typedef void(^GetPlayFabIDsFromGoogleIDsCallback)(GetPlayFabIDsFromGoogleIDsResult* result, NSObject* userData);
		
typedef void(^GetPlayFabIDsFromKongregateIDsCallback)(GetPlayFabIDsFromKongregateIDsResult* result, NSObject* userData);
		
typedef void(^GetPlayFabIDsFromSteamIDsCallback)(GetPlayFabIDsFromSteamIDsResult* result, NSObject* userData);
		
typedef void(^GetPlayFabIDsFromTwitchIDsCallback)(GetPlayFabIDsFromTwitchIDsResult* result, NSObject* userData);
		
typedef void(^GetPublisherDataCallback)(GetPublisherDataResult* result, NSObject* userData);
		
typedef void(^GetPurchaseCallback)(GetPurchaseResult* result, NSObject* userData);
		
typedef void(^GetSharedGroupDataCallback)(GetSharedGroupDataResult* result, NSObject* userData);
		
typedef void(^GetStoreItemsCallback)(GetStoreItemsResult* result, NSObject* userData);
		
typedef void(^GetTimeCallback)(GetTimeResult* result, NSObject* userData);
		
typedef void(^GetTitleDataCallback)(GetTitleDataResult* result, NSObject* userData);
		
typedef void(^GetTitleNewsCallback)(GetTitleNewsResult* result, NSObject* userData);
		
typedef void(^GetTitlePublicKeyCallback)(GetTitlePublicKeyResult* result, NSObject* userData);
		
typedef void(^GetTradeStatusCallback)(GetTradeStatusResponse* result, NSObject* userData);
		
typedef void(^GetUserDataCallback)(GetUserDataResult* result, NSObject* userData);
		
typedef void(^GetUserInventoryCallback)(GetUserInventoryResult* result, NSObject* userData);
		
typedef void(^GetUserPublisherDataCallback)(GetUserDataResult* result, NSObject* userData);
		
typedef void(^GetUserPublisherReadOnlyDataCallback)(GetUserDataResult* result, NSObject* userData);
		
typedef void(^GetUserReadOnlyDataCallback)(GetUserDataResult* result, NSObject* userData);
		
typedef void(^GetWindowsHelloChallengeCallback)(GetWindowsHelloChallengeResponse* result, NSObject* userData);
		
typedef void(^GrantCharacterToUserCallback)(GrantCharacterToUserResult* result, NSObject* userData);
		
typedef void(^LinkAndroidDeviceIDCallback)(LinkAndroidDeviceIDResult* result, NSObject* userData);
		
typedef void(^LinkCustomIDCallback)(LinkCustomIDResult* result, NSObject* userData);
		
typedef void(^LinkFacebookAccountCallback)(LinkFacebookAccountResult* result, NSObject* userData);
		
typedef void(^LinkGameCenterAccountCallback)(LinkGameCenterAccountResult* result, NSObject* userData);
		
typedef void(^LinkGoogleAccountCallback)(LinkGoogleAccountResult* result, NSObject* userData);
		
typedef void(^LinkIOSDeviceIDCallback)(LinkIOSDeviceIDResult* result, NSObject* userData);
		
typedef void(^LinkKongregateCallback)(LinkKongregateAccountResult* result, NSObject* userData);
		
typedef void(^LinkSteamAccountCallback)(LinkSteamAccountResult* result, NSObject* userData);
		
typedef void(^LinkTwitchCallback)(LinkTwitchAccountResult* result, NSObject* userData);
		
typedef void(^LinkWindowsHelloCallback)(LinkWindowsHelloAccountResponse* result, NSObject* userData);
		
typedef void(^LoginWithAndroidDeviceIDCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^LoginWithCustomIDCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^LoginWithEmailAddressCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^LoginWithFacebookCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^LoginWithGameCenterCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^LoginWithGoogleAccountCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^LoginWithIOSDeviceIDCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^LoginWithKongregateCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^LoginWithPlayFabCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^LoginWithSteamCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^LoginWithTwitchCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^LoginWithWindowsHelloCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^MatchmakeCallback)(MatchmakeResult* result, NSObject* userData);
		
typedef void(^OpenTradeCallback)(OpenTradeResponse* result, NSObject* userData);
		
typedef void(^PayForPurchaseCallback)(PayForPurchaseResult* result, NSObject* userData);
		
typedef void(^PurchaseItemCallback)(PurchaseItemResult* result, NSObject* userData);
		
typedef void(^RedeemCouponCallback)(RedeemCouponResult* result, NSObject* userData);
		
typedef void(^RegisterForIOSPushNotificationCallback)(RegisterForIOSPushNotificationResult* result, NSObject* userData);
		
typedef void(^RegisterPlayFabUserCallback)(RegisterPlayFabUserResult* result, NSObject* userData);
		
typedef void(^RegisterWithWindowsHelloCallback)(LoginResult* result, NSObject* userData);
		
typedef void(^RemoveContactEmailCallback)(RemoveContactEmailResult* result, NSObject* userData);
		
typedef void(^RemoveFriendCallback)(RemoveFriendResult* result, NSObject* userData);
		
typedef void(^RemoveGenericIDCallback)(RemoveGenericIDResult* result, NSObject* userData);
		
typedef void(^RemoveSharedGroupMembersCallback)(RemoveSharedGroupMembersResult* result, NSObject* userData);
		
typedef void(^ReportDeviceInfoCallback)(EmptyResult* result, NSObject* userData);
		
typedef void(^ReportPlayerCallback)(ReportPlayerClientResult* result, NSObject* userData);
		
typedef void(^RestoreIOSPurchasesCallback)(RestoreIOSPurchasesResult* result, NSObject* userData);
		
typedef void(^SendAccountRecoveryEmailCallback)(SendAccountRecoveryEmailResult* result, NSObject* userData);
		
typedef void(^SetFriendTagsCallback)(SetFriendTagsResult* result, NSObject* userData);
		
typedef void(^SetPlayerSecretCallback)(SetPlayerSecretResult* result, NSObject* userData);
		
typedef void(^StartGameCallback)(StartGameResult* result, NSObject* userData);
		
typedef void(^StartPurchaseCallback)(StartPurchaseResult* result, NSObject* userData);
		
typedef void(^SubtractUserVirtualCurrencyCallback)(ModifyUserVirtualCurrencyResult* result, NSObject* userData);
		
typedef void(^UnlinkAndroidDeviceIDCallback)(UnlinkAndroidDeviceIDResult* result, NSObject* userData);
		
typedef void(^UnlinkCustomIDCallback)(UnlinkCustomIDResult* result, NSObject* userData);
		
typedef void(^UnlinkFacebookAccountCallback)(UnlinkFacebookAccountResult* result, NSObject* userData);
		
typedef void(^UnlinkGameCenterAccountCallback)(UnlinkGameCenterAccountResult* result, NSObject* userData);
		
typedef void(^UnlinkGoogleAccountCallback)(UnlinkGoogleAccountResult* result, NSObject* userData);
		
typedef void(^UnlinkIOSDeviceIDCallback)(UnlinkIOSDeviceIDResult* result, NSObject* userData);
		
typedef void(^UnlinkKongregateCallback)(UnlinkKongregateAccountResult* result, NSObject* userData);
		
typedef void(^UnlinkSteamAccountCallback)(UnlinkSteamAccountResult* result, NSObject* userData);
		
typedef void(^UnlinkTwitchCallback)(UnlinkTwitchAccountResult* result, NSObject* userData);
		
typedef void(^UnlinkWindowsHelloCallback)(UnlinkWindowsHelloAccountResponse* result, NSObject* userData);
		
typedef void(^UnlockContainerInstanceCallback)(UnlockContainerItemResult* result, NSObject* userData);
		
typedef void(^UnlockContainerItemCallback)(UnlockContainerItemResult* result, NSObject* userData);
		
typedef void(^UpdateAvatarUrlCallback)(EmptyResult* result, NSObject* userData);
		
typedef void(^UpdateCharacterDataCallback)(UpdateCharacterDataResult* result, NSObject* userData);
		
typedef void(^UpdateCharacterStatisticsCallback)(UpdateCharacterStatisticsResult* result, NSObject* userData);
		
typedef void(^UpdatePlayerStatisticsCallback)(UpdatePlayerStatisticsResult* result, NSObject* userData);
		
typedef void(^UpdateSharedGroupDataCallback)(UpdateSharedGroupDataResult* result, NSObject* userData);
		
typedef void(^UpdateUserDataCallback)(UpdateUserDataResult* result, NSObject* userData);
		
typedef void(^UpdateUserPublisherDataCallback)(UpdateUserDataResult* result, NSObject* userData);
		
typedef void(^UpdateUserTitleDisplayNameCallback)(UpdateUserTitleDisplayNameResult* result, NSObject* userData);
		
typedef void(^ValidateAmazonIAPReceiptCallback)(ValidateAmazonReceiptResult* result, NSObject* userData);
		
typedef void(^ValidateGooglePlayPurchaseCallback)(ValidateGooglePlayPurchaseResult* result, NSObject* userData);
		
typedef void(^ValidateIOSReceiptCallback)(ValidateIOSReceiptResult* result, NSObject* userData);
		
typedef void(^ValidateWindowsStoreReceiptCallback)(ValidateWindowsReceiptResult* result, NSObject* userData);
		
typedef void(^WriteCharacterEventCallback)(WriteEventResponse* result, NSObject* userData);
		
typedef void(^WritePlayerEventCallback)(WriteEventResponse* result, NSObject* userData);
		
typedef void(^WriteTitleEventCallback)(WriteEventResponse* result, NSObject* userData);
		

+ (PlayFabClientAPI*) GetInstance;

		+(bool) IsClientLoggedIn;


        // ------------ Generated API calls
		
-(void) AcceptTrade:(AcceptTradeRequest*)request success:(AcceptTradeCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) AddFriend:(AddFriendRequest*)request success:(AddFriendCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) AddGenericID:(AddGenericIDRequest*)request success:(AddGenericIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) AddOrUpdateContactEmail:(AddOrUpdateContactEmailRequest*)request success:(AddOrUpdateContactEmailCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) AddSharedGroupMembers:(AddSharedGroupMembersRequest*)request success:(AddSharedGroupMembersCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) AddUsernamePassword:(AddUsernamePasswordRequest*)request success:(AddUsernamePasswordCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) AddUserVirtualCurrency:(AddUserVirtualCurrencyRequest*)request success:(AddUserVirtualCurrencyCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) AndroidDevicePushNotificationRegistration:(AndroidDevicePushNotificationRegistrationRequest*)request success:(AndroidDevicePushNotificationRegistrationCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) AttributeInstall:(AttributeInstallRequest*)request success:(AttributeInstallCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) CancelTrade:(CancelTradeRequest*)request success:(CancelTradeCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) ConfirmPurchase:(ConfirmPurchaseRequest*)request success:(ConfirmPurchaseCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) ConsumeItem:(ConsumeItemRequest*)request success:(ConsumeItemCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) CreateSharedGroup:(CreateSharedGroupRequest*)request success:(CreateSharedGroupCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) ExecuteCloudScript:(ExecuteCloudScriptRequest*)request success:(ExecuteCloudScriptCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetAccountInfo:(GetAccountInfoRequest*)request success:(GetAccountInfoCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetAllUsersCharacters:(ListUsersCharactersRequest*)request success:(GetAllUsersCharactersCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetCatalogItems:(GetCatalogItemsRequest*)request success:(GetCatalogItemsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetCharacterData:(GetCharacterDataRequest*)request success:(GetCharacterDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetCharacterInventory:(GetCharacterInventoryRequest*)request success:(GetCharacterInventoryCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetCharacterLeaderboard:(GetCharacterLeaderboardRequest*)request success:(GetCharacterLeaderboardCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetCharacterReadOnlyData:(GetCharacterDataRequest*)request success:(GetCharacterReadOnlyDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetCharacterStatistics:(GetCharacterStatisticsRequest*)request success:(GetCharacterStatisticsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetContentDownloadUrl:(GetContentDownloadUrlRequest*)request success:(GetContentDownloadUrlCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetCurrentGames:(CurrentGamesRequest*)request success:(GetCurrentGamesCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetFriendLeaderboard:(GetFriendLeaderboardRequest*)request success:(GetFriendLeaderboardCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetFriendLeaderboardAroundPlayer:(GetFriendLeaderboardAroundPlayerRequest*)request success:(GetFriendLeaderboardAroundPlayerCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetFriendsList:(GetFriendsListRequest*)request success:(GetFriendsListCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetGameServerRegions:(GameServerRegionsRequest*)request success:(GetGameServerRegionsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetLeaderboard:(GetLeaderboardRequest*)request success:(GetLeaderboardCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetLeaderboardAroundCharacter:(GetLeaderboardAroundCharacterRequest*)request success:(GetLeaderboardAroundCharacterCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetLeaderboardAroundPlayer:(GetLeaderboardAroundPlayerRequest*)request success:(GetLeaderboardAroundPlayerCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetLeaderboardForUserCharacters:(GetLeaderboardForUsersCharactersRequest*)request success:(GetLeaderboardForUserCharactersCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPaymentToken:(GetPaymentTokenRequest*)request success:(GetPaymentTokenCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPhotonAuthenticationToken:(GetPhotonAuthenticationTokenRequest*)request success:(GetPhotonAuthenticationTokenCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayerCombinedInfo:(GetPlayerCombinedInfoRequest*)request success:(GetPlayerCombinedInfoCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayerProfile:(GetPlayerProfileRequest*)request success:(GetPlayerProfileCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayerSegments:(GetPlayerSegmentsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData;
		
-(void) GetPlayerStatistics:(GetPlayerStatisticsRequest*)request success:(GetPlayerStatisticsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayerStatisticVersions:(GetPlayerStatisticVersionsRequest*)request success:(GetPlayerStatisticVersionsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayerTags:(GetPlayerTagsRequest*)request success:(GetPlayerTagsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayerTrades:(GetPlayerTradesRequest*)request success:(GetPlayerTradesCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayFabIDsFromFacebookIDs:(GetPlayFabIDsFromFacebookIDsRequest*)request success:(GetPlayFabIDsFromFacebookIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayFabIDsFromGameCenterIDs:(GetPlayFabIDsFromGameCenterIDsRequest*)request success:(GetPlayFabIDsFromGameCenterIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayFabIDsFromGenericIDs:(GetPlayFabIDsFromGenericIDsRequest*)request success:(GetPlayFabIDsFromGenericIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayFabIDsFromGoogleIDs:(GetPlayFabIDsFromGoogleIDsRequest*)request success:(GetPlayFabIDsFromGoogleIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayFabIDsFromKongregateIDs:(GetPlayFabIDsFromKongregateIDsRequest*)request success:(GetPlayFabIDsFromKongregateIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayFabIDsFromSteamIDs:(GetPlayFabIDsFromSteamIDsRequest*)request success:(GetPlayFabIDsFromSteamIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPlayFabIDsFromTwitchIDs:(GetPlayFabIDsFromTwitchIDsRequest*)request success:(GetPlayFabIDsFromTwitchIDsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPublisherData:(GetPublisherDataRequest*)request success:(GetPublisherDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetPurchase:(GetPurchaseRequest*)request success:(GetPurchaseCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetSharedGroupData:(GetSharedGroupDataRequest*)request success:(GetSharedGroupDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetStoreItems:(GetStoreItemsRequest*)request success:(GetStoreItemsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetTime:(GetTimeCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData;
		
-(void) GetTitleData:(GetTitleDataRequest*)request success:(GetTitleDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetTitleNews:(GetTitleNewsRequest*)request success:(GetTitleNewsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetTitlePublicKey:(GetTitlePublicKeyRequest*)request success:(GetTitlePublicKeyCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetTradeStatus:(GetTradeStatusRequest*)request success:(GetTradeStatusCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetUserData:(GetUserDataRequest*)request success:(GetUserDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetUserInventory:(GetUserInventoryCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData;
		
-(void) GetUserPublisherData:(GetUserDataRequest*)request success:(GetUserPublisherDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetUserPublisherReadOnlyData:(GetUserDataRequest*)request success:(GetUserPublisherReadOnlyDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetUserReadOnlyData:(GetUserDataRequest*)request success:(GetUserReadOnlyDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetWindowsHelloChallenge:(GetWindowsHelloChallengeRequest*)request success:(GetWindowsHelloChallengeCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GrantCharacterToUser:(GrantCharacterToUserRequest*)request success:(GrantCharacterToUserCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LinkAndroidDeviceID:(LinkAndroidDeviceIDRequest*)request success:(LinkAndroidDeviceIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LinkCustomID:(LinkCustomIDRequest*)request success:(LinkCustomIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LinkFacebookAccount:(LinkFacebookAccountRequest*)request success:(LinkFacebookAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LinkGameCenterAccount:(LinkGameCenterAccountRequest*)request success:(LinkGameCenterAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LinkGoogleAccount:(LinkGoogleAccountRequest*)request success:(LinkGoogleAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LinkIOSDeviceID:(LinkIOSDeviceIDRequest*)request success:(LinkIOSDeviceIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LinkKongregate:(LinkKongregateAccountRequest*)request success:(LinkKongregateCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LinkSteamAccount:(LinkSteamAccountRequest*)request success:(LinkSteamAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LinkTwitch:(LinkTwitchAccountRequest*)request success:(LinkTwitchCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LinkWindowsHello:(LinkWindowsHelloAccountRequest*)request success:(LinkWindowsHelloCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LoginWithAndroidDeviceID:(LoginWithAndroidDeviceIDRequest*)request success:(LoginWithAndroidDeviceIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LoginWithCustomID:(LoginWithCustomIDRequest*)request success:(LoginWithCustomIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LoginWithEmailAddress:(LoginWithEmailAddressRequest*)request success:(LoginWithEmailAddressCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LoginWithFacebook:(LoginWithFacebookRequest*)request success:(LoginWithFacebookCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LoginWithGameCenter:(LoginWithGameCenterRequest*)request success:(LoginWithGameCenterCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LoginWithGoogleAccount:(LoginWithGoogleAccountRequest*)request success:(LoginWithGoogleAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LoginWithIOSDeviceID:(LoginWithIOSDeviceIDRequest*)request success:(LoginWithIOSDeviceIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LoginWithKongregate:(LoginWithKongregateRequest*)request success:(LoginWithKongregateCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LoginWithPlayFab:(LoginWithPlayFabRequest*)request success:(LoginWithPlayFabCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LoginWithSteam:(LoginWithSteamRequest*)request success:(LoginWithSteamCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LoginWithTwitch:(LoginWithTwitchRequest*)request success:(LoginWithTwitchCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) LoginWithWindowsHello:(LoginWithWindowsHelloRequest*)request success:(LoginWithWindowsHelloCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) Matchmake:(MatchmakeRequest*)request success:(MatchmakeCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) OpenTrade:(OpenTradeRequest*)request success:(OpenTradeCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) PayForPurchase:(PayForPurchaseRequest*)request success:(PayForPurchaseCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) PurchaseItem:(PurchaseItemRequest*)request success:(PurchaseItemCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) RedeemCoupon:(RedeemCouponRequest*)request success:(RedeemCouponCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) RegisterForIOSPushNotification:(RegisterForIOSPushNotificationRequest*)request success:(RegisterForIOSPushNotificationCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) RegisterPlayFabUser:(RegisterPlayFabUserRequest*)request success:(RegisterPlayFabUserCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) RegisterWithWindowsHello:(RegisterWithWindowsHelloRequest*)request success:(RegisterWithWindowsHelloCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) RemoveContactEmail:(RemoveContactEmailCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData;
		
-(void) RemoveFriend:(RemoveFriendRequest*)request success:(RemoveFriendCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) RemoveGenericID:(RemoveGenericIDRequest*)request success:(RemoveGenericIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) RemoveSharedGroupMembers:(RemoveSharedGroupMembersRequest*)request success:(RemoveSharedGroupMembersCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) ReportDeviceInfo:(DeviceInfoRequest*)request success:(ReportDeviceInfoCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) ReportPlayer:(ReportPlayerClientRequest*)request success:(ReportPlayerCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) RestoreIOSPurchases:(RestoreIOSPurchasesRequest*)request success:(RestoreIOSPurchasesCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) SendAccountRecoveryEmail:(SendAccountRecoveryEmailRequest*)request success:(SendAccountRecoveryEmailCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) SetFriendTags:(SetFriendTagsRequest*)request success:(SetFriendTagsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) SetPlayerSecret:(SetPlayerSecretRequest*)request success:(SetPlayerSecretCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) StartGame:(StartGameRequest*)request success:(StartGameCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) StartPurchase:(StartPurchaseRequest*)request success:(StartPurchaseCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) SubtractUserVirtualCurrency:(SubtractUserVirtualCurrencyRequest*)request success:(SubtractUserVirtualCurrencyCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UnlinkAndroidDeviceID:(UnlinkAndroidDeviceIDRequest*)request success:(UnlinkAndroidDeviceIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UnlinkCustomID:(UnlinkCustomIDRequest*)request success:(UnlinkCustomIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UnlinkFacebookAccount:(UnlinkFacebookAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData;
		
-(void) UnlinkGameCenterAccount:(UnlinkGameCenterAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData;
		
-(void) UnlinkGoogleAccount:(UnlinkGoogleAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData;
		
-(void) UnlinkIOSDeviceID:(UnlinkIOSDeviceIDRequest*)request success:(UnlinkIOSDeviceIDCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UnlinkKongregate:(UnlinkKongregateCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData;
		
-(void) UnlinkSteamAccount:(UnlinkSteamAccountCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData;
		
-(void) UnlinkTwitch:(UnlinkTwitchCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*) userData;
		
-(void) UnlinkWindowsHello:(UnlinkWindowsHelloAccountRequest*)request success:(UnlinkWindowsHelloCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UnlockContainerInstance:(UnlockContainerInstanceRequest*)request success:(UnlockContainerInstanceCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UnlockContainerItem:(UnlockContainerItemRequest*)request success:(UnlockContainerItemCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UpdateAvatarUrl:(UpdateAvatarUrlRequest*)request success:(UpdateAvatarUrlCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UpdateCharacterData:(UpdateCharacterDataRequest*)request success:(UpdateCharacterDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UpdateCharacterStatistics:(UpdateCharacterStatisticsRequest*)request success:(UpdateCharacterStatisticsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UpdatePlayerStatistics:(UpdatePlayerStatisticsRequest*)request success:(UpdatePlayerStatisticsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UpdateSharedGroupData:(UpdateSharedGroupDataRequest*)request success:(UpdateSharedGroupDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UpdateUserData:(UpdateUserDataRequest*)request success:(UpdateUserDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UpdateUserPublisherData:(UpdateUserDataRequest*)request success:(UpdateUserPublisherDataCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UpdateUserTitleDisplayName:(UpdateUserTitleDisplayNameRequest*)request success:(UpdateUserTitleDisplayNameCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) ValidateAmazonIAPReceipt:(ValidateAmazonReceiptRequest*)request success:(ValidateAmazonIAPReceiptCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) ValidateGooglePlayPurchase:(ValidateGooglePlayPurchaseRequest*)request success:(ValidateGooglePlayPurchaseCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) ValidateIOSReceipt:(ValidateIOSReceiptRequest*)request success:(ValidateIOSReceiptCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) ValidateWindowsStoreReceipt:(ValidateWindowsReceiptRequest*)request success:(ValidateWindowsStoreReceiptCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) WriteCharacterEvent:(WriteClientCharacterEventRequest*)request success:(WriteCharacterEventCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) WritePlayerEvent:(WriteClientPlayerEventRequest*)request success:(WritePlayerEventCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) WriteTitleEvent:(WriteTitleEventRequest*)request success:(WriteTitleEventCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		

    //private:
/*
        // ------------ Generated result handlers
		
+ (void) OnAcceptTradeResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnAddFriendResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnAddGenericIDResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnAddOrUpdateContactEmailResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnAddSharedGroupMembersResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnAddUsernamePasswordResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnAddUserVirtualCurrencyResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnAndroidDevicePushNotificationRegistrationResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnAttributeInstallResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnCancelTradeResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnConfirmPurchaseResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnConsumeItemResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnCreateSharedGroupResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnExecuteCloudScriptResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetAccountInfoResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetAllUsersCharactersResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetCatalogItemsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetCharacterDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetCharacterInventoryResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetCharacterLeaderboardResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetCharacterReadOnlyDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetCharacterStatisticsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetContentDownloadUrlResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetCurrentGamesResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetFriendLeaderboardResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetFriendLeaderboardAroundPlayerResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetFriendsListResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetGameServerRegionsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetLeaderboardResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetLeaderboardAroundCharacterResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetLeaderboardAroundPlayerResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetLeaderboardForUserCharactersResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPaymentTokenResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPhotonAuthenticationTokenResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayerCombinedInfoResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayerProfileResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayerSegmentsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayerStatisticsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayerStatisticVersionsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayerTagsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayerTradesResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayFabIDsFromFacebookIDsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayFabIDsFromGameCenterIDsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayFabIDsFromGenericIDsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayFabIDsFromGoogleIDsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayFabIDsFromKongregateIDsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayFabIDsFromSteamIDsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPlayFabIDsFromTwitchIDsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPublisherDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetPurchaseResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetSharedGroupDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetStoreItemsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetTimeResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetTitleDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetTitleNewsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetTitlePublicKeyResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetTradeStatusResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetUserDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetUserInventoryResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetUserPublisherDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetUserPublisherReadOnlyDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetUserReadOnlyDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGetWindowsHelloChallengeResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnGrantCharacterToUserResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLinkAndroidDeviceIDResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLinkCustomIDResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLinkFacebookAccountResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLinkGameCenterAccountResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLinkGoogleAccountResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLinkIOSDeviceIDResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLinkKongregateResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLinkSteamAccountResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLinkTwitchResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLinkWindowsHelloResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLoginWithAndroidDeviceIDResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLoginWithCustomIDResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLoginWithEmailAddressResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLoginWithFacebookResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLoginWithGameCenterResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLoginWithGoogleAccountResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLoginWithIOSDeviceIDResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLoginWithKongregateResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLoginWithPlayFabResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLoginWithSteamResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLoginWithTwitchResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnLoginWithWindowsHelloResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnMatchmakeResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnOpenTradeResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnPayForPurchaseResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnPurchaseItemResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnRedeemCouponResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnRegisterForIOSPushNotificationResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnRegisterPlayFabUserResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnRegisterWithWindowsHelloResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnRemoveContactEmailResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnRemoveFriendResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnRemoveGenericIDResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnRemoveSharedGroupMembersResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnReportDeviceInfoResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnReportPlayerResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnRestoreIOSPurchasesResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnSendAccountRecoveryEmailResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnSetFriendTagsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnSetPlayerSecretResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnStartGameResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnStartPurchaseResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnSubtractUserVirtualCurrencyResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUnlinkAndroidDeviceIDResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUnlinkCustomIDResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUnlinkFacebookAccountResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUnlinkGameCenterAccountResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUnlinkGoogleAccountResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUnlinkIOSDeviceIDResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUnlinkKongregateResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUnlinkSteamAccountResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUnlinkTwitchResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUnlinkWindowsHelloResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUnlockContainerInstanceResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUnlockContainerItemResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUpdateAvatarUrlResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUpdateCharacterDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUpdateCharacterStatisticsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUpdatePlayerStatisticsResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUpdateSharedGroupDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUpdateUserDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUpdateUserPublisherDataResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnUpdateUserTitleDisplayNameResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnValidateAmazonIAPReceiptResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnValidateGooglePlayPurchaseResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnValidateIOSReceiptResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnValidateWindowsStoreReceiptResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnWriteCharacterEventResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnWritePlayerEventResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
+ (void) OnWriteTitleEventResult:(int)httpStatus withRequest:(HttpRequest*) request withUserData:(void*) userData;
		
 */

        //@property bool mOwnsRequester;
        //@property AFHTTPClient* mHttpRequester;


@end
