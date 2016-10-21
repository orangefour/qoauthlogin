INCLUDEPATH += $$PWD

SOURCES += \
  $$PWD/facebook.cpp \
  $$PWD/google.cpp

HEADERS += \
  $$PWD/facebook.h \
  $$PWD/google.h

ios {
  SOURCES += $$PWD/loginios.mm

  QMAKE_CXXFLAGS += \
    -F$$PWD/sdk/facebook \
    -F$$PWD/sdk/google

  QMAKE_LFLAGS += -ObjC

  LIBS += -F$$PWD/sdk/facebook \
    -framework FBSDKCoreKit \
    -framework FBSDKLoginKit \
    -F$$PWD/sdk/google \
    -framework GoogleAppUtilities \
    -framework GoogleSignIn \
    -framework GoogleAuthUtilities \
    -framework GoogleSymbolUtilities \
    -framework GoogleNetworkingUtilities \
    -framework GoogleUtilities \
    -framework AddressBook \
    -framework SafariServices \
    -framework SystemConfiguration
}

android {
  QT += androidextras
  SOURCES += $$PWD/loginandroid.cpp
}
