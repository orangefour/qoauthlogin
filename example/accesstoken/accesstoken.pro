QT += qml quick

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc

DEFINES += GOOGLE_CLIENT_ID=\\\"111yourapp111client11id.apps.googleusercontent.com\\\"

include(../../qoauthlogin.pri)

ios {
  QMAKE_INFO_PLIST = Info.plist
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
