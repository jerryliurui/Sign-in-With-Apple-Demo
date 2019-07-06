//
//  NTESNBAppleSignManager.m
//  NTESNBLoginService
//
//  Created by JerryLiu on 2019/6/26.
//

#import "NTESNBAppleSignManager.h"
#import <AuthenticationServices/AuthenticationServices.h>

@implementation NTESNBAppleSignManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    __strong static id _sharedObject = nil;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAppleIdHasChanged) name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
        [self fetchLocalAppleUser];
    }
    
    return self;
}

#pragma mark - PrivateFunc

- (void)fetchLocalAppleUser {
    __weak typeof(self) ws = self;
    //取出本地缓存的AppleID User Model
}

#pragma mark - PublicFunc

- (void)checkAppleSignFunc {
    if (@available(iOS 13.0, *)) {
        if (![_appleUser isVaildAppleUser]) {
            return;
        }
        
        ASAuthorizationAppleIDProvider *provider = [ASAuthorizationAppleIDProvider new];
        [provider getCredentialStateForUserID:_appleUser.userIdentifier completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * _Nullable error) {
            switch (credentialState) {
                case ASAuthorizationAppleIDProviderCredentialRevoked:
                    //用户重新登录了其他的apple id
                    break;
                case ASAuthorizationAppleIDProviderCredentialAuthorized:
                    //该userid apple id 登录状态良好
                    break;
                case ASAuthorizationAppleIDProviderCredentialNotFound:
                    //该userid apple id 登录找不到
                    //用户在设置-appleid header-密码与安全性-使用您 Apple ID的App 中将网易新闻的禁止掉了
                    break;
                default:
                    
                    break;
            }
        }];
    }
}

- (void)handleAppleIdHasChanged {
    //退出登录
    
    //弹窗提示 “因为你的apple id 发生了切换，需要重新登录”
}

- (void)configLocalAppleUserWith:(NTESNBAppleIDUser *)appleUser {
    _appleUser = appleUser;
}

- (void)saveLocalAppleUser {
    if (_appleUser) {
        //保存获取到的本地Apple ID User
    }
}

@end
