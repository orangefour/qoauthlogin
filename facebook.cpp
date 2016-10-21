#include "facebook.h"
#include <QtGlobal>

Facebook::Facebook(QObject* parent)
  : QObject(parent) {
}

#if !defined(Q_OS_IOS) && !defined(Q_OS_ANDROID)
void Facebook::login() {
  emit error("NOT IMPLEMENTED");
}
#endif
