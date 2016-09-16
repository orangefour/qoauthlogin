#include "facebook.h"

Facebook::Facebook(QObject* parent)
  : QObject(parent) {
}

#ifndef Q_OS_IOS
void Facebook::login() {
  emit error("NOT IMPLEMENTED");
}
#endif
