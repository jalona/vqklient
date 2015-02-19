#include "DialogsModel.h"

#include <QDebug>

DialogsModel::DialogsModel()
{
    m_messagesApi = new MessagesApi();
    m_usersApi = new UsersApi();
    Config *config = new Config;
    config->setToken("token");
    config->setSecret("secret");
    config->setHttpsEnabled(false);
    m_messagesApi->setConfig(config);
    m_usersApi->setConfig(config);
    connect(m_messagesApi, SIGNAL(dialogsFetched(QList<Dialog*>)), this, SLOT(updateDialogs(QList<Dialog*>)));
    connect(m_messagesApi, SIGNAL(chatInfoFetched(Chat*)), this, SLOT(updateChatInfo(Chat*)));
    connect(m_usersApi, SIGNAL(userInfoFetched(User*)), this, SLOT(updateUserInfo(User*)));
    m_messagesApi->getDialogs(0,20,20);
}

DialogsModel::~DialogsModel()
{
    disconnect(m_messagesApi, SIGNAL(dialogsFetched(QList<Dialog*>)), this, SLOT(updateDialogs(QList<Dialog*>)));
    delete m_messagesApi;
    for(int i=0; i<m_dialogs.size(); ++i) {
        delete m_dialogs[i];
    }
}

int DialogsModel::rowCount(const QModelIndex &parent) const
{
    if( parent == QModelIndex() ) {
        return m_dialogs.count();
    } else {
        return 0;
    }
}

QVariant DialogsModel::data(const QModelIndex &index, int role) const
{
    if( index.isValid() && index.row() >= 0 && index.row() < m_dialogs.size() ) {
        Dialog* dialog =  m_dialogs.at(index.row());
        if(role == AuthorRole) {
            if(dialog->message()->chat()!=0) {
                return truncate(dialog->message()->chat()->title(),30);
            }
            if(m_users.contains(dialog->message()->userId())) {
                User* user = m_users[dialog->message()->userId()];
                return truncate(user->firstName() + " " + user->lastName(),30);
            }
            return "";
        } else if (role == MessageRole) {
            return dialog->message()->body();
        } else if (role == ImageRole) {
            if(dialog->message()->chat()!=0) {
                return dialog->message()->chat()->photo();
            }
            if(m_users.contains(dialog->message()->userId())) {
                return m_users[dialog->message()->userId()]->photo();
            }
            return "http://vk.com/images/camera_a.gif";
        } else if (role == TimeRole) {
            QDateTime messageDate = dialog->message()->date();
            if( messageDate.date() == QDateTime::currentDateTime().date() ) {
                return messageDate.time().toString("hh:mm");
            }
            return messageDate.toString("dd MMM");
        }
    }
    return QVariant();
}

QHash<int, QByteArray> DialogsModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[AuthorRole]="author";
    roles[MessageRole]="message";
    roles[ImageRole]="image";
    roles[TimeRole]="time";
    return roles;
}

void DialogsModel::updateDialogs(QList<Dialog *> dialogs)
{
    beginRemoveRows(QModelIndex(),0,rowCount(QModelIndex())-1);
    for(int i=0; i<m_dialogs.size(); ++i) {
        delete m_dialogs[i];
    }
    m_dialogs.clear();
    endRemoveRows();
    beginInsertRows(QModelIndex(),0,dialogs.count()-1);
    m_dialogs = dialogs;
    endInsertRows();
    QStringList userIds;
    for(int i=0; i<m_dialogs.size(); ++i) {
        if(m_dialogs[i]->message()->chat() != 0) {
            m_messagesApi->getChat(m_dialogs[i]->message()->chat()->id());
        } else {
            userIds.append(QString::number(m_dialogs[i]->message()->userId()));
        }
    }
    if(!userIds.isEmpty()) {
        m_usersApi->get(userIds,QStringList("photo_200"));
    }
}

void DialogsModel::updateChatInfo(Chat *chat)
{
    for(int i=0; i<m_dialogs.size(); ++i) {
        Dialog* dialog = m_dialogs[i];
        if( dialog->message()->chat() != 0 && dialog->message()->chat()->id() == chat->id() ) {
            dialog->message()->setChat( chat );
            QModelIndex updatedItemIndex = createIndex(i,0,dialog);
            emit dataChanged(updatedItemIndex,updatedItemIndex);
            break;
        }
    }
}

void DialogsModel::updateUserInfo(User *user)
{
    m_users[user->id()]=user;
    for(int i=0; i<m_dialogs.size(); ++i) {
        Dialog* dialog = m_dialogs[i];
        if( dialog->message()->userId() == user->id() && dialog->message()->chat() == 0 ) {
            QModelIndex updatedItemIndex = createIndex(i,0,dialog);
            emit dataChanged(updatedItemIndex,updatedItemIndex);
            break;
        }
    }
}

QString DialogsModel::truncate(QString string, int length) const
{
    if(string.length()>length) {
        string.truncate(length-3);
        if(string.endsWith(" ")) {
            string.truncate(length-4);
        }
        string.append("...");
    }
    return string;
}

