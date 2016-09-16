#include "facebook.h"
#include "google.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

int main(int argc, char* argv[]) {
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QGuiApplication app(argc, argv);

  qmlRegisterType<Google>("orangefour.qoauthlogin", 1, 0, "Google");
  qmlRegisterType<Facebook>("orangefour.qoauthlogin", 1, 0, "Facebook");

  QQmlApplicationEngine engine;
  engine.load(QUrl(QLatin1String("qrc:/main.qml")));

  return app.exec();
}
