#ifndef DIALOGSMODEL_H
#define DIALOGSMODEL_H

#include "vqk/MessagesApi.h"
#include "vqk/UsersApi.h"
#include "vqk/User.h"

#include <QAbstractListModel>

using namespace VQK;

class DialogsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum DialogsRoles {
        AuthorRole = Qt::UserRole + 1,
        MessageRole,
        ImageRole,
        TimeRole
    };

    DialogsModel();
    ~DialogsModel();
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;
private slots:
    void updateDialogs(QList<Dialog*> dialogs);
    void updateChatInfo(Chat* chat);
    void updateUserInfo(User* user);
private:
    QString truncate(QString string, int length) const;
    MessagesApi *m_messagesApi;
    UsersApi *m_usersApi;
    QList<Dialog*> m_dialogs;
    QMap<uint, User*> m_users;
};

#endif // DIALOGSMODEL_H
