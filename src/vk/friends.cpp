#include "friends.h"

Friends::Friends(QObject *parent) : QObject(parent)
{}

Friends::~Friends()
{}

void Friends::setAccessToken(QString value) {
    _accessToken = value;
}

void Friends::get(int userId) {
    QUrlQuery *query = new QUrlQuery();
    query->addQueryItem("user_id", QString("%1").arg(userId));
    query->addQueryItem("order", "hints");
    query->addQueryItem("fields", "photo_50,online,status");
    ApiRequest *request = new ApiRequest();
    connect(request, SIGNAL(gotResponse(QJsonValue,ApiRequest::TaskType)),
            this, SLOT(gotResponse(QJsonValue,ApiRequest::TaskType)));
    request->setAccessToken(_accessToken);
    request->makeApiGetRequest("friends.get", query, ApiRequest::FRIENDS_GET);
}

void Friends::getOnline(int userId) {

}

void Friends::getMutual(int userId) {

}

void Friends::gotResponse(QJsonValue value, ApiRequest::TaskType type) {
    switch (type) {
    case ApiRequest::FRIENDS_GET:
        QList<QObject*> friendsList;
        QJsonArray friends = value.toObject().value("items").toArray();
        for (int index = 0; index < friends.size(); ++index) {
            QJsonObject friendItem = friends.at(index).toObject();
            friendsList.append(Friend::fromJsonObject(friendItem));
        }
        emit gotFriendsList(friendsList);
        break;
    }
}
