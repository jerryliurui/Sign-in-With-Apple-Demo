//
//  NTESNBAppleSignManager.h
//  NTESNBLoginService
//
//  统一管理Sign with Apple 相关功能
//
//  Created by JerryLiu on 2019/6/26.
//

#import <Foundation/Foundation.h>
#import "NTESNBAppleIDUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface NTESNBAppleSignManager : NSObject

@property (nonatomic, assign) BOOL appleSignIsAvailable;
@property (nonatomic, strong) NTESNBAppleIDUser *appleUser;

+ (instancetype)sharedInstance;

/**
 每次客户端启动的时候需要检查
 
 如果是使用Apple Sign方式登录的用户，需要这个方法检查用户手机Apple ID登录状态
 其他登录方式就不需要用这种方式来进行检验了
 */
- (void)checkAppleSignFunc;

/**
 配置本地的appleuser
 
 @param appleUser 苹果返回的user模型
 */
- (void)configLocalAppleUserWith:(NTESNBAppleIDUser *)appleUser;

/**
 保存到本地
 
 Sign with Apple 成功之后保存
 */
- (void)saveLocalAppleUser;

@end

NS_ASSUME_NONNULL_END
