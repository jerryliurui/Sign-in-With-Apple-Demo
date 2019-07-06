//
//  NTESNBAppleIDUser.m
//  NTESNBLoginService
//
//  Created by JerryLiu on 2019/6/27.
//

#import "NTESNBAppleIDUser.h"

@implementation NTESNBAppleIDUser

- (BOOL)isVaildAppleUser {
    if (_realUserStatus != ASUserDetectionStatusLikelyReal) {
        return NO;
    }
    
    if (!_token ||
        !_authorizationCode ||
        !_userIdentifier) {
        return NO;
    }
    
    return YES;
}

@end
