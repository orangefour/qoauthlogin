#include "google.h"
#ifdef Q_OS_ANDROID
#include <QtAndroidExtras>
#endif

Google::Google(QObject* parent)
  : QObject(parent) {
}

#ifndef Q_OS_IOS
void Google::login() {
#ifdef Q_OS_ANDROID
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
#else
  emit error("NOT IMPLEMENTED");
#endif
}
#endif
