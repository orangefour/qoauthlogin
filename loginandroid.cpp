#include "google.h"
#include "facebook.h"
#include <jni.h>
#include <QtAndroidExtras>

Facebook* g_facebook = nullptr;
Google* g_google = nullptr;

#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT void JNICALL
  Java_at_metr_app_MyJavaNatives_googleTokenReady(JNIEnv* env,
                                                  jobject /*obj*/,
                                                  jstring token) {
  QString qstr(env->GetStringUTFChars(token, 0));
  if (g_google) {
    emit g_google->tokenReady(qstr);
  }
}

JNIEXPORT void JNICALL
  Java_at_metr_app_MyJavaNatives_facebookTokenReady(JNIEnv* env,
                                                    jobject /*obj*/,
                                                    jstring token) {
  QString qstr(env->GetStringUTFChars(token, 0));
  if (g_facebook) {
    emit g_facebook->tokenReady(qstr);
  }
}

#ifdef __cplusplus
}
#endif


void Facebook::login() {
  g_facebook = this;
  QtAndroid::runOnAndroidThread([] {
    QAndroidJniObject activity = QtAndroid::androidActivity();
    if (activity.isValid()) {
      activity.callMethod<void>("doFacebookLogin", "()V");
    }
    QAndroidJniEnvironment env;
    if (env->ExceptionCheck()) {
      env->ExceptionClear();
    }
  });
}

void Google::login() {
  g_google = this;
  QtAndroid::runOnAndroidThread([] {
    QAndroidJniObject activity = QtAndroid::androidActivity();
    if (activity.isValid()) {
      activity.callMethod<void>("doGoogleLogin", "()V");
    }
    QAndroidJniEnvironment env;
    if (env->ExceptionCheck()) {
      env->ExceptionClear();
    }
  });
}
