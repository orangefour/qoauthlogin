#pragma once
#include <QObject>

class Google : public QObject {
  Q_OBJECT
public:
  Google(QObject* parent = nullptr);

signals:
  void tokenReady(const QString& token);
  void error(const QString& what);

public slots:
  void login();
};
