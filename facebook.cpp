#include "facebook.h"
#ifdef Q_OS_ANDROID
#include <QtAndroidExtras>
#endif

Facebook::Facebook(QObject* parent)
  : QObject(parent) {
}

#ifndef Q_OS_IOS
void Facebook::login() {
#ifdef Q_OS_ANDROID
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
#else
  emit error("NOT IMPLEMENTED");
#endif
}
#endif
