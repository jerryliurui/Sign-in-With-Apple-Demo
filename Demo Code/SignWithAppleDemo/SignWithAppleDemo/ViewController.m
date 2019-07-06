//
//  ViewController.m
//  SignWithAppleDemo
//
//  Created by JerryLiu on 2019/7/6.
//  Copyright © 2019 JerryLiu. All rights reserved.
//

#import "ViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "NTESNBAppleIDUser.h"
#import "NTESNBAppleSignManager.h"
#import <Masonry/Masonry.h>

@interface ViewController ()<ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic, strong) UILabel *orLabel;
@property (nonatomic, strong) UIButton *otherWaysToLoginBtn;

//different style
@property (nonatomic, strong) ASAuthorizationAppleIDButton *appleIDBtn1;
@property (nonatomic, strong) ASAuthorizationAppleIDButton *appleIDBtn2;
@property (nonatomic, strong) ASAuthorizationAppleIDButton *appleIDBtn3;
//different Auth Btn style
@property (nonatomic, strong) ASAuthorizationAppleIDButton *appleIDBtn4;
@property (nonatomic, strong) ASAuthorizationAppleIDButton *appleIDBtn5;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBaseViews];
}

- (void)setupBaseViews {
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.appleIDBtn1];
    [self.view addSubview:self.appleIDBtn2];
    [self.view addSubview:self.appleIDBtn3];
    [self.view addSubview:self.appleIDBtn4];
    [self.view addSubview:self.appleIDBtn5];
    [self.view addSubview:self.orLabel];
    [self.view addSubview:self.otherWaysToLoginBtn];
    
    [_appleIDBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(25);
        make.right.mas_equalTo(self.view).offset(-25);
        make.top.mas_equalTo(self.view).offset(200);
        make.height.mas_equalTo(40);
    }];
    
    [_appleIDBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(25);
        make.right.mas_equalTo(self.view).offset(-25);
        make.top.mas_equalTo(_appleIDBtn1.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    [_appleIDBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(25);
        make.right.mas_equalTo(self.view).offset(-25);
        make.top.mas_equalTo(_appleIDBtn2.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    [_appleIDBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(25);
        make.right.mas_equalTo(self.view).offset(-25);
        make.top.mas_equalTo(_appleIDBtn3.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    [_appleIDBtn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(25);
        make.right.mas_equalTo(self.view).offset(-25);
        make.top.mas_equalTo(_appleIDBtn4.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    [_orLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(_appleIDBtn5.mas_bottom).offset(15);
    }];
    
    [_otherWaysToLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(_orLabel.mas_bottom).offset(15);
    }];
    
}

- (UILabel *)orLabel {
    if (!_orLabel) {
        _orLabel = [UILabel new];
        _orLabel.numberOfLines = 1;
        _orLabel.textColor = [UIColor blackColor];
        [_orLabel setText:@"-OR-"];
    }
    
    return _orLabel;
}

- (UIButton *)otherWaysToLoginBtn {
    if (!_otherWaysToLoginBtn) {
        _otherWaysToLoginBtn = [UIButton new];
        _otherWaysToLoginBtn.exclusiveTouch = YES;
        [_otherWaysToLoginBtn addTarget:self action:@selector(changeStyleToAnotherWays) forControlEvents:UIControlEventTouchUpInside];
        _otherWaysToLoginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        [_otherWaysToLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_otherWaysToLoginBtn setTitle:@"使用其他方式登录" forState:UIControlStateNormal];
    }
    return _otherWaysToLoginBtn;
}

- (ASAuthorizationAppleIDButton *)appleIDBtn1 {
    if(!_appleIDBtn1) {
        _appleIDBtn1 = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeDefault authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhite];
        [_appleIDBtn1 addTarget:self action:@selector(handleAppleIDBtnClicked1) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _appleIDBtn1;
}

- (ASAuthorizationAppleIDButton *)appleIDBtn2 {
    if(!_appleIDBtn2) {
        _appleIDBtn2 = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeDefault authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhiteOutline];
        [_appleIDBtn2 addTarget:self action:@selector(handleAppleIDBtnClicked1) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _appleIDBtn2;
}

- (ASAuthorizationAppleIDButton *)appleIDBtn3 {
    if(!_appleIDBtn3) {
        _appleIDBtn3 = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeDefault authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleBlack];
        [_appleIDBtn3 addTarget:self action:@selector(handleAppleIDBtnClicked2) forControlEvents:UIControlEventTouchUpInside];
        [_appleIDBtn3 setCornerRadius:20];
    }
    
    return _appleIDBtn3;
}

- (ASAuthorizationAppleIDButton *)appleIDBtn4 {
    if(!_appleIDBtn4) {
        _appleIDBtn4 = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignUp authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleBlack];
        [_appleIDBtn4 addTarget:self action:@selector(handleAppleIDBtnClicked2) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _appleIDBtn4;
}

- (ASAuthorizationAppleIDButton *)appleIDBtn5 {
    if(!_appleIDBtn5) {
        _appleIDBtn5 = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeContinue authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleBlack];
        [_appleIDBtn5 addTarget:self action:@selector(handleAppleIDBtnClicked2) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _appleIDBtn5;
}

#pragma mark - Action

//只发送appleid request
- (void)handleAppleIDBtnClicked1 {
    ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
    ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
    [request setRequestedScopes:@[ASAuthorizationScopeFullName,ASAuthorizationScopeEmail]];
    
    ASAuthorizationController *appleSignController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
    appleSignController.delegate = self;
    appleSignController.presentationContextProvider = self;
    [appleSignController performRequests];
}

//appleID request + password request
- (void)handleAppleIDBtnClicked2 {
    ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
    ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
    [request setRequestedScopes:@[ASAuthorizationScopeFullName,ASAuthorizationScopeEmail]];
    
    //需要考虑已经登录过的用户，可以直接使用keychain密码来进行登录-这个很牛皮。。。
    ASAuthorizationPasswordProvider *appleIDPasswordProvider = [ASAuthorizationPasswordProvider new];
    ASAuthorizationPasswordRequest *passwordRequest = appleIDPasswordProvider.createRequest;
    
    ASAuthorizationController *appleSignController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request,passwordRequest]];
    appleSignController.delegate = self;
    appleSignController.presentationContextProvider = self;
    [appleSignController performRequests];
}

- (void)changeStyleToAnotherWays {
    
}

#pragma mark - ASAuthorizationControllerDelegate

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error {
    //Sign with Apple 失败
    
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization {
    
    if ([authorization.provider isKindOfClass:[ASAuthorizationPasswordProvider class]]) {
        //取的keychain中的用户名密码，这里可以直接登录了，然后返回正常的登录结果即可
        //此时并不是使用Sign with Apple
        ASPasswordCredential *passwordCredential = authorization.credential;
        if ([passwordCredential isKindOfClass:[ASPasswordCredential class]]) {
            NSString *userName = passwordCredential.user;
            NSString *password = passwordCredential.password;
            
            //直接使用邮箱登录
            
        }
        
    } else if ([authorization.provider isKindOfClass:[ASAuthorizationAppleIDProvider class]]) {
        //此时为使用Sign With Apple 方式登录
        NTESNBAppleIDUser *user = [NTESNBAppleIDUser new];
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        if ([credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
            NSString *tokenString = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
            
            NSString *authorizationCodeString = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding];
            
            NSString *userIdentifier = credential.user;
            NSString *email = credential.email;
            NSString *givenName = credential.fullName.givenName;
            NSString *familyName = credential.fullName.familyName;
            ASUserDetectionStatus realUserStatus = credential.realUserStatus;
            
            user.userIdentifier = userIdentifier;
            user.token = tokenString;
            user.authorizationCode = authorizationCodeString;
            user.email = email;
            user.realUserStatus = realUserStatus;
            user.givenName = givenName;
            user.familyName = familyName;
        }
        
        if ([user isVaildAppleUser]) {
            //苹果返回的模型正确，可以进一步向后台进行登录行为
            //需要给后台传userIdentifier、token、authorizationCode
            
            if (1) {
                [[NTESNBAppleSignManager sharedInstance] configLocalAppleUserWith:user];
                [[NTESNBAppleSignManager sharedInstance] saveLocalAppleUser];
            } else {
                //Sign with Apple 失败
            }
        } else {
            //Sign with Apple 失败
            
        }
    }
}

#pragma mark - ASAuthorizationControllerPresentationContextProviding

- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller {
    return self.view.window;
}

@end

