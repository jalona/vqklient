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
import VQKlient 0.1
//import Material.Transitions 0.1 as Transitions
//import QtQuick.Controls 1.3

Controls.ApplicationWindow {
    id: appWindow
    title: qsTr("VQKlient")
    width: 360
    height: 640
    minimumWidth: 270
    minimumHeight: 270
    visible: true
    color: Material.Theme.backgroundColor

    toolBar: Material.Toolbar {
        id: toolbar
        width: parent.width
        backgroundColor: Theme.primaryColor
        Material.IconButton{
            id: backAction
            name: "navigation/arrow_back"
            color: "white"
            size: Material.units.dp(36)
            anchors.margins: Material.units.dp(10)
            anchors.left: parent.left
            opacity: 0.0
            anchors.verticalCenter: parent.verticalCenter
            states: [
                State {
                    name: "visible"
                    PropertyChanges {
                        target: backAction
                        opacity: 1.0
                        scale: 1.0
                        visible: true
                    }
                },
                State {
                    name: "invisible"
                    PropertyChanges {
                        target: backAction
                        opacity: 0.0
                        scale: 0.0
                    }
                }

            ]
            state: "invisible"
            transitions: visibilityTransition

            Transition {
                id: visibilityTransition
                NumberAnimation{
                    properties: "opacity,scale";
                    duration: 300;
                    easing.type: Easing.OutCubic
                    onStopped: {
                        if ( backAction.state == "invisible" ) {
                            backAction.visible = false;
                        }
                    }
                }
            }

            onTriggered: {
                dialogView.hide()
                backAction.state = "invisible"
            }
        }
    }

    DialogsModel {
        id: dialogsModel
    }

    Rectangle {
        id: mainCard
        anchors.fill: parent

        function showDialog(dialogDelegate) {
            var coords = mapFromItem(dialogDelegate, 0, 0);
            dialogView.setDialog(dialogDelegate)
            dialogView.dialog = dialogDelegate
            dialogView.fromX = coords.x
            dialogView.fromY = coords.y;
            dialogView.x = coords.x;
            dialogView.y = coords.y;
            dialogView.fromWidth = dialogDelegate.width
            dialogView.fromHeight = dialogDelegate.height
            dialogView.width = dialogDelegate.width
            dialogView.height = dialogDelegate.height
            backAction.state = "visible";
            dialogView.show();
        }

        DialogView {
            id: dialogView
            visible: false
            z: 2
            toWidth: parent.width
            toHeight: parent.height
            fromX: mainCard.mapFromItem(dialog, 0, 0).x
            fromY: mainCard.mapFromItem(dialog, 0, 0).y
            fromHeight: dialog.height
            fromWidth: dialog.width
        }

        Item{
            id: mainView
            anchors.fill: parent

            ListView {
                id: dialogsView
                anchors.fill: parent
                model: dialogsModel
                spacing: Material.units.dp(0)

                delegate: Message {
                    id: dialogDelegate
                    time: model.time
                    author: model.author
                    message: model.message
                    image: model.image
                    anchors.left: parent.left
                    anchors.right: parent.right
                    onClicked: {
                        mainCard.showDialog(dialogDelegate)
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        units.pixelDensity = Qt.binding( function() { return Screen.pixelDensity } );
        Device.type = Qt.binding( function () {
            var diagonal = Math.sqrt(Math.pow((Screen.width/Screen.pixelDensity), 2) + Math.pow((Screen.height/Screen.pixelDensity), 2)) * 0.039370;
            if (diagonal >= 3.5 && diagonal < 5) { //iPhone 1st generation to phablet
                units.multiplier = 1;
                return Device.phone;
            } else if (diagonal >= 5 && diagonal < 6.5) {
                units.multiplier = 1;
                return Device.phablet;
            } else if (diagonal >= 6.5 && diagonal < 10.1) {
                units.multiplier = 1;
                return Device.tablet;
            } else if (diagonal >= 10.1 && diagonal < 29) {
                return Device.desktop;
            } else if (diagonal >= 29 && diagonal < 92) {
                return Device.tv;
            } else {
                return Device.unknown;
            }
        } );
    }
}
