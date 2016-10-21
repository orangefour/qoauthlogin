#include "google.h"
#include <QtGlobal>

Google::Google(QObject* parent)
  : QObject(parent) {
}

#if !defined(Q_OS_IOS) && !defined(Q_OS_ANDROID)
void Google::login() {
  emit error("NOT IMPLEMENTED");
}
#endif
