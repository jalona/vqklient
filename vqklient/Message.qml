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

Item {  //Uncomment for slow devices.
//Material.Card { //Uncomment for fast devices.
    id: messageDelegate
    height: Material.units.dp(72)

    property string image
    property string author
    property string message
    property string time

    signal clicked()

// Comment fot if using Material.Card instead of Item.
    Material.ThinDivider {
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0

        visible: true
    }
// End.

    Material.Ink {
        id: ink
        anchors.fill: parent
        onClicked: messageDelegate.clicked()
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: Material.units.dp(10)

        RowLayout {
            spacing: Material.units.dp(10)
            Layout.alignment: Qt.AlignLeft

            Image{
                source: messageDelegate.image
                sourceSize.height: messageDelegate.height - Material.units.dp(20)
                sourceSize.width: messageDelegate.height
            }

            ColumnLayout{
                Layout.alignment: Qt.AlignLeft
                RowLayout{
                    Controls.Label{
                        id: authorLabel
                        Layout.alignment: Qt.AlignLeft
                        text: messageDelegate.author
                    }
                    Item{
                        Layout.fillWidth: true
                    }
                    Controls.Label{
                        //TODO: fix time label on small screens.
                        id: timeLabel
                        text: messageDelegate.time
                        font.weight: Font.Light
                    }
                }
                RowLayout{
                    Controls.Label{
                        id: messageLabel
                        Layout.alignment: Qt.AlignLeft
                        text: messageDelegate.message
                    }

                    Item{
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
