#pragma once
#include <QObject>

class Facebook : public QObject {
  Q_OBJECT
public:
  Facebook(QObject* parent = nullptr);

signals:
  void tokenReady(const QString& token);
  void error(const QString& what);

public slots:
  void login();
};
