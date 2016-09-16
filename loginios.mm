#include "facebook.h"
#include "google.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <UIKit/UIKit.h>

@interface QIOSApplicationDelegate
    : UIResponder <UIApplicationDelegate, GIDSignInDelegate,
                   GIDSignInUIDelegate>
@end
@interface QIOSApplicationDelegate (QFacebookApplicationDelegate)
@end
@implementation QIOSApplicationDelegate (QFacebookApplicationDelegate)
- (BOOL)application:(UIApplication*)application
              openURL:(NSURL*)url
    sourceApplication:(NSString*)sourceApplication
           annotation:(id)annotation {
  BOOL fb =
      [[FBSDKApplicationDelegate sharedInstance] application:application
                                                     openURL:url
                                           sourceApplication:sourceApplication
                                                  annotation:annotation];

  BOOL gg = [[GIDSignIn sharedInstance] handleURL:url
                                sourceApplication:sourceApplication
                                       annotation:annotation];

  return fb && gg;
}

Google* g_google = nullptr;

- (BOOL)application:(UIApplication*)application
    didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {

  [[FBSDKApplicationDelegate sharedInstance] application:application
                           didFinishLaunchingWithOptions:launchOptions];

  [GIDSignIn sharedInstance].delegate = self;
  [GIDSignIn sharedInstance].uiDelegate = self;
  return YES;
}

- (void)signIn:(GIDSignIn*)signIn
    didSignInForUser:(GIDGoogleUser*)user
           withError:(NSError*)error {
  (void)signIn;

  if (error) {
    QString what = "Google::login failed: ";
    what += QString::fromNSString([error localizedDescription]);
    emit g_google->error(what);
  } else {
    NSString* token = user.authentication.idToken;
    if (g_google) {
      emit g_google->tokenReady(QString::fromNSString(token));
    }
  }
}

- (void)signIn:(GIDSignIn*)signIn
    didDisconnectWithUser:(GIDGoogleUser*)user
                withError:(NSError*)error {
  (void)signIn;
  (void)user;
  (void)error;
}

- (void)signIn:(GIDSignIn*)signIn
    presentViewController:(UIViewController*)viewController {
  (void)signIn;
  UIViewController* root =
      [[UIApplication sharedApplication].keyWindow rootViewController];
  [root presentViewController:viewController animated:YES completion:nil];
}

- (void)signIn:(GIDSignIn*)signIn
    dismissViewController:(UIViewController*)viewController {
  (void)signIn;
  (void)viewController;
  UIViewController* root =
      [[UIApplication sharedApplication].keyWindow rootViewController];
  [root dismissViewControllerAnimated:YES completion:nil];
}

@end

void Facebook::login() {
  FBSDKLoginManager* login = [[FBSDKLoginManager alloc] init];
  login.loginBehavior = FBSDKLoginBehaviorNative;
  [login logInWithReadPermissions:nil
               fromViewController:nil
                          handler:^(FBSDKLoginManagerLoginResult* result,
                                    NSError* err) {
                            if (err) {
                              QString what = "Facebook::login failed: ";
                              what += QString::fromNSString(
                                  [err localizedDescription]);
                              emit error(what);
                            } else if (result.isCancelled) {
                              emit error("Facebook::login cancelled");
                            } else {
                              NSString* token =
                                  [[FBSDKAccessToken currentAccessToken]
                                      tokenString];
                              emit tokenReady(QString::fromNSString(token));
                            }
                          }];
}

void Google::login() {
  g_google = this;
  [GIDSignIn sharedInstance].clientID = @GOOGLE_CLIENT_ID;
  [[GIDSignIn sharedInstance] signIn];
}
