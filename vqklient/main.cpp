/**
 * This file is part of VQKlient.
 * VQK is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * Copyright (C) 2015 Mikhail Ivchenko <ematirov@gmail.com>
**/

#include "vqk/Api.h"

#include "DialogsModel.h"

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    qmlRegisterType<DialogsModel>("VQKlient",0,1,"DialogsModel");
    VQK::Api api;

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
