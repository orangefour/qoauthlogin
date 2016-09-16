#include "google.h"

Google::Google(QObject* parent)
  : QObject(parent) {
}

#ifndef Q_OS_IOS
void Google::login() {
  emit error("NOT IMPLEMENTED");
}
#endif
