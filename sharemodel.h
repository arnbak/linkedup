#ifndef SHAREMODEL_H
#define SHAREMODEL_H

#include <QObject>
#include <QAbstractListModel>

class ShareModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ShareModel(QObject *parent = 0);

signals:

public slots:

};

#endif // SHAREMODEL_H
