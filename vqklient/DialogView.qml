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

import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2
import QtQuick.Controls 1.3 as Controls
import Material 0.1 as Material
import Material 0.1
//import QtQuick.Controls 1.3

Rectangle{
    id: dialogView
    property var dialog: Message{}
    property alias fromWidth: expandAnimation.fromWidth
    property alias toWidth: expandAnimation.toWidth
    property alias fromHeight: expandAnimation.fromHeight
    property alias toHeight: expandAnimation.toHeight
    property alias fromX: expandAnimation.fromX
    property alias toX: expandAnimation.toX
    property alias fromY: expandAnimation.fromY
    property alias toY: expandAnimation.toY
    property alias opened: expandAnimation.opened

    ExpandAnimation {
        id: expandAnimation
        target: dialogView
    }

    ListModel{
        id: messagesModel
    }

    ListView{
        id: messagesView
        anchors.fill: parent
        verticalLayoutDirection: ListView.BottomToTop
        model: messagesModel
        spacing: 0
        delegate: Message{
            id: dialogDelegate
            image: model.image
            time: model.time
            author: model.author
            message: model.message
            anchors.left: parent.left
            anchors.right: parent.right
            onClicked: dialogView.add()
            ListView.onAdd: {
                scale = 0;
                scaleAnim.start();
            }
            NumberAnimation{target: dialogDelegate; id: scaleAnim; properties: "scale"; from: 0; to: 1.0; duration: messagesView.duration; easing.type: Easing.OutCubic }
        }
        property double duration: 300
        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: messagesView.duration; easing.type: Easing.OutCubic }
        }
    }
    function show() {
        if( !opened ) {
            dialogView.visible = true;
            expandAnimation.start();
        }
    }
    function hide() {
        if( opened ) {
            dialogView.anchors.fill = null
            if( messagesModel.count>1 ) {
                messagesModel.remove(1, messagesModel.count - 1)
            }
            dialogView.dialog.image = messagesModel.get(0).image;
            dialogView.dialog.author = messagesModel.get(0).author;
            dialogView.dialog.message = messagesModel.get(0).message;
            dialogView.dialog.time = messagesModel.get(0).time;
            expandAnimation.start();
        }
    }
    function setDialog(dialog){
        messagesModel.clear()
        messagesView.model = {}
        messagesModel.append({'image':dialog.image,'author':dialog.author,'message':dialog.message,'time':dialog.time});
        messagesView.model = messagesModel
    }
    function add() {
        messagesModel.insert(0,{'image':"http://vk.com/images/camera_b.gif",'author':"12345",'message':String(Math.random()) ,'time':Qt.formatDateTime(new Date(), "hh:mm:ss")});
    }
}
